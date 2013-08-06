#############################################################################
##
##  EquidimensionalQuasiAffineDecomposition.gd       AlgebraicThomas package
##
##  Copyright 2013,      Thomas Bächler, RWTH-Aachen University
##                       Mohamed Barakat, University of Kaiserslautern
##
##  Implementation for EquidimensionalQuasiAffineDecomposition.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

InstallMethod( EquidimensionalQuasiAffineDecomposition,
        "for a constructible set",
        [ IsScheme and IsAlgebraicThomasDecompositionOfConstructibleSetRep ],
        
  function( X )
    local d, n, L, I, Y, l;
    
    l := [ ];
    
    while not IsEmpty( X ) do
        
        d := Dimension( X );
        
        n := StringToInt( homalgSendBlocking( [ "nops(", X!.Thomas_system, ")" ], "need_output", HOMALG_IO.Pictograms.EquidimensionalQuasiAffineDecomposition ) );
        
        L := [ 1 .. n ];
        
        if d > 0 then
            L := Filtered( [ 1 .. n ], i->StringToInt( homalgSendBlocking( [ "AlgebraicThomas[Dimension]( ", X!.Thomas_system, "[", i, "] )" ], "need_output", HOMALG_IO.Pictograms.EquidimensionalQuasiAffineDecomposition ) ) = d );
        fi;
        
        I := homalgSendBlocking( [ "AlgebraicThomas[Ideal](", X!.Thomas_system, "[", L, "])" ], HOMALG_IO.Pictograms.EquidimensionalQuasiAffineDecomposition );
        
        L := Filtered( [ 1 .. n ], j -> homalgSendBlocking( [ "evalb( { op( map( AlgebraicThomas[reduce], ", I, X!.Thomas_system, "[", j, "]) ) } subset { 0 } )" ], "need_output", HOMALG_IO.Pictograms.EquidimensionalQuasiAffineDecomposition ) = "true" );
        
        Y := _ConstructibleSet( homalgSendBlocking( [ X!.Thomas_system, "[", L, "]" ], HOMALG_IO.Pictograms.EquidimensionalQuasiAffineDecomposition ), HomalgRing( X ) );
        
        Y := QuasiAffineSet( DefiningIdeal( Closure( Y ) ), ADefiningIdealOfComplement( Y ) );
        
        Add(l, Y);
        
        X := Difference( X, Y );
        
    od;
    
    return l;
    
end );

InstallMethod( EquidimensionalQuasiAffineDecomposition,
        "for an affine scheme",
        [ IsScheme and IsAffineSchemeRep ],
        
  function( X )
    
    return EquidimensionalQuasiAffineDecomposition( QuasiAffineSet( X ) );
    
end );
