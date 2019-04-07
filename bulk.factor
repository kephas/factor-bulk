USING: accessors arrays combinators io io.binary kernel math sequences ;
IN: bulk

SYMBOLS: nil ;

ERROR: parsing-error ;

DEFER: read-bulk

<PRIVATE

SYMBOLS: end ; ! end of sequence

: (read-form-payload) ( seq -- seq )
    read-bulk dup end eq? [ drop ] [ suffix (read-form-payload) ] if ;

: read-form-payload ( -- seq )
    V{ } (read-form-payload) ;

DEFER: unsigned-integer

: read-array-payload ( -- array )
    read-bulk unsigned-integer 0 <array> dup
    [ swap drop read1 swap pick set-nth ] each-index ;

TUPLE: bulk-word bytes ;

: value/size ( word -- value size )
    bytes>> [ be> ] [ length ] bi ;

: read-word ( size -- word ) read bulk-word boa ;

: unsigned-integer ( word -- int ) bytes>> be> ;

: msb ( size -- int ) 1 swap 8 * 1 - shift ;
: signed-integer ( word -- int )
    value/size msb [ 1 - bitand ] [ bitand ] 2bi - ;

: read-negative-integer ( size -- sint )
    0 swap read-word unsigned-integer - ;

: (read-ns) ( marker -- ns )
    dup 255 = [ [ read1 dup 255 = [ + t ] [ + f ] if ] loop ] [ ] if ;

TUPLE: ref ns name ;

: read-ref-payload ( marker -- ref ) (read-ns) read1 ref boa ;

: (read-bulk) ( top? -- obj )
    read1 dup
    dup [ 14 >= ] [ 31 <= ] bi and [ parsing-error ] [ ] if
    { { 0 [ 2drop nil ] }
      { 1 [ 2drop read-form-payload ] }
      { 2 [ drop [ parsing-error ] [ end ] if ] }
      { 3 [ 2drop read-array-payload ] }
      { 4 [ 2drop 1 read-word ] }
      { 5 [ 2drop 2 read-word ] }
      { 6 [ 2drop 4 read-word ] }
      { 7 [ 2drop 8 read-word ] }
      { 8 [ 2drop 16 read-word ] }
      { 9 [ 2drop 1 read-negative-integer ] }
      { 10 [ 2drop 2 read-negative-integer ] }
      { 11 [ 2drop 4 read-negative-integer ] }
      { 12 [ 2drop 8 read-negative-integer ] }
      { 13 [ 2drop 16 read-negative-integer ] }
      [ drop nip read-ref-payload ]
    } case ;

PRIVATE>

: read-bulk ( -- exp ) f (read-bulk) ;
