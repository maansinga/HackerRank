% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

main() ->arrayPrinter(arrayReverser(arrayBuilder())).

arrayBuilder()->arrayBuilder([]).
arrayBuilder(Array)->
    try io:fread("","~d") of
        {ok,[Number]}->arrayBuilder([[Number]|Array]);
        _->lists:flatten(Array)
    catch
        _->lists:flatten(Array)
    end.
arrayReverser(Array)->arrayReverser(Array,[]).
arrayReverser([Top|[]],Target)->lists:flatten([Target|[Top]]);
arrayReverser([Top|Source],Target)->arrayReverser(Source,[Target|[Top]]).

arrayPrinter([Top|[]])->io:format("~p~n",[Top]);
arrayPrinter([Top|Array])->io:format("~p~n",[Top]),arrayPrinter(Array).
