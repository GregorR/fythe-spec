PDFLATEX=pdflatex

all: letter.pdf

world: letter.pdf letterbook.pdf a4.pdf a4book.pdf index.html

letter.pdf: hgversion
letterbook.pdf: hgversion
a4.pdf: hgversion
a4book.pdf: hgversion
index.html: hgversion

hgversion:
	hg id | sed 's/_/\\_/g' > hgversion.tex
	-date --date="`hg log -l 1 --template='{date|isodate}' .`" +'%d %B %Y' > hgdate.tex
	touch hgdate.tex

.SUFFIXES: .tex .pdf .html

.tex.pdf:
	pdflatex $< && pdflatex $<

.tex.html:
	htlatex $< && htlatex $<
	perl -pe 's/white-space:nowrap//g ; s/<title>/<title>Fythe Specification/' -i $@

x: letter.pdf
	xdg-open letter.pdf

m: letter.pdf
	open letter.pdf

clean:
	rm -f *.aux *.log *.pdf *.toc \
	    *.4ct *.4tc *.css *.dvi *.html *.idv *.lg *.tmp *.xref \
	    hgversion.tex hgdate.tex
