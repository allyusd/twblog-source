#!/bin/bash

docker run -e "JEKYLL_ENV=production" --name twblog --rm -p 4001:4000 -v $(pwd):/home/ubuntu/jekyll -u $(id -u):$(id -g) allyusd/ubuntu-jekyll bundle exec jekyll build
