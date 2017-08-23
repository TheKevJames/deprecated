from server import RequestHandler


class PingHandler(RequestHandler):
    def get(self, _ping=None):
        self.write('ok')
