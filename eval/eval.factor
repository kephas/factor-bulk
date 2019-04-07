USING: bulk bulk.private classes combinators kernel sequences vectors ;
IN: bulk.eval

: eval ( env expr -- env expr )
    dup class-of
    { { bulk-word [ unsigned-integer ] }
      { vector [ [ eval ] map ] }
      [ drop ]
    } case ;
