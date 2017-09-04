from server import RequestHandler


class DockerHubPullsHandler(RequestHandler):
    def get(self, username, repo):
        url = 'https://hub.docker.com/r/{}/{}'.format(username, repo)
        image = ('https://img.shields.io/docker/pulls/'
                 '{}/{}.svg').format(username, repo)

        self.write({'url': url, 'image': image})


class DockerHubStarsHandler(RequestHandler):
    def get(self, username, repo):
        url = 'https://hub.docker.com/r/{}/{}'.format(username, repo)
        image = ('https://img.shields.io/docker/stars/'
                 '{}/{}.svg').format(username, repo)

        self.write({'url': url, 'image': image})
