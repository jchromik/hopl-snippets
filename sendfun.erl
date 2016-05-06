-module(sendfun).
-export([receiver/1]).

receiver(Arg1) ->
  receive
    {From,Fun} when is_pid(From), is_function(Fun) ->
      io:format("called"),
      From ! apply(Fun, [Arg1])
  end.
