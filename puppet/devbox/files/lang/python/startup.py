#!/usr/bin/env python
import atexit
import os
import readline
import rlcompleter

HISTORY = os.path.expanduser('~/.local/share/python/history')
if not os.path.exists(HISTORY):
    open(HISTORY, 'a').close()

# Load
readline.set_history_length(10000)
readline.read_history_file(HISTORY)

readline.parse_and_bind('tab: complete')

# Save
def save_history(historyPath=HISTORY):
    import readline
    readline.write_history_file(historyPath)

atexit.register(save_history)


del atexit, os, readline, rlcompleter
del HISTORY
del save_history
