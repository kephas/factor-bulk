USING: tools.test kernel bulk bulk.private io.encodings.binary io.streams.byte-array ;
IN: bulk.tests

: bin-read-bulk ( bytes -- expr ) binary [ read-bulk ] with-byte-reader ;

[ 1 ] [ B{ 4 1 } bin-read-bulk ] unit-test
[ 1 ] [ B{ 5 0 1 } bin-read-bulk ] unit-test
[ 1 ] [ B{ 6 0 0 0 1 } bin-read-bulk ] unit-test
[ 16777216 ] [ B{ 6 1 0 0 0 } bin-read-bulk ] unit-test

[ -2 ] [ 254 1 parse-2c-notation ] unit-test
[ 127 ] [ 127 1 parse-2c-notation ] unit-test
[ 0 ] [ 0 1 parse-2c-notation ] unit-test
[ -127 ] [ 129 1 parse-2c-notation ] unit-test
[ -128 ] [ 128 1 parse-2c-notation ] unit-test

[ nil ] [ B{ 0 } bin-read-bulk ] unit-test

[ 1 ] [ B{ 4 1 } bin-read-bulk ] unit-test
[ 1 ] [ B{ 4 1 0 } bin-read-bulk ] unit-test
[ 256 ] [ B{ 5 1 0 } bin-read-bulk ] unit-test
[ 256 ] [ B{ 5 1 0 0 } bin-read-bulk ] unit-test

[ 1 ] [ B{ 9 4 1 } bin-read-bulk ] unit-test
[ 127 ] [ B{ 9 4 127 } bin-read-bulk ] unit-test
[ -2 ] [ B{ 9 4 254 } bin-read-bulk ] unit-test
[ -128 ] [ B{ 9 4 128 } bin-read-bulk ] unit-test
[ -127 ] [ B{ 9 4 129 } bin-read-bulk ] unit-test
[ -127 ] [ B{ 9 5 255 129 } bin-read-bulk ] unit-test
[ -127 ] [ B{ 9 6 255 255 255 129 } bin-read-bulk ] unit-test
