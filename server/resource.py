import google.cloud.datastore

from .server import RequestHandler
from .status.postgres import get_pg_status
from .status.values import Status


GC_KIND_RESOURCE = 'DevstatResource'
GC_KIND_WORKSPACES = 'DevstatWorkspace'
GC_PROJECT = 'thekevjames-175823'


class ResourceHandler(RequestHandler):
    async def get(self, wid):
        response = {'data': list()}

        client = google.cloud.datastore.Client(GC_PROJECT)
        query = client.query(kind=GC_KIND_RESOURCE)
        wkey = client.key(GC_KIND_WORKSPACES, int(wid))
        query.add_filter('workspace', '=', wkey)
        for entity in query.fetch():
            status = Status.UNKNOWN

            if entity['kind'] == 'postgres':
                status = await get_pg_status(entity['url'])

            response['data'].append({
                'id': entity.key.path[0]['id'],
                'kind': entity['kind'],
                'name': entity['name'],
                'status': status,
            })

        self.write(response)
