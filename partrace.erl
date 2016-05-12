-module(partrace).
-import(primes, [list_primes/3]).
-compile(export_all).

generator(Merger, Begin, End, Step) ->
  io:format("GENERATOR: Started.~n"),
  Merger ! primes:list_primes(Begin, End, Step).

merger(From, Max) ->
  io:format("MERGER    : Started.~n"),
  merger(From, 0, Max, []).

merger(From, Counter, Max, List) ->
  receive
    Result when Counter >= Max-1 ->
      io:format("MERGER    : Got result from generator ~p.~n",[Counter]),
      io:format("MERGER    : Got all results. Sending to MAIN.~n"),
      From ! List ++ Result;
    Result ->
      io:format("MERGER    : Got result from generator ~p.~n",[Counter]),
      merger(From, Counter+1, Max, List ++ Result)
  end.

start_merger(Num) ->
  spawn(partrace, merger, [self(), Num]).

start_generators(Merger, Begin, End, Num) ->
  start_generators(Merger, Begin, End, Num, 0).

start_generators(_, _, _, Num, Num) -> ok;
start_generators(Merger, Begin, End, Num, Counter) ->
  io:format("MAIN      : Starting generator ~p.~n", [Counter]),
  spawn(partrace, generator, [Merger, Begin+Counter, End, Num]),
  start_generators(Merger, Begin, End, Num, Counter+1).

loop() ->
  receive
    Result ->
      io:format("MAIN      : Got result.~n"),
      Result
  end.

start(Begin, End, Num) ->
  io:format("MAIN      : Starting merger.~n"),
  Merger = start_merger(Num),
  io:format("MAIN      : Starting generators.~n"),
  start_generators(Merger, Begin, End, Num),
  io:format("MAIN      : Waiting for results.~n"),
  loop().
