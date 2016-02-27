#!/usr/bin/env python
import os
import sys

from agithub import Github


USER = 'thekevjames'


g = Github(token=os.environ['GITHUB_TOKEN'])
resp = g.users[USER].repos.get(per_page=100)
if resp[0] != 200:
    print 'Could not reach Github API. Error was: ', resp[1]
    sys.exit(-1)

for repo in resp[1]:
    print 'name:', repo['name']
    print

    print 'default_branch:', repo['default_branch']
    print 'description:', repo['description']
    print 'fork:', repo['fork']
    print 'forks:', repo['forks']
    print 'forks_count:', repo['forks_count']
    print 'has_downloads:', repo['has_downloads']
    print 'has_issues:', repo['has_issues']
    print 'has_pages:', repo['has_pages']
    print 'has_wiki:', repo['has_wiki']
    print 'homepage:', repo['homepage']
    print 'id:', repo['id']
    print 'language:', repo['language']
    print 'open_issues:', repo['open_issues']
    print 'open_issues_count:', repo['open_issues_count']
    print 'owner_id:', repo['owner']['id']
    print 'permissions:', repo['permissions']
    print 'size:', repo['size']
    print 'stargazers_count:', repo['stargazers_count']
    print 'watchers:', repo['watchers']
    print 'watchers_count:', repo['watchers_count']

    print
    print 'created_at:', repo['created_at']
    print 'pushed_at:', repo['pushed_at']
    print 'updated_at:', repo['updated_at']

    break
