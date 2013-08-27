all: pdf

PDFS =	BCFv1_qref.pdf \
	BCFv2_qref.pdf \
	CSIv1.pdf \
	SAMv1.pdf \
	tabix.pdf \
	VCFv4.1.pdf \
	VCFv4.2.pdf

pdf: $(PDFS)

SAMv1.pdf: SAMv1.tex SAMv1.ver


.SUFFIXES: .tex .pdf .ver
.tex.pdf:
	pdflatex $<
	while grep -q 'Warning.*Rerun' $*.log; do pdflatex $< || exit; done

.tex.ver:
	echo "@newcommand*@commitdesc{`git describe --always --dirty`}@newcommand*@headdate{`git rev-list -n1 --format=%aD HEAD $< | sed '1d;s/.*, *//;s/ *[0-9]*:.*//'`}" | tr @ \\ > $@


mostlyclean:
	-rm -f *.aux *.idx *.log *.out *.toc *.ver

clean: mostlyclean
	-rm -f $(PDFS)


.PHONY: all pdf mostlyclean clean
