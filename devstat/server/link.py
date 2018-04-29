import google.cloud.datastore

from .common.values import Status
from .server import RequestHandler


GC_KIND_LINK = 'DevstatLink'
GC_KIND_WORKSPACES = 'DevstatWorkspace'
GC_PROJECT = 'thekevjames-175823'


class LinkHandler(RequestHandler):
    def get(self, wid):
        response = {'data': list()}

        client = google.cloud.datastore.Client(GC_PROJECT)
        query = client.query(kind=GC_KIND_LINK)
        wkey = client.key(GC_KIND_WORKSPACES, int(wid))
        query.add_filter('workspace', '=', wkey)
        for entity in query.fetch():
            status = Status.UNKNOWN

            response['data'].append({
                'from': entity['from'].path[0]['id'],
                'id': entity.key.path[0]['id'],
                'kind': entity['kind'],
                'name': entity['name'],
                'status': status,
                'to': entity['to'].path[0]['id'],
            })

        self.write(response)
