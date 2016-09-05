#!/usr/bin/env python
import os

from agithub.base import API, Client, ConnectionProperties
from agithub.GitHub import GitHub

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.log
import tornado.web


tornado.log.enable_pretty_logging()


class Dockerhub(API):
    def __init__(self, *args, **kwargs):
        props = ConnectionProperties(
            api_url='registry.hub.docker.com',
            url_prefix='/v2',
            secure_http=True)

        self.setClient(Client(*args, **kwargs))
        self.setConnectionProperties(props)


dockerhub = Dockerhub(token=os.environ.get('DOCKERHUB_TOKEN'))
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
        repos.add(repo.strip('docker-'))

    for repo in repos:
        code, body = dockerhub.repositories[username][repo].get()
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


class ProjectHandler(RequestHandler):
    def get(self, username, repo):
        code, body = github.repos[username][repo].get()
        if code != 200:
            self.set_status(code)
            self.finish(body)
            return

        latest, ahead_by = get_github_tags(username, repo)
        body['latest'], body['ahead_by'] = latest, ahead_by

        deploy_url, deploy_stars, deploy_pulls = get_dockerhub(username, repo)
        body['deploy_url'] = deploy_url
        body['deploy_stars'] = deploy_stars
        body['deploy_pulls'] = deploy_pulls

        status_url, status_image = get_circleci(username, body['name'],
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
        (r'/([\w-]+)/([\w-]+)/?', ProjectHandler),
    ], debug=True)

    http_server = tornado.httpserver.HTTPServer(application)
    http_server.listen(port)

    tornado.ioloop.IOLoop.current().start()


if __name__ == '__main__':
    main(port=8888)
