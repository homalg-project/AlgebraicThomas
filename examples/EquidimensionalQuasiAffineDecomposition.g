LoadPackage("AlgebraicThomas");

Q := HomalgFieldOfRationalsInMaple();
R := Q*"x,y,z";

I1 := LeftSubmodule( "z", R );
I2 := LeftSubmodule( "y", R );
I3 := LeftSubmodule( "z-y, z-x", R );

V1_1 := QuasiAffineSet( I1, I2 );
V1_2 := Spec( R / I1 );
V2_1 := QuasiAffineSet( I2, I1 );
V2_2 := Spec( R / I2 );
V3 := Spec( R / I3 );

V := Union( V1_1, V2_1, V3 );
# Union of affine schemes only does not work yet
Vc := Union( QuasiAffineSet( V1_2 ), V2_2, V3 );

QA_V := QuasiAffineDecomposition( V );
QA_Vc := QuasiAffineDecomposition( Vc );

EQA_V := EquidimensionalQuasiAffineDecomposition( V );
EQA_Vc := EquidimensionalQuasiAffineDecomposition( Vc );

Assert( 0, Length( QA_V ) = 2 );
Assert( 0, Dimension( QA_V[1] ) = 2 );
Assert( 0, Dimension( QA_V[2] ) = 0 );

Assert( 0, Length( QA_Vc ) = 1 );
Assert( 0, Dimension( QA_Vc[1] ) = 2 );

Assert( 0, Length( EQA_V ) = 2 );
Assert( 0, Dimension( EQA_V[1] ) = 2 );
Assert( 0, Dimension( EQA_V[2] ) = 1 );

Assert( 0, Length( EQA_Vc ) = 2 );
Assert( 0, Dimension( EQA_Vc[1] ) = 2 );
Assert( 0, Dimension( EQA_Vc[2] ) = 1 );
