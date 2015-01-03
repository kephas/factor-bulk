USING: tools.test kernel bulk io.encodings.binary io.streams.byte-array ;
IN: bulk.tests

: with-bulk ( bytes quot -- ) binary swap with-byte-reader ; inline

[ 1 ] [ B{ 1 } [ 1 read-word ] with-bulk ] unit-test
[ 1 ] [ B{ 0 1 } [ 2 read-word ] with-bulk ] unit-test
[ 1 ] [ B{ 0 0 0 1 } [ 4 read-word ] with-bulk ] unit-test
[ 16777216 ] [ B{ 1 0 0 0 } [ 4 read-word ] with-bulk ] unit-test
