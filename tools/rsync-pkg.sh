#!/bin/sh
sudo rsync -vc $1 --itemize-changes pkg/* echoes:/srv/www/htdocs/strawberry-packages/
