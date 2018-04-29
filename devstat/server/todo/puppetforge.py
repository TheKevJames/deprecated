from server import RequestHandler


class PuppetForgeDownloadsHandler(RequestHandler):
    def get(self, username, repo):
        url = 'https://forge.puppet.com/{}/{}'.format(username, repo)
        image = ('https://img.shields.io/puppetforge/dt/'
                 '{}/{}.svg').format(username, repo)

        self.write({'url': url, 'image': image})


class PuppetForgeScoreHandler(RequestHandler):
    def get(self, username, repo):
        url = 'https://forge.puppet.com/{}/{}'.format(username, repo)
        image = ('https://img.shields.io/puppetforge/f/'
                 '{}/{}.svg').format(username, repo)

        self.write({'url': url, 'image': image})


class PuppetForgeVersionHandler(RequestHandler):
    def get(self, username, repo):
        url = 'https://forge.puppet.com/{}/{}'.format(username, repo)
        image = ('https://img.shields.io/puppetforge/v/'
                 '{}/{}.svg').format(username, repo)

        self.write({'url': url, 'image': image})
