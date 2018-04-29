from server import RequestHandler


# TODO: vanity.count_downloads(repo, verbose=False)
class PyPIHandler(RequestHandler):
    def get(self, name):
        url = 'https://pypi.python.org/pypi/{}'.format(name)
        image = 'https://img.shields.io/pypi/v/{}.svg'.format(name)

        self.write({'url': url, 'image': image})
