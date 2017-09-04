from server import RequestHandler


class CircleCIHandler(RequestHandler):
    def get(self, username, repo):
        # TODO: customize
        branch = 'master'

        url = 'https://circleci.com/gh/{}/{}'.format(username, repo)
        image = ('https://img.shields.io/circleci/project/github/'
                 '{}/{}/{}.svg').format(username, repo, branch)

        self.write({'url': url, 'image': image})
