import google.cloud.datastore

from .server import RequestHandler
from .status.uptimerobot import get_uptime_status
from .status.values import Status


GC_KIND_PROJECT = 'DevstatProject'
GC_KIND_WORKSPACES = 'DevstatWorkspace'
GC_PROJECT = 'thekevjames-175823'


class ProjectHandler(RequestHandler):
    def get(self, wid):
        response = {'data': list()}

        client = google.cloud.datastore.Client(GC_PROJECT)
        query = client.query(kind=GC_KIND_PROJECT)
        wkey = client.key(GC_KIND_WORKSPACES, int(wid))
        query.add_filter('workspace', '=', wkey)
        for entity in query.fetch():
            status = Status.UNKNOWN

            if entity.get('status.uptimerobot'):
                status = get_uptime_status(entity['status.uptimerobot'])

            response['data'].append({
                'id': entity.key.path[0]['id'],
                'name': entity['name'],
                'status': status,
            })

        self.write(response)
