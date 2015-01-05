USING: tools.test kernel bulk bulk.private io.encodings.binary io.streams.byte-array ;
IN: bulk.tests

: with-bulk ( bytes quot -- ) binary swap with-byte-reader ; inline

[ 1 ] [ B{ 1 } [ 1 read-word ] with-bulk ] unit-test
[ 1 ] [ B{ 0 1 } [ 2 read-word ] with-bulk ] unit-test
[ 1 ] [ B{ 0 0 0 1 } [ 4 read-word ] with-bulk ] unit-test
[ 16777216 ] [ B{ 1 0 0 0 } [ 4 read-word ] with-bulk ] unit-test

[ -2 ] [ 254 1 parse-2c-notation ] unit-test
[ 127 ] [ 127 1 parse-2c-notation ] unit-test
[ 0 ] [ 0 1 parse-2c-notation ] unit-test
[ -127 ] [ 129 1 parse-2c-notation ] unit-test
[ -128 ] [ 128 1 parse-2c-notation ] unit-test

[ nil ] [ B{ 0 } [ read-bulk ] with-bulk ] unit-test

[ 1 ] [ B{ 4 1 } [ read-bulk ] with-bulk ] unit-test
[ 1 ] [ B{ 4 1 0 } [ read-bulk ] with-bulk ] unit-test
[ 256 ] [ B{ 5 1 0 } [ read-bulk ] with-bulk ] unit-test
[ 256 ] [ B{ 5 1 0 0 } [ read-bulk ] with-bulk ] unit-test
