USING: combinators io io.binary ;
IN: bulk

SYMBOLS: nil ;

! : %read-array-payload ( -- array )

: read-word ( size -- word ) read be> ;
