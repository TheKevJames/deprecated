import os
import yaml


conf = None
for folder in (os.curdir,
               os.path.join(os.path.expanduser('~'), '.config', 'devstat'),
               os.path.join('etc', 'devstat')):
    try:
        with open(os.path.join(folder, 'config.yml')) as f:
            conf = yaml.safe_load(f)
            break
    except IOError:
        pass

conf = conf or dict()

username = conf.get('username')
deploy = conf.get('deploy')
repos = conf.get('repos')
status = conf.get('status')
