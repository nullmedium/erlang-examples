-module(counter).
-export([printer/0, start/0]).

printer() ->
	receive
		{N} -> io:format("~B~n", [N])
	end,
	erlang:hibernate(counter, printer, []).

count(Pid, N) ->
	if
		N =< 10 ->
			Pid ! {N},
			timer:sleep(1000),
			count(Pid, N+1);
		true ->
			io:format("done!~n"),
			[]
	end.

start() ->
	Pid = spawn(counter, printer, []),
	count(Pid, 1).
