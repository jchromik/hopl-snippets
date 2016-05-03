-module(seqprimes).
-import(primes, [list_primes/2]).
-export([benchmark/2]).

benchmark(Begin, End) ->
  T1 = os:timestamp(),
  primes:list_primes(Begin, End),
  T2 = os:timestamp(),
  timer:now_diff(T2,T1).
