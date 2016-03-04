import devstat.server as server


def memoize(f):
    """ Memoization decorator for a function taking one or more arguments. """
    class memodict(dict):
        def __getitem__(self, *key):
            return dict.__getitem__(self, key)

        def __missing__(self, key):
            ret = self[key] = f(*key)
            return ret

    return memodict().__getitem__


@memoize
def get_all_repos(username):
    response = server.github.users[username].repos.get(per_page=99999)
    if response[0] != 200:
        # TODO: error handling
        raise Exception(response[1])

    return response[1]


@memoize
def get_repo(username, repo):
    response = server.github.repos[username][repo].get()
    if response[0] != 200:
        # TODO: error handling
        raise Exception(repo, response[1])

    return response[1]
