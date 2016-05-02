-module(err).
-compile(export_all).

is_ok({ok,_}) -> true;
is_ok(_) -> false.

is_errornous(X) -> not is_ok(X).
