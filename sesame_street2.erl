-module(sesame_street2).
-export([cookie_monster/0]).

cookie_monster() ->
  io:format("Cookie Monster spawned with pid ~p!~n", [self()]),
  receive
    {Pid,c} ->
      Pid ! "C Is For Cookie...",
      cookie_monster();
    {Pid,cookie} ->
      Pid ! "Thank you!";
    {Pid,_} ->
      Pid ! "What's that?",
      cookie_monster();
    _ ->
      io:format("I can't work like that!!!~n"),
      cookie_monster()
  end.
