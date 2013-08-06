##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );
LoadPackage( "Modules" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/AlgebraicThomas.bib" );
WriteBibXMLextFile( "doc/AlgebraicThomasBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "AlgebraicThomas" )[1].Version );

MakeGAPDocDoc( "doc", "AlgebraicThomas", list, "AlgebraicThomas", "MathJax" );

CopyHTMLStyleFiles( "doc" );

GAPDocManualLab( "AlgebraicThomas" );

QUIT;
