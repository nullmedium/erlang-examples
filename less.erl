-module(less).
-export([list_file/1]).

read_file(IoDevice) ->
    case file:read_line(IoDevice) of
        {ok, Data} ->
            io:fwrite("~s", [Data]),
            read_file(IoDevice);
        eof ->
            eof;
        {error, Reason} ->
            {error, Reason}
    end.

list_file(File) ->
    {ok, IoDevice} = file:open(File, read),
    read_file(IoDevice),
    file:close(IoDevice).
