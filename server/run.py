#!/usr/bin/env python3
import tornado.httpserver
import tornado.ioloop
import tornado.log
import tornado.web

from circleci import CircleCIHandler
from coveralls import CoverallsHandler
from dockerhub import DockerHubPullsHandler
from dockerhub import DockerHubStarsHandler
from github import GithubHandler
from ping import PingHandler
from puppetforge import PuppetForgeDownloadsHandler
from puppetforge import PuppetForgeScoreHandler
from puppetforge import PuppetForgeVersionHandler
from pypi import PyPIHandler
from travis import TravisHandler
from uptimerobot import UptimeRobotHandler
from url import URLHandler


def run_server():
    app = tornado.web.Application([
        (r'/(ping)?', PingHandler),
        (r'/circleci/([\w-]+)/([\.\w-]+)/?', CircleCIHandler),
        (r'/coveralls/([\w-]+)/([\.\w-]+)/?', CoverallsHandler),
        (r'/dockerhub/pulls/([\w-]+)/([\.\w-]+)/?', DockerHubPullsHandler),
        (r'/dockerhub/stars/([\w-]+)/([\.\w-]+)/?', DockerHubStarsHandler),
        (r'/github/([\w-]+)/([\.\w-]+)/?', GithubHandler),
        (r'/puppetforge/downloads/([\w-]+)/([\.\w-]+)/?',
         PuppetForgeDownloadsHandler),
        (r'/puppetforge/score/([\w-]+)/([\.\w-]+)/?', PuppetForgeScoreHandler),
        (r'/puppetforge/version/([\w-]+)/([\.\w-]+)/?',
         PuppetForgeVersionHandler),
        (r'/pypi/([\.\w-]+)/?', PyPIHandler),
        (r'/travis/([\w-]+)/([\.\w-]+)/?', TravisHandler),
        (r'/uptimerobot/([\w-]+)/?', UptimeRobotHandler),
        (r'/url/(.+)/?', URLHandler),
    ], debug=True)

    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(80)

    tornado.ioloop.IOLoop.current().start()


if __name__ == '__main__':
    tornado.log.enable_pretty_logging()

    run_server()
