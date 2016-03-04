import requests

import devstat.server as server


def get_docker(username, repo):
    hub_url = 'https://registry.hub.docker.com'
    route = '{}/v2/repositories/{}/{}/'.format(hub_url, username, repo)

    response = requests.get(route)
    if response.status_code != 200:
        # TODO: error handling
        raise Exception(response.json())

    return response.json()


def get_all_repos(username):
    response = server.github.users[username].repos.get(per_page=99999)
    if response[0] != 200:
        # TODO: error handling
        raise Exception(response[1])

    return response[1]


def get_repo(username, repo):
    response = server.github.repos[username][repo].get()
    if response[0] != 200:
        # TODO: error handling
        raise Exception(repo, response[1])

    response[1]['tag'], response[1]['tag_off'] = get_repo_tags(username, repo)

    return response[1]


def get_repo_tags(username, repo):
    response = server.github.repos[username][repo].tags.get()
    if response[0] != 200:
        # TODO: error handling
        raise Exception(repo, response[1])

    try:
        latest = response[1][0]['name']
        sha = response[1][0]['commit']['sha']

        response = server.github.repos[username][repo].compare[
            '{}...master'.format(sha)].get()
        if response[0] != 200:
            # TODO: error handling
            raise Exception(repo, response[1])

        ahead_by = response[1]['ahead_by']
    except (AttributeError, IndexError):
        latest = 'master'
        ahead_by = 0

    return (latest, ahead_by)
