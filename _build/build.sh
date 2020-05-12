#!/bin/bash
docker run --rm -v $(pwd):/srv/jekyll jekyll/jekyll:3.8 jekyll build
