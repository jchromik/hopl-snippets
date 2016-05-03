-module(seqprimes).
-compile(export_all).

is_prime(Num) -> is_prime_helper(Num, 2).

is_prime_helper(Num, _) when Num < 2 -> false;
is_prime_helper(Num, Curr) when Curr > Num div 2 -> true;
is_prime_helper(Num, Curr) when Num rem Curr =/= 0 -> is_prime_helper(Num, Curr+1);
is_prime_helper(Num, Curr) when Num rem Curr == 0 -> false.

list_primes(Begin, End) ->
  lists:filter(fun is_prime/1, lists:seq(Begin, End)).

benchmark(Begin, End) ->
  T1 = os:timestamp(),
  list_primes(Begin, End),
  T2 = os:timestamp(),
  timer:now_diff(T2,T1).
