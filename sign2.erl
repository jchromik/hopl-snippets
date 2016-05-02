-module(sign2).
-export([sign/1]).

sign(X) ->
  if
    X < 0 -> -1;
    X > 0 -> 1;
    true -> 0
  end.
