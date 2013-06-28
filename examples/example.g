LoadPackage( "RingsForHomalg" );

Q := HomalgFieldOfRationalsInMaple( );

R := Q * "x,y,z";

LoadPackage( "Modules" );

I := LeftSubmodule( "x*(x-1)", R );
J := LeftSubmodule( "y,z", R );
K := LeftSubmodule( "x-1", R );

LoadPackage( "AlgebraicThomas" );

W := QuasiAffineSet( I, I );
V := QuasiAffineSet( I, J );
U := QuasiAffineSet( I, K );

u := VariableForCountingPolynomial( );

Assert( 0, IsEmpty( W ) );
Assert( 0, IsAffine( W ) );
Assert( 0, CountingPolynomial( W ) = 0 * u );
Assert( 0, not IsAffine( V ) );
Assert( 0, not IsEmpty( V ) );
Assert( 0, CountingPolynomial( V ) = 2*u^2-2 );
Assert( 0, IsAffine( U ) );
Assert( 0, not IsEmpty( U ) );
Assert( 0, CountingPolynomial( U ) = u^2 );
Assert( 0, IsSubset( U, Intersect( U, V ) ) );
