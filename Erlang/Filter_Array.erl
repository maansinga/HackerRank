% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

print_choose(Num,Val)when Num>Val->io:format("~p~n",[Val]);
print_choose(Num,Val)when Num=<Val->ok.

reader_and_printer(Number,Input)->
    print_choose(Number,Input),
    try io:fread("","~d") of
        {ok,[Read]}->reader_and_printer(Number,Read);
        _->ok
    catch
        _->ok
    end.

main() ->
    {ok,[Number]}=io:fread("","~d"),
    {ok,[Val]}=io:fread("","~d"),
    reader_and_printer(Number,Val).

