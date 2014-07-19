-module(echo_server).
-export([start/0]).

start() ->
	case gen_tcp:listen(1234, [binary, {packet, 0}, {active, false}]) of
	    {ok, LSock} ->
	        {ok, Sock} = gen_tcp:accept(LSock),
		    {ok, _} = do_recv(Sock, []),
		    ok = gen_tcp:close(Sock);
	    {error,eaddrinuse} ->
	    	io:format("Error: address in use")
	end.

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
