-module(hello).
-export([hello/1]).

hello(0) -> [];
hello(N) ->
	io:fwrite("hello, world\n"),
    hello(N-1).

