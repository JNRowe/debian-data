debian-data
===========

This repository contains a collection of Debian package lists, fetched and
processed from the official Debian repositories.

The data is organised by Debian release (e.g., bookworm, bullseye) and
repository component (e.g., main, contrib, non-free).  In a minor difference to
just grabbing the list files yourself, the data is split by section to make it
both easier to scan and to produce better diffs.

The main purpose of this repository is to allow me — JNRowe — some spelunking
scaffolding when I’m trying to track down what has caused some annoying
regression.  It started when I found a seemingly unrelated package had caused a
chain of annoying bugs that were difficult to track down.  Since then I’ve used
it a few times to analyse bugs or watch changes.

The data is automatically updated via a GitHub Actions workflow.

Please, if you know an official place to get this data drop me a mail_ or open
an issue_.  Similarly, if use it but like to see some additional data included,
feel free to get in touch!

.. _mail: mailto:jnrowe@gmail.com
.. _issue: https://github.com/JNRowe/debian-data/issues
