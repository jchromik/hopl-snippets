-module(primesbenchmark).
-import(parprimes, [start/3]).
-import(seqprimes, [start/2]).
-export([parseqbenchmark/2]).

parseqbenchmark(Max,Step) ->
  io:format("N;parallel;sequential~n"),
  parseqbenchmark(0,Max,Step).

parseqbenchmark(Curr,Max,_) when Curr > Max -> ok;
parseqbenchmark(Curr,Max,Step) ->
  TP1 = os:timestamp(),
  parprimes:start(0,Curr,11),
  TP2 = os:timestamp(),
  TS1 = os:timestamp(),
  seqprimes:start(0,Curr),
  TS2 = os:timestamp(),
  io:format("~p;~p;~p~n", [Curr,timer:now_diff(TP2,TP1),timer:now_diff(TS2,TS1)]),
  parseqbenchmark(Curr+Step,Max,Step).
