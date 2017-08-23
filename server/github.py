import os

from agithub.GitHub import GitHub

from server import RequestHandler


try:
    GITHUB_TOKEN = open('/run/secrets/github_token').read().rstrip()
except FileNotFoundError:
    GITHUB_TOKEN = os.environ['GITHUB_TOKEN']
    if not GITHUB_TOKEN:
        raise


client = GitHub(token=GITHUB_TOKEN)


def get_github_tags(username, repo):
    code, body = client.repos[username][repo].tags.get()
    if code != 200 or not body:
        return 'master', 0

    latest = body[0]['name']
    sha = body[0]['commit']['sha']
    diff = '{}...master'.format(sha)

    code, body = client.repos[username][repo].compare[diff].get()
    if code != 200:
        return 'master', 0

    return latest, body['ahead_by']


class GithubHandler(RequestHandler):
    def get(self, username, repo):
        code, body = client.repos[username][repo].get()
        if code != 200:
            self.set_status(code)
            self.finish(body)
            return

        # TODO: split body['open_issues_count'] into issues and PRs

        latest, ahead_by = get_github_tags(username, repo)
        body['latest'], body['ahead_by'] = latest, ahead_by

        self.write({'repo': body})
