from server import RequestHandler


class TravisHandler(RequestHandler):
    def get(self, username, repo):
        # TODO: customize
        branch = 'master'

        url = 'https://travis-ci.org/{}/{}'.format(username, repo)
        image = ('https://img.shields.io/travis/'
                 '{}/{}/{}.svg').format(username, repo, branch)

        self.write({'url': url, 'image': image})
