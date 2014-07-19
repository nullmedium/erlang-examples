-module(sort).
-export([sort/1]).
-export([start/0]).

sort([Pivot|T]) ->
    sort([ X || X <- T, X < Pivot]) ++
    [Pivot] ++
    sort([ X || X <- T, X >= Pivot]);
sort([]) -> [].

start() -> 
    Values = [1,9,2,3,0],
    Sorted = sort(Values),
    io:fwrite("~s\n", [io:write(Sorted)]).
