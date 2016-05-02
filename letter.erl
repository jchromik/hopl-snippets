-module(letter).
-export([salutation/1]).

salutation(male) -> "Mr.";
salutation(female) -> "Mrs.";
salutation(_) ->
  "You wonderful person".
