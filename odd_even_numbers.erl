-module(odd_even_numbers).
-export([start/0]).

%% only keep even numbers
even(L) -> lists:reverse(even(L,[])).
even([], Acc) -> Acc;

even([H|T], Acc) when H rem 2 == 0 ->
    even(T, [H|Acc]);
even([_|T], Acc) ->
    even(T, Acc).

%% only keep odd numbers
odd(L) -> lists:reverse(odd(L,[])).
odd([], Acc) -> Acc;

odd([H|T], Acc) when H rem 2 /= 0 ->
    odd(T, [H|Acc]);
odd([_|T], Acc) ->
    odd(T, Acc).

start() ->
    Numbers = lists:seq(0, 20),
    EvenNumbers = even(Numbers),
    OddNumbers = odd(Numbers),

    io:format("even numbers: ~s\n", [ io_lib:write(EvenNumbers) ]),
    io:format("odd numbers: ~s\n", [ io_lib:write(OddNumbers) ]).
