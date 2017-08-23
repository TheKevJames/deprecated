from server import RequestHandler


# TODO: replace URLHandler?
class UptimeRobotHandler(RequestHandler):
    def get(self, token):
        image = ('https://img.shields.io/uptimerobot/ratio/7/'
                 '{}.svg').format(token)

        self.write({'image': image})
