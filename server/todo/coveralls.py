from server import RequestHandler


class CoverallsHandler(RequestHandler):
    def get(self, username, repo):
        # TODO: customize
        branch = 'master'

        url = 'https://coveralls.io/github/{}/{}'.format(username, repo)
        image = ('https://img.shields.io/coveralls/'
                 '{}/{}/{}.svg').format(username, repo, branch)

        self.write({'url': url, 'image': image})
