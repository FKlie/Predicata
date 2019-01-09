SetPackageInfo( rec(
  PackageName := "Predicata",
  Subtitle := "Deciding Presburger Arithmetic Using Automata Theory",
  Version := "1.0",
  Date := "01/10/2018",
  Persons := [
    rec( 
      LastName      := "Kliemann",
      FirstNames    := "Fritz",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "fritz.kliemann@gmx.at",
      #WWWHome       := "",
      #PostalAddress := Concatenation( [ ] ),
      Place         := "Linz, Austria",
      #Institution   := ""
    )
  ],
  ##  Status information. Currently the following cases are recognized:
  ##    "accepted"      for successfully refereed packages
  ##    "submitted"     for packages submitted for the refereeing
  ##    "deposited"     for packages for which the GAP developers agreed
  ##                    to distribute them with the core GAP system
  ##    "dev"           for development versions of packages
  ##    "other"         for all other packages
  ##
  Status := "dev",
  AbstractHTML := "Predicata - Deciding Presburger Arithmetic using Automata Theory",
  PackageDoc := rec(
      BookName  := "Predicata",
      HTMLStart := "doc/chap0.html",
      PDFFile   := "doc/manual.pdf",
      SixFile   := "doc/manual.six",
      LongTitle := "Deciding Presburger Arithmetic using Automata Theory",
      Autoload  := true
  ),
  Dependencies := rec(
      GAP       := ">=4.5",
      NeededOtherPackages := [ [ "automata", "1.13" ] ],
      SuggestedOtherPackages := [ [ "GAPDoc", ">= 1.2" ] ],
      ExternalConditions := [ ]
  ),
  Autoload := false,
  AvailabilityTest := function()
        return true;
    end,
  TestFile := "tst/testall.g",
  BannerString := Concatenation(
    "\n_____________________________________________________________________________",
    "\n                                                                             ",
    "\n                                  ██                         ██              ",
    "\n   Written by Fritz Kliemann      ██  ██    Version 1.0     ████             ",
    "\n                                  ██                         ██              ",
    "\n    █████    █ ▐█   ▐███▌     ██████  ██    ████    █████    ██      █████   ",
    "\n   ██▌  ██   ███   ▐█   █▌   ██  ▐██  ██   ██      ██  ▐██   ██     ██  ▐██  ",
    "\n   ██    ██  ██    ███████  ██    ██  ██  ██      ██    ██   ██    ██    ██  ",
    "\n   ███  ██   ██    ▐█        ██  ███  ██   ██      ██  ███   ██▌    ██  ███  ",
    "\n   ██ ███    ██     ▐███▌     ███ ██  ██    ████    ███ ██   ▐██▌    ███ ██  ",
    "\n   ██                                                                        ",
    "\n   ██        Deciding Presburger Arithmetic using Automata Theory            ",
    "\n   ██        Help: ?Predicata:                                               ",
    "\n_____________________________________________________________________________",
    "\n\n"
  ),
  Autoload := false,
  Keywords := [ "Predicata", "Presburger arithmetic", "Automata theory" ]
));
