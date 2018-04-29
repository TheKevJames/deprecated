import os

from agithub.GitHub import GitHub

from ..common.values import Status


try:
    GITHUB_TOKEN = open('/run/secrets/github_token').read().rstrip()
except FileNotFoundError:
    GITHUB_TOKEN = os.environ.get('GITHUB_TOKEN')
    if not GITHUB_TOKEN:
        raise

CLIENT = GitHub(token=GITHUB_TOKEN)


def get_status_for_count(count):
    if count < 1:
        return Status.GREEN
    if count < 6:
        return Status.YELLOW
    return Status.RED


def get_github_data(username, repo):
    code, body = CLIENT.repos[username][repo].get()
    if code != 200:
        return {'issues': {'count': float('inf'), 'status': Status.UNKNOWN},
                'pulls': {'count': float('inf'), 'status': Status.UNKNOWN}}

    if not body:
        issues = 0
        pulls = 0
        return {'issues': {'count': issues,
                           'status': get_status_for_count(issues)},
                'pulls': {'count': pulls,
                          'status': get_status_for_count(pulls)}}

    issues = body['open_issues']

    code, body = CLIENT.repos[username][repo].pulls.get()
    if code != 200:
        return {'issues': {'count': issues,
                           'status': get_status_for_count(issues)},
                'pulls': {'count': float('inf'), 'status': Status.UNKNOWN}}

    pulls = len(body)
    issues -= pulls

    return {'issues': {'count': issues,
                       'status': get_status_for_count(issues)},
            'pulls': {'count': pulls, 'status': get_status_for_count(pulls)}}
