-module(sign).
-export([sign/1]).

sign(X) when X < 0 -> -1;
sign(X) when X > 0 -> 1;
sign(_) -> 0.
