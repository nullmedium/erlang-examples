-module(echo_server).
-export([start/0]).
-export([listener/1]).

start() ->
    io:format("Listening on port 1234 for connections... "),
	case gen_tcp:listen(1234, [binary, {packet, 0}, {active, false}]) of
	    {ok, LSock} ->
            spawn(fun() -> listener(LSock) end),
            timer:sleep(infinity);
	    {error,eaddrinuse} ->
	    	io:format("Error: address in use\n")
	end.

listener(LSock) ->
    {ok, Sock} = gen_tcp:accept(LSock),
    io:format("Accepted connection on port 1234!\n"),
    spawn(fun() -> listener(LSock) end),
    {ok, _} = do_recv(Sock, []),
    ok = gen_tcp:close(Sock),
    io:format("Connection to client closed!\n").

do_recv(Sock, Bs) ->
    case gen_tcp:recv(Sock, 0) of
        {ok, B} ->
            case string:equal(line(binary_to_list(B)), "exit.") of
                true ->	
                	gen_tcp:send(Sock, ["Good bye!\n"]),
                	{ok, B};
                false ->
                    Ret = io_lib:format("You said: ~s", [B]),
                    gen_tcp:send(Sock, [Ret]),
                    do_recv(Sock, [Bs, B])
            end;
        {error, closed} ->
            {ok, list_to_binary(Bs)}
    end.

line(Str) -> hd(string:tokens(Str, "\r\n ")).
