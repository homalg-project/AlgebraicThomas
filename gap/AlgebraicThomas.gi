#############################################################################
##
##  AlgebraicThomas.gi                               AlgebraicThomas package
##
##  Copyright 2013,      Thomas Bächler, RWTH-Aachen University
##                       Mohamed Barakat, University of Kaiserslautern
##
##  Implementation stuff for AlgebraicThomas.
##
#############################################################################

# a new representation for the GAP-category IsScheme

##  <#GAPDoc Label="IsAlgebraicThomasDecompositionSchemeRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsAlgebraicThomasDecompositionSchemeRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of schemes given by an algebraic Thomas decompostion in Maple. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsScheme"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsAlgebraicThomasDecompositionSchemeRep",
        IsSchemeRep,
        [  ] );

####################################
#
# families and types:
#
####################################

##
BindGlobal( "TheTypeAlgebraicThomasDecompositionScheme",
        NewType( TheFamilyOfSchemes,
                IsAlgebraicThomasDecompositionSchemeRep ) );

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( ALGEBRAIC_THOMAS,
        rec(
            
            )
);

##
InstallMethod( HomalgRing,
        "for a quasi-affine scheme",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X )
    
    return X!.ring;
    
end );

##
InstallMethod( Closure,
        "for a quasi-affine scheme",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X )
    local R, I;
    
    R := HomalgRing( X );
    
    I := homalgSendBlocking( [  R, "[-1][matrix](map(a->[a],AlgebraicThomas[Ideal](", X!.Thomas_system, ")))" ], HOMALG_IO.Pictograms.Closure );
    
    I := HomalgMatrix( I, R );
    
    SetNrColumns( I, 1 );
    
    return R / LeftSubmodule( I );
    
end );

##
InstallMethod( ADefiningIdealOfComplement,
        "for a quasi-affine scheme",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X )
    local CX, I, V, IpJ, J;
    

    
    CX := Complement( X );
    
    I := DefiningIdeal( Closure( X ) );
    
    V := QuasiAffineSet( I );
    
    IpJ := Intersect( CX, V );
    
    IpJ := DefiningIdeal( Closure( IpJ ) );
    
    J := MatrixOfSubobjectGenerators( IpJ );
    
    J := DecideZero( J, I );
    
    J := CertainRows( J, NonZeroRows( J ) );
    
    return LeftSubmodule( J );
    
end );

##
InstallGlobalFunction( VariableForCountingPolynomial,
  function( arg )
    local u;
    
    if not IsBound( ALGEBRAIC_THOMAS.variable_for_counting_polynomial ) then
        
        if Length( arg ) > 0 and IsString( arg[1] ) then
            u := arg[1];
        else
            u := "u";
        fi;
        
        u := Indeterminate( Integers, u );
        
        ALGEBRAIC_THOMAS.variable_for_counting_polynomial := u;
    fi;
    
    return ALGEBRAIC_THOMAS.variable_for_counting_polynomial;
    
end );

##
InstallMethod( CountingPolynomial,
        "for a quasi-affine scheme",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X )
    local u, coeffs;
    
    u := VariableForCountingPolynomial( );
    
    if IsEmpty( X ) then
        return 0 * u;
    elif HasIsAffine( X ) and IsAffine( X ) then
        return u^Dimension( X );
    fi;
    
    coeffs := homalgSendBlocking( [ "(p->map[3](coeff,p,u,[$0..degree(p)]))(AlgebraicThomas[countingPolynomials](", X!.Thomas_system, ",sym='", String( u ), "')[2])" ], "need_output", HOMALG_IO.Pictograms.CountingPolynomial );
    
    coeffs := StringToIntList( coeffs );
    
    return Sum( [ 1 .. Length( coeffs ) ], i -> coeffs[i] * u^(i - 1) );
    
end );

##
InstallMethod( IsAffine,
        "for a quasi-affine scheme",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X )
    local R, Xcls;
    
    R := HomalgRing( X );
    
    Xcls := QuasiAffineSet( DefiningIdeal( Closure( X ) ), LeftSubmodule( R ) );
    
    return CountingPolynomial( X ) = CountingPolynomial( Xcls );
    
end );

####################################
#
# global functions and operations:
#
####################################

##
InstallMethod( \=,
        "for two quasi-affine schemes",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep,
          IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X, Y )
    local Z;
    
    if not CountingPolynomial( X ) = CountingPolynomial( Y ) then
        return false;
    fi;
    
    Z := Intersect( X, Y );
    
    return CountingPolynomial( X ) = CountingPolynomial( Z );
    
end );

##
InstallMethod( IsSubset,
        "for two quasi-affine schemes",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep,
          IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X, Y )
    
    return CountingPolynomial( Y ) = CountingPolynomial( Intersect( X, Y ) );
    
end );

##
InstallMethod( AlgebraicThomasData,
        "for a homalg ring",
        [ IsHomalgExternalRingInMapleRep ],
        
  function( R )
    local r, c, d, option_table;
    
    if not HasCoefficientsRing( R ) then
        Error( "CoefficientsRing is not set for the ring\n" );
    fi;
    
    r := CoefficientsRing( R );
    
    if IsBound( r!.AlgebraicThomasData ) then
        return r!.AlgebraicThomasData;
    fi;
    
    if not IsFieldForHomalg( r ) then
        Error( "CoefficientsRing is not a field\n" );
    elif not IsFreePolynomialRing( R ) then
        Error( "ring is not a polynomial ring\n" );
    fi;
    
    c := Characteristic( r );
    
    if HasDegreeOverPrimeField( r ) then
        d := DegreeOverPrimeField( r );
    else
        d := 1;
    fi;
    
    option_table := homalgSendBlocking( [ "AlgebraicThomas[newOptions]()" ], R, HOMALG_IO.Pictograms.define );
    
    r!.AlgebraicThomasData := option_table;
    
    homalgSendBlocking( [ "AlgebraicThomas[AlgebraicThomasOptions](", option_table, ",\"characteristic\",", c, ")" ], "need_command", HOMALG_IO.Pictograms.define );
    
    if d > 1 then
        homalgSendBlocking( [ "AlgebraicThomas[AlgebraicThomasOptions](", option_table, ",\"extension\",[", r!.NameOfPrimitiveElement, ",", r!.MinimalPolynomialOfPrimitiveElement, "])" ], "need_command", HOMALG_IO.Pictograms.define );
    fi;
    
    homalgSendBlocking( [ "AlgebraicThomas[AlgebraicThomasOptions](", option_table, ",\"warnings\",false)" ], "need_command", HOMALG_IO.Pictograms.define );
    
    return option_table;
    
end );

##
InstallGlobalFunction( _QuasiAffineSet,
  function( X, R )
    local dim, OX;
    
    dim := EvalString( homalgSendBlocking( [ "AlgebraicThomas[Dimension](", X, ")" ], "need_output", HOMALG_IO.Pictograms.QuasiAffineSet ) );
    
    X := rec( Thomas_system := X, ring := R );
    
    #OX := Sheafify( R );
    
    ObjectifyWithAttributes(
            X, TheTypeAlgebraicThomasDecompositionScheme,
            IsQuasiAffine, true,
            Dimension, dim,
            IsReduced, true,
            BaseRing, CoefficientsRing( R )
            );
    
    return X;
    
end );

##
InstallMethod( QuasiAffineSet,
        "for two homalg ideals",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal,
          IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( I, J )
    local R, table, i, j, var, X;
    
    if IsOne( I ) or IsZero( J ) then
        ## EmptyScheme
    elif IsOne( J ) then
        ## return Spec( R / I );
    fi;
    
    R := HomalgRing( I );
    
    table := AlgebraicThomasData( R );
    
    i := MatrixOfSubobjectGenerators( I );
    j := MatrixOfSubobjectGenerators( J );
    
    if IsZero( i ) then
        i := HomalgZeroMatrix( 1, 1, R );
    fi;
    
    if IsZero( j ) then
        j := HomalgZeroMatrix( 1, 1, R );
    fi;
    
    var := Indeterminates( R );
    
    X := homalgSendBlocking( [ "AlgebraicThomas[AlgebraicThomasDecompositionMany](AlgebraicThomas[ineqOr](map(op,convert(", i, ",listlist)),map(op,convert(", j, ",listlist ))),[", var, "], use_options=", table, ")" ], "break_lists", HOMALG_IO.Pictograms.QuasiAffineSet );
    
    X := _QuasiAffineSet( X, R );
    
    X!.DefiningIdeal := I;
    X!.DefiningIdealOfComplement := J;
    SetADefiningIdealOfComplement( X, J );
    
    if IsOne( I ) or IsZero( J ) then
        SetIsEmpty( X, true );
    elif IsOne( J ) then
        SetIsAffine( X, true );
    fi;
    
    return X;
    
end );

##
InstallMethod( QuasiAffineSet,
        "for two homalg ideals",
        [ IsFinitelyPresentedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( I )
    
    return QuasiAffineSet( I, I^0 );
    
end );

##
InstallMethod( Intersect2,
        "for two quasi-affine schemes",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep,
          IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X, Y )
    local R, Z;
    
    R := HomalgRing( X );
    
    if not IsIdenticalObj( R, HomalgRing( Y ) ) then
        Error( "the underlying rings are not identical\n" );
    fi;
    
    Z := homalgSendBlocking( [ "AlgebraicThomas[SolIntersect](", X!.Thomas_system, Y!.Thomas_system, ")" ], HOMALG_IO.Pictograms.QuasiAffineSet );
    
    return _QuasiAffineSet( Z, R );
    
end );

##
InstallMethod( Union2,
        "for two quasi-affine schemes",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep,
          IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X, Y )
    local R, Z;
    
    R := HomalgRing( X );
    
    if not IsIdenticalObj( R, HomalgRing( Y ) ) then
        Error( "the underlying rings are not identical\n" );
    fi;
    
    Z := homalgSendBlocking( [ "AlgebraicThomas[SolUnion](", X!.Thomas_system, Y!.Thomas_system, ")" ], HOMALG_IO.Pictograms.QuasiAffineSet );
    
    return _QuasiAffineSet( Z, R );
    
end );

##
InstallMethod( Difference,
        "for two quasi-affine schemes",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep,
          IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X, Y )
    local R, Z;
    
    R := HomalgRing( X );
    
    if not IsIdenticalObj( R, HomalgRing( Y ) ) then
        Error( "the underlying rings are not identical\n" );
    fi;
    
    Z := homalgSendBlocking( [ "AlgebraicThomas[SolDifference](", X!.Thomas_system, Y!.Thomas_system, ")" ], HOMALG_IO.Pictograms.QuasiAffineSet );
    
    return _QuasiAffineSet( Z, R );
    
end );

##
InstallMethod( Complement,
        "for a quasi-affine scheme",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X )
    local Z;
    
    Z := homalgSendBlocking( [ "AlgebraicThomas[Complement](", X!.Thomas_system, ")" ], HOMALG_IO.Pictograms.QuasiAffineSet );
    
    return _QuasiAffineSet( Z, HomalgRing( X ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for a quasi-affine scheme",
        [ IsScheme and IsQuasiAffine and IsAlgebraicThomasDecompositionSchemeRep ],
        
  function( X )
    
    homalgDisplay( X!.Thomas_system );
    
    Print( "A quasi-affine variety represented by the above Thomas decomposition\n" );
    
end );
