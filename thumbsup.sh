#!/bin/bash
sudo docker run -t -v /home/test/dl-gallery/dl-gallery_sources:/input:ro -v /home/test/dl-gallery/thumbsup:/output -u $(id -u):$(id -g) thumbsupgallery/thumbsup thumbsup --input /input --output /output --sort-albums-by "title" --title "UncleDan's Gallery" --footer "Copyright 2004-2019 Daniele Lolli (UncleDan)"
sudo rsync -azvr /home/test/dl-gallery/thumbsup/* /var/www/html --delete
