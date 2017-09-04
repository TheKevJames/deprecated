from server import RequestHandler


# TODO: bad shields result?
class URLHandler(RequestHandler):
    def get(self, url):
        image = ('https://img.shields.io/website-up-down-green-red/'
                 '{}.svg?label={}').format(url.replace('://', '/'), url)

        self.write({'url': url, 'image': image})
