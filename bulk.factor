USING: combinators io io.binary ;
IN: bulk

SYMBOLS: nil ;

! : %read-array-payload ( -- array )

: read-word ( size -- word ) read be> ;

: read-bulk ( -- obj )
  read1
  { { 0 [ nil ] }
    { 4 [ 1 read-word ] }
    { 5 [ 2 read-word ] }
    { 6 [ 4 read-word ] }
    { 7 [ 8 read-word ] }
    { 8 [ 16 read-word ] } } case ;
