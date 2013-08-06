all: doc test

doc: doc/manual.six

doc/manual.six: createautodoc.g makedoc.g maketest.g ListOfDocFiles.g \
		PackageInfo.g \
		doc/AlgebraicThomas.bib doc/*.xml doc/*.css \
		gap/*.gd gap/*.gi examples/*.g
		gap createautodoc.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/AlgebraicThomas.tar.gz --exclude ".DS_Store" --exclude "*~" AlgebraicThomas/doc/*.* AlgebraicThomas/doc/clean AlgebraicThomas/gap/*.{gi,gd} AlgebraicThomas/{PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g,ListOfDocFiles.g,createautodoc.g} AlgebraicThomas/examples/*.g)

WEBPOS=public_html
WEBPOS_FINAL=~/public_html/AlgebraicThomas

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.AlgebraicThomas
	cp doc/manual.pdf ${WEBPOS}/AlgebraicThomas.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/AlgebraicThomas.tar.gz ${WEBPOS}/AlgebraicThomas-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s AlgebraicThomas-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/AlgebraicThomas.tar.gz

