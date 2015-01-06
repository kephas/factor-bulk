USING: help.markup help.syntax ;
IN: bulk

ARTICLE: "BULK" "Binary Uniform Language Kit"
"BULK is a framework to create unambiguous and extensible binary formats without the use of a single central registry." $nl "Reading is being implemented…" ;

ABOUT: "BULK"

HELP: read-bulk
{ $values { "exp" "A BULK expression" } }
{ $description "Read from the default input stream and return a BULK expression." }
{ $error-description "If an error is encountered in the BULK stream, it raises a "
  { $instance parsing-error } "." } ;


IN: bulk.private

HELP: (read-bulk)
{ $values { "top?" "True if parsing an expression of the abstract yield." }
  { "obj" "The object parsed." }
  { "size" "The size of the object parsed (only in case of a word)." } }
  { $description "This is the dispatch table for BULK marker bytes. It reads the marker byte and then call te appropriate function" }
  { $errors "If " { $snippet "top?" } " is true, reading the marker byte for the end of sequence raises a " { $instance parsing-error } "." }
  { $see-also read-bulk } ;
