all: debugging-zine-a5-with-blank-pages.pdf cover-image-a5.png

# http://www.lulu.com/content/paperback/linux-debugging-tools-youll-love/19349780

cover-image-a5.png: debugging-zine-a5.pdf 
	convert -verbose -density 300 -trim debugging-zine-a5.pdf[0] -quality 100 -flatten -sharpen 0x1.0 cover-image-a5.png

# Insert empty pages, because on lulu.com small books are only
# available in bound form, and bound books must be at least 32
# pages. Also comes in handy because you could use the left
# pages for your own notes
#
# http://unix.stackexchange.com/questions/15992/how-do-i-insert-a-blank-page-into-a-pdf-with-ghostscript-or-pdftk
debugging-zine-a5-with-blank-pages.pdf: debugging-zine-a5.pdf blank-a5.pdf
	pdftk A=debugging-zine-a5.pdf B=blank-a5.pdf cat A2 B1 A3 B1 A4 B1 A5 B1 A6 B1 A7 B1 A8 B1 A9 B1 A10 B1 A11 B1 A12 B1 A13 B1 A14 B1 A15 B1 A16 B1 A17 B1 A18 B1 A19 B1 A20 output debugging-zine-a5-with-blank-pages.pdf
	

debugging-zine-a5.pdf: debugging-zine.pdf
	gs -sOutputFile=debugging-zine-a5.pdf -r300x300 -sDEVICE=pdfwrite -sPAPERSIZE=a5 -DPDFSETTINGS=/prepress -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH -dPDFFitPage debugging-zine.pdf

# http://jvns.ca/blog/2016/09/07/new-zine-linux-debugging-tools-youll-love/
debugging-zine.pdf:
	wget http://jvns.ca/debugging-zine.pdf

# http://unix.stackexchange.com/questions/277892/how-do-i-create-a-blank-pdf-from-the-command-line
blank-a5.pdf:
	convert xc:none -page A5 blank-a5.pdf

.PHONY: clean
clean:
	@rm blank-a5.pdf debugging-zine-a5.pdf debugging-zine-a5-with-blank-pages.pdf cover-image-a5.png || true
