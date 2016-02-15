#############################################################################
##
##  AlgebraicThomas.gd                               AlgebraicThomas package
##
##  Copyright 2013,      Thomas Bächler, RWTH-Aachen University
##                       Mohamed Barakat, University of Kaiserslautern
##
##  Declaration stuff for AlgebraicThomas.
##
#############################################################################


# our info class:
DeclareInfoClass( "InfoAlgebraicThomas" );
SetInfoLevel( InfoAlgebraicThomas, 1 );

# a central place for configurations:
DeclareGlobalVariable( "ALGEBRAIC_THOMAS" );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "VariableForCountingPolynomial" );

DeclareGlobalFunction( "_ConstructibleSet" );

# basic operations:

#! @Description
#!  Initializes AlgebraicThomas in Maple according to <C>CoefficientsRing</C>(<A>R</A>)
#!  and returns a pointer to the options table.
#! @Returns a homalg pointer
#! @Arguments R
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareOperation( "AlgebraicThomasData",
                  [ IsHomalgRing ] );

#! @Description
#!  Initializes an algebraic Thomas system representing the quasi-affine set
#!  <M>V(</M><A>I</A><M>) - V(</M><A>J</A><M>)</M>.
#! @Returns a homalg pointer
#! @Arguments I, J
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareOperation( "QuasiAffineSet",
                  [ IsHomalgModule, IsHomalgModule ] );

#! @Description
#!  Initializes an algebraic Thomas system representing the affine set
#!  <M>V(</M><A>I</A><M>)</M>.
#! @Returns a homalg pointer
#! @Arguments I
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareAttribute( "QuasiAffineSet",
                  IsHomalgModule );

#! @Description
#!  Initializes an algebraic Thomas system representing the quasi-affine set
#!  <A>X</A><M> - V(</M><A>J</A><M>)</M>.
#! @Returns a homalg pointer
#! @Arguments X, J
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareOperation( "QuasiAffineSet",
                  [ IsScheme, IsHomalgModule ] );

#! @Description
#!  Initializes an algebraic Thomas system representing the quasi-affine set
#!  <A>X</A><M> - </M><A>Y</A>.
#! @Returns a homalg pointer
#! @Arguments X, Y
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareOperation( "QuasiAffineSet",
                  [ IsScheme, IsScheme ] );

#! @Description
#!  Initializes an algebraic Thomas system representing the affine set
#!  <A>X</A>.
#! @Returns a homalg pointer
#! @Arguments X
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareAttribute( "QuasiAffineSet",
                  IsScheme );

#! @Description
#!  Initializes an algebraic Thomas system representing the constructible set
#!  <M>V(</M><A>I</A><M>) - U</M>, where <M>U</M> is the union of all
#!  <M>V(</M><A>j</A><M>)</M>, <A>j</A> in <A>J</A>.
#! @Returns a homalg pointer
#! @Arguments I, J
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareOperation( "ConstructibleSet",
                  [ IsHomalgModule, IsList ] );

#! @Description
#!  Initializes an algebraic Thomas system representing the constructible set
#!  <A>X</A> <M>- U</M>, where <M>U</M> is the union of all
#!  <M>V(</M><A>j</A><M>)</M>, <A>j</A> in <A>J</A>.
#! @Returns a homalg pointer
#! @Arguments X, J
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareOperation( "ConstructibleSet",
                  [ IsScheme, IsList ] );

#! @Description
#!  Initializes an algebraic Thomas system representing the constructible set
#!  defined by the equations in <A>G</A> and inequations in <A>U</A>.
#! @Returns a homalg pointer
#! @Arguments G, U
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareOperation( "ConstructibleSet",
                  [ IsList, IsList ] );

#! @Description
#!  Initializes an algebraic Thomas system representing the intersection of the
#!  constructible set <A>X</A> with <M>R</M>, where <M>R</M> is the constructible
#!  set defined by the equations in <A>G</A> and inequations in <A>U</A>.
#! @Returns a homalg pointer
#! @Arguments X, G, U
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareOperation( "ConstructibleSet",
                  [ IsScheme, IsList, IsList ] );

#! @Description
#!  The projection of a quasi-affine scheme <A>X</A>
#!  to the affine space given by ....
#! @Returns a homalg pointer
#! @Arguments X, vars
#! @ChapterInfo Algebraic Thomas, Constructors
DeclareOperation( "Project",
                  [ IsScheme ] );

#! @Description
#!  The counting polynomial of the quasi-affine scheme <A>X</A>.
#! @Returns a univariate polynomial
#! @Arguments X
#! @ChapterInfo Algebraic Thomas, Attributes
DeclareAttribute( "CountingPolynomial",
                  IsScheme );

#! @Description
#!  A defining ideal of the complement in ambient space of <A>X</A>.
#! @Returns a homalg ideal
#! @Arguments X
#! @ChapterInfo Algebraic Thomas, Attributes
DeclareAttribute( "ADefiningIdealOfComplement",
                  IsScheme );

#! @Description
#!  A quasi affine decomposition of the constructible set <A>X</A>.
#! @Returns a list
#! @Arguments X
#! @ChapterInfo Algebraic Thomas, Attributes
DeclareAttribute( "QuasiAffineDecomposition",
                  IsScheme );
