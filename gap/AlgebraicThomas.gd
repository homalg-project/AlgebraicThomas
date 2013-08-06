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

DeclareOperationWithDocumentation( "AlgebraicThomasData",
        [ IsHomalgRing ],
        [ "Initializes AlgebraicThomas in Maple according to <C>CoefficientsRing</C>(<A>R</A>)",
          "and returns a pointer to the options table." ],
        "a homalg pointer",
        "R",
        [ "Algebraic_Thomas", "Constructors" ]
        );

DeclareOperationWithDocumentation( "QuasiAffineSet",
        [ IsHomalgModule, IsHomalgModule ],
        [ "Initializes an algebraic Thomas system representing the quasi-affine set",
          "<M>V(</M><A>I</A><M>) - V(</M><A>J</A><M>)</M>." ],
        "a homalg pointer",
        "I, J",
        [ "Algebraic_Thomas", "Constructors" ]
        );

DeclareAttributeWithDocumentation( "QuasiAffineSet",
        IsHomalgModule,
        [ "Initializes an algebraic Thomas system representing the affine set",
          "<M>V(</M><A>I</A><M>)</M>." ],
        "a homalg pointer",
        "I",
        [ "Algebraic_Thomas", "Constructors" ]
        );

DeclareOperationWithDocumentation( "QuasiAffineSet",
        [ IsScheme, IsHomalgModule ],
        [ "Initializes an algebraic Thomas system representing the quasi-affine set",
          "<A>X</A><M> - V(</M><A>J</A><M>)</M>." ],
        "a homalg pointer",
        "X, J",
        [ "Algebraic_Thomas", "Constructors" ]
        );

DeclareOperationWithDocumentation( "QuasiAffineSet",
        [ IsScheme, IsScheme ],
        [ "Initializes an algebraic Thomas system representing the quasi-affine set",
          "<A>X</A><M> - </M><A>Y</A>." ],
        "a homalg pointer",
        "X, Y",
        [ "Algebraic_Thomas", "Constructors" ]
        );

DeclareAttributeWithDocumentation( "QuasiAffineSet",
        IsScheme,
        [ "Initializes an algebraic Thomas system representing the affine set",
          "<A>X</A>." ],
        "a homalg pointer",
        "X",
        [ "Algebraic_Thomas", "Constructors" ]
        );

DeclareOperationWithDocumentation( "Project",
        [ IsScheme ],
        [ "The projection of a quasi-affine scheme <A>X</A>",
          "to the affine space given by ...." ],
        "a homalg pointer",
        "X, vars",
        [ "Algebraic_Thomas", "Constructors" ]
        );

DeclareAttributeWithDocumentation( "CountingPolynomial",
        IsScheme,
        [ "The counting polynomial of the quasi-affine scheme <A>X</A>." ],
        "a univariate polynomial",
        "X",
        [ "Algebraic_Thomas", "Attributes" ]
        );

DeclareAttributeWithDocumentation( "ADefiningIdealOfComplement",
        IsScheme,
        [ "A defining ideal of the complement in ambient space of <A>X</A>." ],
        "a homalg ideal",
        "X",
        [ "Algebraic_Thomas", "Attributes" ]
        );

DeclareAttributeWithDocumentation( "QuasiAffineDecomposition",
        IsScheme,
        [ "A quasi affine decomposition of the constructible set <A>X</A>." ],
        "a list",
        "X",
        [ "Algebraic_Thomas", "Attributes" ]
        );
