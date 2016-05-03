-module(primes).
-export([
  is_prime/1,
  list_primes/1,
  list_primes/2,
  list_primes/3
]).

is_prime(Num) ->
  is_prime_helper(Num, 2).

is_prime_helper(Num, _) when Num < 2 ->
  false;
is_prime_helper(Num, Curr) when Curr > Num div 2 ->
  true;
is_prime_helper(Num, Curr) when Num rem Curr =/= 0 ->
  is_prime_helper(Num, Curr+1);
is_prime_helper(Num, Curr) when Num rem Curr == 0 ->
  false.

list_primes(End) ->
  list_primes(2, End).

list_primes(Begin, End) ->
  list_primes(Begin, End, 1).

list_primes(Begin, End, Step) ->
  lists:filter(fun is_prime/1, lists:seq(Begin, End, Step)).
