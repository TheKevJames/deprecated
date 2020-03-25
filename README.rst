deprecated
==========

You live, you build terrible projects which should never see the light of day,
and -- if you're very lucky -- you learn something from that experience.

This repo contains that middle chunk -- projects I built which should never see
the light of day, but which I feel like I should keep world-readable for
whatever reason.

For the love of all that is good in this world, I recommend against reading
through this code. Your eyes will bleed.

Usage
-----

When deprecating a project, I find it useful to keep the relevant git history.
Example commands I use for this are:

.. code-block:: console

    # to deprecate the `octodash` project folder in `thekevjames/web`
    git clone git://github.com/TheKevJames/web.git /tmp/depr
    cd /tmp/depr

    git filter-branch --subdirectory-filter octodash -- -- all
    mkdir octodash/
    git mv <files> octodash/

    git commit -m 'chore(octodash): prepare for deprecation'

    cd ~/src/personal/deprecated
    git remote add depr /tmp/depr
    git fetch depr
    git branch depr remotes/depr/master
    git merge depr --allow-unrelated-histories
    git branch -d depr
    git remote rm depr

