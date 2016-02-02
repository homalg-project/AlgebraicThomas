##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "AutoDoc" );

AutoDoc( "AlgebraicThomas", rec( scaffold := true, autodoc := true ) );

QUIT;
