debian-data
===========

This repository contains a collection of Debian package lists, fetched and
processed from the official Debian repositories.

The purpose of this repository is to provide a historical view of Debian package
information, making it easier to investigate changes and track down the root
cause of regressions.  It started when I found a seemingly unrelated package had
caused a chain of annoying bugs that were difficult to track down, the root
cause of that session was a package that had been updated two weeks earlier.

How it Works
------------

The fetcher splits the upstream ``Packages`` files into smaller, more
manageable files based on the ``Section`` field of each package.  This makes it
easier to scan for changes in specific categories and produces cleaner, more
focused ``git diff`` outputs.

Data Structure
--------------

The data is organised by Debian release, repository component, and package
section: ``<release>/<component>/<section>.pkgs``.

Usage Example
-------------

The primary use case is to see how available packages have changed over time.
For example, to see what changed in the ``libs`` section for the main component
of ``forky`` between two commits, you could run::

    git diff <commit_1> <commit_2> -- bookworm/main/libs.pkgs

.. note::

    git_ allows us to reference commits in various ways.  You’re not strictly
    limited to simple hashes here, you can use any commit-ish_

Automation
----------

The data is updated automatically each day via a GitHub Actions workflow.

Feedback
--------

This project was created for my — JNRowe's — own use, but I welcome
feedback.

* **Official Data**: If you know of an official, historical archive of this
  data, please drop me a mail_ or open an issue_.  I would be delighted to find
  a better *official* source!
* **Suggestions**: If you find this data useful but would like to see additional
  information included, feel free to open an issue_.

.. _git: https://git-scm.com/
.. _commit-ish: https://git-scm.com/docs/gitrevisions#_specifying_revisions
.. _mail: mailto:jnrowe@gmail.com
.. _issue: https://github.com/JNRowe/debian-data/issues
