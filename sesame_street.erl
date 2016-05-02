-module(sesame_street).
-export([cookie_monster/0]).

cookie_monster() ->
  io:format("Cookie Monster spawned!\n"),
  receive
    c -> io:format("C Is For Cookie...\n");
    cookie -> io:format("Thank you!\n")
  end.
