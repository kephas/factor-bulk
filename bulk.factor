USING: arrays combinators io io.binary kernel math sequences ;
IN: bulk

SYMBOLS: nil nosize ;

ERROR: parsing-error ;

DEFER: read-bulk

<PRIVATE

SYMBOLS: end ; ! end of sequence

: (read-form-payload) ( seq -- seq )
    read-bulk dup end eq? [ drop ] [ suffix (read-form-payload) ] if ;

: read-form-payload ( -- seq )
    { } (read-form-payload) ;

: read-array-payload ( -- array )
    read-bulk 0 <array> dup
    [ swap drop read1 swap pick set-nth ] each-index ;

: read-word ( size -- word ) read be> ;

: msb ( size -- int ) 1 swap 8 * 1 - shift ;
: parse-2c-notation ( value size -- int )
    msb [ 1 - bitand ] [ bitand ] 2bi - ;
DEFER: (read-bulk)

: read-signed-payload ( -- sint ) f (read-bulk) parse-2c-notation ;

: (read-ns) ( marker -- ns )
    dup 255 = [ [ read1 dup 255 = [ + t ] [ + f ] if ] loop ] [ ] if ;

TUPLE: ref ns name ;

: read-ref-payload ( marker -- ref ) (read-ns) read1 ref boa ;

: (read-bulk) ( top? -- obj size )
    read1 dup
    { { 0 [ 2drop nil nosize ] }
      { 1 [ 2drop read-form-payload nosize ] }
      { 2 [ drop [ parsing-error ] [ end ] if nosize ] }
      { 3 [ 2drop read-array-payload nosize ] }
      { 4 [ 2drop 1 read-word 1 ] }
      { 5 [ 2drop 2 read-word 2 ] }
      { 6 [ 2drop 4 read-word 4 ] }
      { 7 [ 2drop 8 read-word 8 ] }
      { 8 [ 2drop 16 read-word 16 ] }
      { 9 [ 2drop read-signed-payload nosize ] }
      { 10 [ parsing-error ] }
      { 11 [ parsing-error ] }
      { 12 [ parsing-error ] }
      { 13 [ parsing-error ] }
      { 14 [ parsing-error ] }
      { 15 [ parsing-error ] }
      [ drop nip read-ref-payload nosize ]
    } case ;

PRIVATE>

: read-bulk ( -- exp ) f (read-bulk) drop ;
