

pdf:
	pandoc -s  README.md -o README.pdf

slidy:
	pandoc -s -t slidy README.md -o README.html
