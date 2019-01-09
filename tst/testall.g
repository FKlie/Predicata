LoadPackage( "predicata" );

TestDirectory(DirectoriesPackageLibrary( "predicata", "tst" ),
  rec(exitGAP     := false,
      testOptions := rec(compareFunction := "uptowhitespace") ) );
      
# FORCE_QUIT_GAP(100);