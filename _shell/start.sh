#!/bin/bash

docker run -e "JEKYLL_ENV=production" --name twblog --rm -d -p 4001:4000 -v $(pwd):/home/ubuntu/jekyll -u $(id -u):$(id -g) allyusd/ubuntu-jekyll bundle exec jekyll serve --config _config.yml,_config_dev.yml --host=0.0.0.0 --drafts
