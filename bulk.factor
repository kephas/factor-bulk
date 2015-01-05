USING: kernel math combinators io io.binary ;
IN: bulk

SYMBOLS: nil ;

ERROR: parsing-error ;

<PRIVATE

SYMBOLS: end ; ! end of sequence

DEFER: read-form-payload ! ( -- seq )

DEFER: read-array-payload ! ( -- array )

: read-word ( size -- word ) read be> ;

: msb ( size -- int ) 1 swap 8 * 1 - shift ;

: parse-2c-notation ( value size -- int )
    msb [ 1 - bitand ] [ bitand ] 2bi - ;

DEFER: read-signed-payload ! ( -- sint )

DEFER: read-ref-payload ! ( marker -- ref )

: (read-bulk) ( top? -- obj )
    read1 dup
    { { 0 [ 2drop nil ] }
      { 1 [ 2drop read-form-payload ] }
      { 2 [ drop [ end ] [ parsing-error ] if ] }
      { 3 [ 2drop read-array-payload ] }
      { 4 [ 2drop 1 read-word ] }
      { 5 [ 2drop 2 read-word ] }
      { 6 [ 2drop 4 read-word ] }
      { 7 [ 2drop 8 read-word ] }
      { 8 [ 2drop 16 read-word ] }
      { 9 [ 2drop read-signed-payload ] }
      { 10 [ parsing-error ] }
      { 11 [ parsing-error ] }
      { 12 [ parsing-error ] }
      { 13 [ parsing-error ] }
      { 14 [ parsing-error ] }
      { 15 [ parsing-error ] }
      [ drop read-ref-payload ]
    } case ;

PRIVATE>

: read-bulk ( -- exp ) f (read-bulk) ;
