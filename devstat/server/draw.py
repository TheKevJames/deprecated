import svgwrite

from .server import RequestHandler


def status_to_color(status):
    if str(status) == '1':
        return 'green'
    if str(status) == '2':
        return 'yellow'
    if str(status) == '3':
        return 'red'

    return '#C0C0C0'


class DrawHandler(RequestHandler):
    def get(self):
        issues_count = self.get_query_argument('issues.count', default=None)
        issues_status = self.get_query_argument('issues.status', default=None)
        name = self.get_query_argument('name')
        pulls_count = self.get_query_argument('pulls.count', default=None)
        pulls_status = self.get_query_argument('pulls.status', default=None)
        status = self.get_query_argument('status')

        height = 60
        width = 100

        div = svgwrite.Drawing(profile='tiny', size=(width, height))
        # status
        color = status_to_color(status)
        div.add(div.rect((0, 0), (width, height / 2), fill=color))

        # name
        div.add(div.text(name, insert=(10, 20)))

        # issues
        color = status_to_color(issues_status)
        issues = div.add(div.path(d='M7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-3.14 2.56-5.7 5.7-5.7zM7 1C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm1 3H6v5h2V4zm0 6H6v2h2v-2z'))
        issues.translate(tx=0, ty=height / 2)
        issues.scale(1.85)

        # div.add(div.circle((height / 4, height * 3 / 4), height / 4,
        #                    fill='red'))


        stroke = svgwrite.rgb(10, 10, 16, '%')
        div.add(div.line((0, height / 2), (width, height / 2), stroke=stroke))
        div.add(div.line((0, height), (width, height), stroke=stroke))

        div.add(div.line((0, height / 2), (0, height), stroke=stroke))
        div.add(div.line((width, height / 2), (width, height), stroke=stroke))


        self.set_header('Content-Type', 'image/svg+xml')
        self.write(div.tostring())
