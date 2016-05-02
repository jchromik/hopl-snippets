-module(obvious).
-export([comment/1]).

comment(X) ->
  case X of
    [] -> io:format("This is an empty list.\n");
    [_|_] -> io:format("This is a non-empty list.\n");
    X when is_number(X) -> io:format("This is a number.\n");
    _ -> io:format("What's that?\n")
  end.
