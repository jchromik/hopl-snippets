-module(dontquit).
-export([dostuff/0]).

dostuff() ->
  receive
    _ -> io:format("Still alive!\n")
  end,
  dostuff().
