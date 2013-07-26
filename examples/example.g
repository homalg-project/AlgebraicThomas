LoadPackage( "RingsForHomalg" );

Q := HomalgFieldOfRationalsInMaple( );
GF8 := HomalgRingOfIntegersInMaple( 2, 3, Q );

P := Q * "x";
T := P * "y";
R := Q * "x,y,z";
S := GF8 * "x,y,z";

LoadPackage( "Modules" );

L := LeftSubmodule( "x", P );
H := LeftSubmodule( "x*y-1", T );
I := LeftSubmodule( "x*(x-1)", R );
J := LeftSubmodule( "y,z", R );
K := LeftSubmodule( "x-1", R );

LoadPackage( "AlgebraicThomas" );

Y := QuasiAffineSet( H );
W := QuasiAffineSet( I, I );
V := QuasiAffineSet( I, J );
U := QuasiAffineSet( I, K );

u := VariableForCountingPolynomial( );

Assert( 0, ADefiningIdealOfComplement( Project( Y ) ) = L );
Assert( 0, IsEmpty( W ) );
Assert( 0, IsAffineSubscheme( W ) );
Assert( 0, CountingPolynomial( W ) = 0 * u );
Assert( 0, not IsAffineSubscheme( V ) );
Assert( 0, not IsEmpty( V ) );
Assert( 0, CountingPolynomial( V ) = 2*u^2-2 );
Assert( 0, IsAffineSubscheme( U ) );
Assert( 0, not IsEmpty( U ) );
Assert( 0, CountingPolynomial( U ) = u^2 );
Assert( 0, IsSubset( U, Intersect( U, V ) ) );
