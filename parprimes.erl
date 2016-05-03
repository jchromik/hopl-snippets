-module(parprimes).
-import(primes, [list_primes/3]).
-compile(export_all).

generator(Merger, Begin, End, Step) ->
      Merger ! primes:list_primes(Begin, End, Step).

merger(Counter, Max, List) ->
  merger(Counter, Max, List, os:timestamp()).

merger(Counter, Max, List, StartTime) ->
  receive
    Result when Counter >= Max-1 ->
      io:format("Result: ~p~n", [List ++ Result]),
      io:format("Duration: ~p~n", [timer:now_diff(os:timestamp(), StartTime)]);
    Result ->
      merger(Counter+1, Max, List ++ Result, StartTime)
  end.

start_merger(Num) ->
  spawn(parprimes, merger, [0, Num, []]).

start_generators(Merger, Begin, End, Num) ->
  start_generators(Merger, Begin, End, Num, 0).

start_generators(_, _, _, Num, Num) -> ok;
start_generators(Merger, Begin, End, Num, Counter) ->
  spawn(parprimes, generator, [Merger, Begin+Counter, End, Num]),
  start_generators(Merger, Begin, End, Num, Counter+1).

start(Begin, End, Num) ->
  Merger = start_merger(Num),
  start_generators(Merger, Begin, End, Num).
