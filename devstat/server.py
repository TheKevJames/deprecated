import os

import agithub
import flask


app = flask.Flask('DevStat', static_url_path='')
github = agithub.Github(token=os.environ['GITHUB_TOKEN'])
