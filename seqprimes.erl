-module(seqprimes).
-import(primes, [list_primes/2]).
-export([start/2]).

start(Begin, End) ->
  primes:list_primes(Begin, End).
