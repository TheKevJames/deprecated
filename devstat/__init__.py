import flask

import devstat.api as api
import devstat.config as config
import devstat.server as server


@server.app.route('/')
def index():
    user = config.username

    repos = config.repos or [x['name'] for x in api.get_all_repos(user)]
    repos = [r for r in repos if r not in config.status.get('hide', list())]
    repos = [api.get_repo(user, x) for x in repos]

    for r in config.status.get('circleci', list()):
        try:
            repo = [x for x in repos if x['name'] == r][0]
        except IndexError:
            # print 'No repo found for circleci config: {}'.format(r)
            continue

        url = 'https://circleci.com/gh/{}/{}'.format(user, repo['name'])
        repo['status_url'] = url
        repo['status_image'] = '{}/tree/{}.svg?style=svg'.format(
            url, repo['default_branch'])

    for r in config.deploy.get('hub.docker', list()):
        try:
            gname, dname = r.keys()[0], r.values()[0]
        except AttributeError:
            gname, dname = r, r

        try:
            repo = [x for x in repos if x['name'] == gname][0]
        except IndexError:
            # print 'No repo found for hub.docker config: {}'.format(gname)
            continue

        try:
            duser, dname = dname.split('/')
        except ValueError:
            duser = user
        duser = duser.lower()

        docker = api.get_docker(duser, dname)
        repo['deploy_url'] = 'https://hub.docker.com/r/{}/{}/'.format(
            duser, dname)
        repo['deploy_stars'] = docker['star_count']
        repo['deploy_pulls'] = docker['pull_count']

    return flask.render_template(
        flask.url_for('static', filename='index.html'), username=user,
        repos=repos)
