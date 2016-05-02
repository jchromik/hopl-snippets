-module(double).
-export([double/1,double2/1]).

double(X) -> X*2.

double2(X) ->
  Y = X*2,
  Y.
