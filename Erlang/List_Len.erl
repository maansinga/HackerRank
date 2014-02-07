% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

main() ->
    Array=arrayBuilder(),
    io:format("~p~n",[arrayCounter(Array)]).

arrayBuilder()->arrayBuilder([]).
arrayBuilder(Array)->
    try io:fread("","~d") of
        {ok,[Number]}->arrayBuilder([Array|[Number]]);
        _->lists:flatten(Array)
    catch
        _->lists:flatten(Array)
    end.

arrayCounter(Array)->arrayCounter(Array,0).
arrayCounter([_|[]],Length)->Length+1;
arrayCounter([_|Array],Length)->arrayCounter(Array,Length+1).

