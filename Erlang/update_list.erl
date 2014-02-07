% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

main() ->
    {ok,[X]}=io:fread("","~d"),
    %io:format("Read ~p",[X]).
    try absoluter(X) of
        _->ok
    catch
        error:badmatch->ok
    end.

absoluter(Val)->
    io:format("~p~n",[absolution(Val)]),
    try io:fread("","~d") of
        {ok,[X]}->absoluter(X);
        _->ok
    catch
         _:_->ok
    end,
    ok.
    
    
absolution(Val)when Val>=0->Val;
absolution(Val)when Val<0->-Val.
