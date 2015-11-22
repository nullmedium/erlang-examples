-module(clock).
-export([clock/0, start/0]).

clock() ->
	receive
		{Started} ->
			{H, M, S} = time(),
    		io:format("~2..0b:~2..0b:~2..0b~c", [H, M, S, 13])
	end,
	erlang:hibernate(clock, clock, []).

start() ->
	Pid = spawn(clock, clock, []),
	{ok, TRef} = timer:send_interval(1000, Pid, {os:system_time(seconds)}),
	erlang:hibernate(clock, start, []).
