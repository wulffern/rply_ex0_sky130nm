
JEKYLL_VERSION=3.8
SITE=docs

pdf:
	pandoc -s  README.md -o README.pdf

slidy:
	pandoc -s -t slidy README.md -o README.html


jbuild:
	cd ${SITE}; docker run --rm --volume="$PWD:/srv/jekyll" -it jekyll/jekyll:${JEKYLL_VERSION} jekyll build

jrun:
	cd ${SITE}; docker run --name newblog --volume="$PWD:/srv/jekyll" -p 3000:4000 -it jekyll/jekyll:${JEKYLL_VERSION} jekyll serve --watch --drafts
