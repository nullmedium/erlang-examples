-module(math).
-export([double/1]).
-export([mult/2]).
-export([sum/1]).
-export([power/2]).
-export([fac/1]).

fac(0) -> 1;
fac(N) -> N * fac(N-1).

double(X) ->
	mult(X, 2).

mult(X, N) ->
	X * N.

power(_, 0) -> 
    1;
power(X, N) ->
	X * power(X, N-1).

sum([]) ->
	0;
sum([H|T]) ->
	H + sum(T).
