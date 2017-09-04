import google.cloud.datastore

from .server import RequestHandler
from .status.values import Status


GC_KIND_USAGE = 'DevstatUsage'
GC_KIND_WORKSPACES = 'DevstatWorkspace'
GC_PROJECT = 'thekevjames-175823'


class UsageHandler(RequestHandler):
    def get(self, wid):
        response = {'data': list()}

        client = google.cloud.datastore.Client(GC_PROJECT)
        query = client.query(kind=GC_KIND_USAGE)
        wkey = client.key(GC_KIND_WORKSPACES, int(wid))
        query.add_filter('workspace', '=', wkey)
        for entity in query.fetch():
            status = Status.UNKNOWN

            response['data'].append({
                'id': entity.key.path[0]['id'],
                'project': entity['project'].path[0]['id'],
                'resource': entity['resource'].path[0]['id'],
                'status': status,
            })

        self.write(response)
