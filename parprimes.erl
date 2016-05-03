-module(parprimes).
-compile(export_all).

is_prime(Num) -> is_prime_helper(Num, 2).

is_prime_helper(Num, _) when Num < 2 -> false;
is_prime_helper(Num, Curr) when Curr > Num div 2 -> true;
is_prime_helper(Num, Curr) when Num rem Curr =/= 0 -> is_prime_helper(Num, Curr+1);
is_prime_helper(Num, Curr) when Num rem Curr == 0 -> false.

list_primes(Begin, End, Step) ->
  lists:filter(fun is_prime/1, lists:seq(Begin, End, Step)).

prime_gen_loop() ->
  receive
    {From, exit} ->
      From ! exited;
    {Merger, {Begin, End, Step}} ->
      io:format("GENERATOR: got {~p, {~p, ~p, ~p}}~n", [Merger, Begin, End, Step]),
      Merger ! {self(), list_primes(Begin, End, Step)},
      prime_gen_loop()
  end.

prime_merge_loop(Counter, Max, List) ->
  receive
    {From, exit} ->
      From ! exited;
    {Generator, Result} when Counter >= Max-1 ->
      Generator ! ok,
      io:format("Result: ~p~n", [List ++ Result]);
    {Generator, Result} ->
      io:format("MERGER: got {~p, ~p}~n", [Generator, Result]),
      Generator ! ok,
      prime_merge_loop(Counter+1, Max, List ++ Result)
  end.

spawn_generators(Num) -> spawn_generators_helper(Num, []).

spawn_generators_helper(0, Pids) -> Pids;
spawn_generators_helper(Num, Pids) ->
  io:format("spawning generator ~p~n", [length(Pids)+1]),
  Fun = fun() -> prime_gen_loop() end,
  Pid = spawn(Fun),
  spawn_generators_helper(Num-1, [ Pid | Pids ]).

spawn_merger(Num) ->
  io:format("spawning merger~n"),
  Fun = fun() -> prime_merge_loop(0, Num, []) end,
  spawn(Fun).

start_generators(_, _, [], _, _) -> ok;
start_generators(Begin, End, [Generator | Rest], Merger, Num) ->
  io:format("starting generator ~p~n", [Num - length(Rest)]),
  Generator ! {Merger, {Begin + length(Rest), End, Num}},
  start_generators(Begin, End, Rest, Merger, Num).

start(Begin, End, Num) ->
  Generators = spawn_generators(Num),
  Merger = spawn_merger(Num),
  start_generators(Begin, End, Generators, Merger, Num).