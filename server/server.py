#!/usr/bin/env python
import os

# from agithub.base import API, Client, ConnectionProperties
from agithub.GitHub import GitHub

import requests

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.log
import tornado.web

import vanity


tornado.log.enable_pretty_logging()


# TODO: requests -> agithub for puppet forge
# TODO: requests -> agithub for dockerhub
# class Dockerhub(API):
#     def __init__(self, *args, **kwargs):
#         props = ConnectionProperties(
#             api_url='registry.hub.docker.com',
#             url_prefix='/v2',
#             secure_http=True)

#         self.setClient(Client(*args, **kwargs))
#         self.setConnectionProperties(props)


# dockerhub = Dockerhub(token=os.environ.get('DOCKERHUB_TOKEN'))
github = GitHub(token=os.environ.get('GITHUB_TOKEN'))


class RequestHandler(tornado.web.RequestHandler):
    def set_default_headers(self):
        self.set_header("Access-Control-Allow-Origin", "*")
        self.set_header("Access-Control-Allow-Headers", "x-requested-with")
        self.set_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')

    def options(self):
        self.set_status(204)
        self.finish()


class MainHandler(RequestHandler):
    def get(self):
        self.write('hello world')


def get_circleci(username, repo, branch):
    url = 'https://circleci.com/gh/{}/{}'.format(username, repo)
    image = '{}/tree/{}.svg?style=svg'.format(url, branch)

    return url, image


def get_dockerhub(username, repo):
    repos = {repo}
    if repo.startswith('docker-'):
        repos.add(repo[7:])

    for repo in repos:
        dockerhub = 'https://registry.hub.docker.com/v2/repositories/{}/{}'
        response = requests.get(dockerhub.format(username, repo))
        code = response.status_code
        body = response.json()
        # code, body = dockerhub.repositories[username][repo].get()
        if code != 200:
            continue

        url = 'https://hub.docker.com/r/{}/{}/'.format(username, repo)
        stars = body['star_count']
        pulls = body['pull_count']
        return url, stars, pulls

    return '', 0, 0


def get_github_tags(username, repo):
    code, body = github.repos[username][repo].tags.get()
    if code != 200 or not body:
        return 'master', 0

    latest = body[0]['name']
    sha = body[0]['commit']['sha']
    diff = '{}...master'.format(sha)

    code, body = github.repos[username][repo].compare[diff].get()
    if code != 200:
        return 'master', 0

    return latest, body['ahead_by']


def get_puppetforge(username, repo):
    repos = {repo}
    if repo.startswith('puppet-'):
        repos.add(repo[7:])

    for repo in repos:
        puppetforge = 'https://forgeapi.puppetlabs.com/v3/modules/{}-{}'
        response = requests.get(puppetforge.format(username, repo))
        code = response.status_code
        body = response.json()
        if code != 200:
            continue

        url = 'https://forge.puppet.com/{}/{}'.format(username, repo)
        pulls = body['downloads']
        return url, pulls

    return '', 0


def get_pypi(repo):
    repos = {repo}
    if repo.startswith('python-'):
        repos.add(repo[7:])
    if repo.startswith('pypi-'):
        repos.add(repo[5:])
    if repo.startswith('pip-'):
        repos.add(repo[4:])

    for repo in repos:
        pulls = vanity.count_downloads(repo, verbose=False)
        if not pulls:
            continue

        url = 'https://pypi.org/project/{}/'.format(repo)

        return url, pulls

    return '', 0


class ProjectHandler(RequestHandler):
    def get(self, username, repo):
        code, body = github.repos[username][repo].get()
        if code != 200:
            self.set_status(code)
            self.finish(body)
            return

        latest, ahead_by = get_github_tags(username, repo)
        body['latest'], body['ahead_by'] = latest, ahead_by

        username = username.lower()
        repo = repo.lower()

        url, pulls = get_puppetforge(username, repo)
        body['deploy_url'] = url
        body['deploy_pulls'] = pulls

        if not body['deploy_url']:
            url, pulls = get_pypi(repo)
            body['deploy_url'] = url
            body['deploy_pulls'] = pulls

        if not body['deploy_url']:
            url, stars, pulls = get_dockerhub(username, repo)
            body['deploy_url'] = url
            body['deploy_stars'] = stars
            body['deploy_pulls'] = pulls

        status_url, status_image = get_circleci(body['owner']['login'],
                                                body['name'],
                                                body['default_branch'])
        body['status_url'] = status_url
        body['status_image'] = status_image

        self.write({'repo': body})


class UserHandler(RequestHandler):
    def get(self, username):
        code, body = github.users[username].repos.get(per_page=99999)
        if code != 200:
            self.set_status(code)
            self.finish(body)
            return

        self.write({'repos': body})


def main(port):
    tornado.options.parse_command_line()
    application = tornado.web.Application([
        (r'/', MainHandler),
        (r'/([\w-]+)/?', UserHandler),
        (r'/([\w-]+)/([\.\w-]+)/?', ProjectHandler),
    ], debug=True)

    http_server = tornado.httpserver.HTTPServer(application)
    http_server.listen(port)

    tornado.ioloop.IOLoop.current().start()


if __name__ == '__main__':
    main(port=8880)
