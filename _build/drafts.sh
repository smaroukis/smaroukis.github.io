#!/bin/bash
docker run -p 4000:4000 -v $(pwd):/srv/jekyll jekyll/jekyll:3.8 jekyll serve --drafts --watch --incremental --force_polling --config _config.yml,_config.docker.yml
