USING: tools.test kernel bulk bulk.eval bulk.private io.encodings.binary io.streams.byte-array ;
IN: bulk.tests

: bin-read-bulk ( bytes -- expr ) binary [ read-bulk ] with-byte-reader ;

[ 1 ] [ B{ 4 1 } bin-read-bulk eval ] unit-test
[ 1 ] [ B{ 5 0 1 } bin-read-bulk eval ] unit-test
[ 1 ] [ B{ 6 0 0 0 1 } bin-read-bulk eval ] unit-test
[ 16777216 ] [ B{ 6 1 0 0 0 } bin-read-bulk eval ] unit-test

[ -2 ] [ { 254 } bulk-word boa signed-integer ] unit-test
[ 127 ] [ { 127 } bulk-word boa signed-integer ] unit-test
[ 0 ] [ { 0 } bulk-word boa signed-integer ] unit-test
[ -127 ] [ { 129 } bulk-word boa signed-integer ] unit-test
[ -128 ] [ { 128 } bulk-word boa signed-integer ] unit-test

[ nil ] [ B{ 0 } bin-read-bulk ] unit-test

[ V{ } ] [ B{ 1 2 } bin-read-bulk ] unit-test
[ V{ nil } ] [ B{ 1 0 2 } bin-read-bulk ] unit-test
[ V{ V{ } } ] [ B{ 1 1 2 2 } bin-read-bulk ] unit-test
[ V{ V{ } V{ } } ] [ B{ 1 1 2 1 2 2 } bin-read-bulk ] unit-test

[ { } ] [ B{ 3 4 0 } bin-read-bulk ] unit-test
[ { 11 22 } ] [ B{ 3 4 2 11 22 } bin-read-bulk eval ] unit-test

[ 1 ] [ B{ 4 1 } bin-read-bulk eval ] unit-test
[ 1 ] [ B{ 4 1 0 } bin-read-bulk eval ] unit-test
[ 256 ] [ B{ 5 1 0 } bin-read-bulk eval ] unit-test
[ 256 ] [ B{ 5 1 0 0 } bin-read-bulk eval ] unit-test

[ -1 ] [ B{ 9 1 } bin-read-bulk eval ] unit-test
[ -127 ] [ B{ 9 127 } bin-read-bulk eval ] unit-test
[ -254 ] [ B{ 9 254 } bin-read-bulk eval ] unit-test
