LoadPackage( "AlgebraicThomas" );

Q := HomalgFieldOfRationalsInMaple( );
R := Q * "x,y";

I1 := ZeroLeftSubmodule( R );
J1 := LeftSubmodule( "x*y", R );

Assert( 0, QuasiAffineDecomposition( QuasiAffineSet( I1^0 ) ) = [ ] );

V1 := QuasiAffineSet( I1, J1 );

I2 := LeftSubmodule( "x,y^2+1", R );

V2 := QuasiAffineSet( I2 );

I3 := LeftSubmodule( "x,y^4-y^2+1", R );

V3 := QuasiAffineSet( I3 );

V := Union( V1, V2, V3 );

QA := QuasiAffineDecomposition( V );

Assert( 0, not IsQuasiAffineSubscheme( V ) );

Assert( 0, IsQuasiAffineSubscheme( Complement( V ) ) );

K1 := LeftSubmodule( "x", R );
K2 := LeftSubmodule( "y", R );

U1 := QuasiAffineSet( K1, K2 );
U2 := QuasiAffineSet( K2, K1 );

U := Union( U1, U2 );

Assert( 0, IsQuasiAffineSubscheme( U ) );
