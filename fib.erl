-module(fib).
-export([fib/1]).

fib(0) -> 0;
fib(1) -> 1;
fib(X) -> fib(X-1) + fib(X-2).
