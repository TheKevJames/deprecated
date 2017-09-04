import requests

from ..common.values import Status


API_URL = 'https://api.uptimerobot.com/v2/getMonitors'
DATA = 'api_key={}&format=json'
HEADERS = {
    'Cache-Control': 'no-cache',
    'Content-Type': 'application/x-www-form-urlencoded',
}

STATUS_MAP = {
    0: Status.YELLOW,  # paused
    1: Status.YELLOW,  # not checked yet
    2: Status.GREEN,  # up
    8: Status.YELLOW,  # seems down
    9: Status.RED,  # down
}


def get_uptime_status(token):
    data = DATA.format(token)

    resp = requests.post(API_URL, headers=HEADERS, data=data)
    if resp.status_code != 200:
        return {'status': Status.RED}

    return {'status': STATUS_MAP[resp.json()['monitors'][0]['status']]}
