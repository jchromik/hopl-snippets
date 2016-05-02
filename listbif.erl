-module(listbif).
-export([hd/1, tl/1, length/1]).

hd([Head|_]) -> Head.

tl([_|Tail]) -> Tail.

length(List) -> length(List,0).

length([],Len) -> Len;
length([_|Tail],Len) -> length(Tail,Len+1).
