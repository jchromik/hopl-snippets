-module(primesbenchmark).
-import(parprimes, [start/3]).
-import(seqprimes, [start/2]).
-export([parseqbenchmark/3]).

printheader(Num) ->
  io:format("N"),
  printheader(0,Num,"parallel"),
  printheader(0,Num,"sequential"),
  io:format("~n").

printheader(Num,Num,_) -> ok;
printheader(Curr,Num,Text) ->
  io:format(";" ++ Text ++ "~p",[Curr]),
  printheader(Curr+1,Num,Text).

parseqbenchmark(Max,Step,Num) ->
  printheader(Num),
  parseqbenchmark(0,Max,Step,Num).

parseqbenchmark(Curr,Max,_,_) when Curr > Max -> ok;
parseqbenchmark(Curr,Max,Step,Num) ->
  io:format("~p",[Curr]),
  printParTimesArray(Curr,0,Num),
  printSeqTimesArray(Curr,0,Num),
  io:format("~n"),
  parseqbenchmark(Curr+Step,Max,Step,Num).

printParTimesArray(_,Num,Num) -> ok;
printParTimesArray(N,Curr,Num) ->
  TP1 = os:timestamp(),
  parprimes:start(0,N,11),
  TP2 = os:timestamp(),
  io:format(";~p", [timer:now_diff(TP2,TP1)]),
  printParTimesArray(N,Curr+1,Num).

printSeqTimesArray(_,Num,Num) -> ok;
printSeqTimesArray(N,Curr,Num) ->
  TS1 = os:timestamp(),
  seqprimes:start(0,N),
  TS2 = os:timestamp(),
  io:format(";~p", [timer:now_diff(TS2,TS1)]),
  printSeqTimesArray(N,Curr+1,Num).
