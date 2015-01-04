USING: help.markup help.syntax ;
IN: bulk

ARTICLE: "BULK" "Binary Uniform Language Kit"
"BULK is a framework to create unambiguous and extensible binary formats without the use of a single central registry." $nl "Reading is being implemented…" ;

ABOUT: "BULK"

HELP: read-bulk
{ $values { "exp" "A BULK expression" } }
{ $description "Read from the default input stream and return a BULK expression." }
{ $error-description "If an error is encountered in the BULK stream, it raises a "
  { $link parsing-error } "." } ;
