# -*- coding: UTF-8 -*-
from __future__ import print_function

from subprocess import Popen, PIPE
import sys


SYMBOLS = {'ahead': '↑', 'behind': '↓'}

def get_branch():
    branch, err = Popen(
        ['git', 'symbolic-ref', 'HEAD'],
        stdout=PIPE,
        stderr=PIPE
    ).communicate()
    if 'fatal: Not a git repository' in err.decode('utf-8'):
        sys.exit(0)

    return branch

def get_name_status():
    name_status, err = Popen(
        ['git', 'diff', '--name-status'],
        stdout=PIPE,
        stderr=PIPE
    ).communicate()
    if 'fatal' in err.decode('utf-8'):
        sys.exit(0)

    return name_status

def get_numbers(name_status):
    changed_files = [arg[0] for arg in name_status.splitlines()]
    changed = len(changed_files) - changed_files.count('U')

    staged_files = [arg[0] for arg in Popen(
        ['git', 'diff', '--staged', '--name-status'],
        stdout=PIPE
    ).communicate()[0].splitlines()]
    conflicts = staged_files.count('U')
    staged = len(staged_files) - conflicts

    untracked = len(Popen(
        ['git', 'ls-files', '--others', '--exclude-standard'],
        stdout=PIPE
    ).communicate()[0].splitlines())

    return changed, conflicts, staged, untracked

def main():
    branch = get_branch()
    name_status = get_name_status()

    changed, nb_conflicts, nb_staged, nb_untracked = get_numbers(name_status)
    if changed or nb_staged or nb_conflicts or nb_untracked:
        clean = '0'
    else:
        clean = '1'

    remote = ''
    branch = branch.strip()[11:]
    if not branch:
        branch = Popen(
            ['git', 'rev-parse', '--short', 'HEAD'],
            stdout=PIPE
        ).communicate()[0][:-1]
    else:
        remote_name = Popen(
            ['git', 'config', 'branch.%s.remote' % branch],
            stdout=PIPE
        ).communicate()[0].strip()

        if remote_name:
            merge_name = Popen(
                ['git', 'config', 'branch.%s.merge' % branch],
                stdout=PIPE
            ).communicate()[0].strip()

            if remote_name == '.': # local
                remote_ref = merge_name
            else:
                remote_ref = 'refs/remotes/%s/%s' % (remote_name, merge_name[11:])

            revgit = Popen(
                ['git', 'rev-list', '--left-right', '%s...HEAD' % remote_ref],
                stdout=PIPE,
                stderr=PIPE
            )
            revlist = revgit.communicate()[0]
            if revgit.poll(): # fallback to local
                revlist = Popen(
                    ['git', 'rev-list', '--left-right', '%s...HEAD' % merge_name],
                    stdout=PIPE,
                    stderr=PIPE
                ).communicate()[0]

            behead = revlist.splitlines()
            ahead = len([x for x in behead if x[0] == '>'])
            behind = len(behead) - ahead
            if behind:
                remote += '%s%s' % (SYMBOLS['behind'], behind)
            if ahead:
                remote += '%s%s' % (SYMBOLS['ahead'], ahead)

    out = ', '.join([
        str(branch),
        remote,
        str(nb_staged),
        str(nb_conflicts),
        str(changed),
        str(nb_untracked),
        clean])

    print(out)


main()
