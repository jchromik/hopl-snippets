-module(pbench).
-import(parprimes,[start/3]).
-import(seqprimes,[start/2]).
-export([
  csv/1,
  multi/4,
  series/3,
  observation/1
]).

csv([]) -> ok;
csv([{N,Time,Tag}|Tail]) ->
  io:format("~p;~p;~p~n",[N,Time,Tag]),
  csv(Tail).

multi(Min,Max,Step,Num) ->
  multi(Min,Max,Step,0,Num,[]).

multi(_,_,_,Num,Num,Result) -> Result;
multi(Min,Max,Step,Curr,Num,Result) ->
  multi(Min,Max,Step,Curr+1,Num,Result ++ series(Min,Max,Step)).

series(Min,Max,Step) ->
  series(Min,Max,Step,[]).

series(N,Max,_,Result) when N > Max -> Result;
series(N,Max,Step,Result) ->
  series(N+Step,Max,Step,Result ++ observation(N)).

observation(N) ->
  TP1 = os:timestamp(),
  parprimes:start(0,N,11),
  TP2 = os:timestamp(),
  TS1 = os:timestamp(),
  seqprimes:start(0,N),
  TS2 = os:timestamp(),
  [
  {N,timer:now_diff(TP2,TP1),parallel},
  {N,timer:now_diff(TS2,TS1),sequential}
  ].
