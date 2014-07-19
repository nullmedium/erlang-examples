-module(factorial).
-export([factorial/1]).
-export([start/0]).

factorial(0) -> 1;
factorial(N) -> N * factorial(N-1).

start() ->
    Result = factorial(10),
    io:fwrite("factorial(10) = ~B\n", [Result]).

    