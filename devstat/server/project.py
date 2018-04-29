import google.cloud.datastore

from .common.values import Status
from .data.github import get_github_data
from .server import RequestHandler
from .status.uptimerobot import get_uptime_status


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
            data = {
                'id': entity.key.path[0]['id'],
                'name': entity['name'],
                'status': Status.UNKNOWN
            }

            if entity.get('data.github'):
                username, repo = entity['data.github'].split('/')
                data.update(get_github_data(username, repo))

            if entity.get('status.uptimerobot'):
                data.update(get_uptime_status(entity['status.uptimerobot']))

            response['data'].append(data)

        self.write(response)
