import google.cloud.datastore

from .common.values import Status
from .server import RequestHandler
from .status.postgres import get_pg_status


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
            data = {
                'id': entity.key.path[0]['id'],
                'kind': entity['kind'],
                'name': entity['name'],
                'status': Status.UNKNOWN
            }

            if entity['kind'] == 'postgres':
                data.update(await get_pg_status(entity['url']))

            response['data'].append(data)

        self.write(response)
