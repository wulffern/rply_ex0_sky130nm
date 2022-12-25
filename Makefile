
JEKYLL_VERSION=3.8
SITE=${shell pwd}/docs

pdf:
	pandoc -s  README.md -o README.pdf

slidy:
	pandoc -s -t slidy README.md -o README.html


jstart:
	docker run --rm --name rply_ex0 --volume="${SITE}:/srv/jekyll" -p 3000:4000 -it jekyll/jekyll:${JEKYLL_VERSION} jekyll serve --watch --drafts

