#!/usr/bin/env python3
import asyncio
import tornado.httpserver
import tornado.ioloop
import tornado.log
import tornado.platform.asyncio
import tornado.web

from .draw import DrawHandler
from .link import LinkHandler
from .ping import PingHandler
from .project import ProjectHandler
from .resource import ResourceHandler
from .usage import UsageHandler


def main():
    tornado.log.enable_pretty_logging()
    tornado.platform.asyncio.AsyncIOMainLoop().install()

    app = tornado.web.Application([
        (r'/(ping)?', PingHandler),

        (r'/draw', DrawHandler),

        (r'/link/(\d+)', LinkHandler),
        (r'/project/(\d+)', ProjectHandler),
        (r'/resource/(\d+)', ResourceHandler),
        (r'/usage/(\d+)', UsageHandler),
    ], debug=True)
    app.listen(80)

    loop = asyncio.get_event_loop()
    loop.run_forever()


if __name__ == '__main__':
    main()
