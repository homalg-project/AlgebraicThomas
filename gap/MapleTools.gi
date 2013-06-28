#############################################################################
##
##  MapleTools.gi                                    AlgebraicThomas package
##
##  Copyright 2013,      Thomas Bächler, RWTH-Aachen University
##                       Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for the rings provided by Maple.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( AlgebraicThomasMacros,
        rec(
            
    _CAS_name := "Maple",
    
    _Identifier := "AlgebraicThomas",
    
    ( "!Banner" ) := _LoadAlgebraicThomas,
    
    )

);

##
UpdateMacrosOfCAS( AlgebraicThomasMacros, MapleMacros );
UpdateMacrosOfLaunchedCASs( AlgebraicThomasMacros );

##
InstallValue( AlgebraicThomasTableTools,
        
        rec(
               
        )
 );

## enrich the global and the created homalg tables for Maple:
AppendToAhomalgTable( CommonHomalgTableForMapleHomalgTools, AlgebraicThomasTableTools );
AppendTohomalgTablesOfCreatedExternalRings( AlgebraicThomasTableTools, IsHomalgExternalRingInMapleRep );

####################################
#
# functions & methods for operations:
#
####################################

##
InstallGlobalFunction( _LoadAlgebraicThomas,
  function( stream )
    local display_color, git_ref;
    
    homalgSendBlocking( [ "libname := \"", PackageInfo( "AlgebraicThomas" )[1].InstallationPath, "/AlgebraicThomas/lib\",libname" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) )
         and not ( IsBound( stream.show_banner_AlgebraicThomas ) and stream.show_banner_AlgebraicThomas = false ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        git_ref := homalgSendBlocking("\`AlgebraicThomas/gitref\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ){[ 2 .. 9 ]};
        
        Print( "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     AlgebraicThomas - Maple package loaded (gitref: ", git_ref, ")\n\
     Copyright (C) (2010-2013)\n\
     Thomas Bächler, RWTH Aachen, Germany\033[0m\n\
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n" );
        
        stream.show_banner_AlgebraicThomas := false;
        
    fi;
    
end );
