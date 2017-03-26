docker run --name jekyll --rm -v ~/github/jekyll:/home/ubuntu/jekyll -u $(id -u):$(id -g) allyusd/ubuntu-jekyll bundle exec jekyll new . --force

