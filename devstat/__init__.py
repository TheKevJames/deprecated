import flask

import devstat.api as api
import devstat.config as config
import devstat.server as server


@server.app.route('/')
def index():
    user = config.username

    repos = config.repos or [x['name'] for x in api.get_all_repos(user)]
    repos = [api.get_repo(user, x) for x in repos]

    for r in config.status.get('circleci', list()):
        repo = [x for x in repos if x['name'] == r][0]
        if not repo:
            continue

        url = 'https://circleci.com/gh/{}/{}'.format(user, repo['name'])
        repo['status_link'] = url
        repo['status_url'] = '{}/tree/{}.svg?style=svg'.format(
            url, repo['default_branch'])

    for r in config.deploy.get('hub.docker', list()):
        try:
            gname, dname = r.keys()[0], r.values()[0]
        except AttributeError:
            gname, dname = r, r

        print gname, dname

    return flask.render_template(
        flask.url_for('static', filename='index.html'), username=user,
        repos=repos)
