-module(parprimes).
-import(primes, [list_primes/3]).
-export([
  generator/4,
  merger/2,
  start/3
]).

generator(Merger, Begin, End, Step) ->
      Merger ! primes:list_primes(Begin, End, Step).

merger(From, Max) ->
  merger(From, 0, Max, []).

merger(From, Counter, Max, List) ->
  receive
    Result when Counter >= Max-1 ->
      From ! List ++ Result;
    Result ->
      merger(From, Counter+1, Max, List ++ Result)
  end.

start_merger(Num) ->
  spawn(parprimes, merger, [self(), Num]).

start_generators(Merger, Begin, End, Num) ->
  start_generators(Merger, Begin, End, Num, 0).

start_generators(_, _, _, Num, Num) -> ok;
start_generators(Merger, Begin, End, Num, Counter) ->
  spawn(parprimes, generator, [Merger, Begin+Counter, End, Num]),
  start_generators(Merger, Begin, End, Num, Counter+1).

loop() ->
  receive
    Result ->
      Result
  end.

start(Begin, End, Num) ->
  Merger = start_merger(Num),
  start_generators(Merger, Begin, End, Num),
  loop().
