-module(pingpong).
-export([start/0, pong/2]).

pong(0,_) -> io:fwrite("~n", []);
pong(N,Str) ->
    receive
        {Pid} ->
                io:fwrite("~s ", [Str]),
                Pid ! { self() }
    end,
    pong(N-1, Str).

start() ->
    PingPid = spawn(pingpong, pong, [10, "ping"]), 
    PongPid = spawn(pingpong, pong, [10, "pong"]),
    PingPid ! { PongPid }.