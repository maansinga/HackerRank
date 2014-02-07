% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

main() ->
    oddPrinter(arrayBuilder()).

arrayBuilder()->arrayBuilder([]).
arrayBuilder(Array)->
    try io:fread("","~d") of
        {ok,[Number]}->arrayBuilder([Array|[Number]]);
        _->lists:flatten(Array)
    catch
        _->lists:flatten(Array)
    end.

oddPrinter(Array)->oddPrinter(Array,0).
oddPrinter([Top|[]],Iter) when Iter rem 2 ==1 ->io:format("~p~n",[Top]);
oddPrinter([_|[]],Iter) when Iter rem 2 ==0 ->ok;
oddPrinter([Top|Array],Iter) when Iter rem 2 ==1 -> io:format("~p~n",[Top]),oddPrinter(Array,Iter+1);
oddPrinter([_|Array],Iter) when Iter rem 2 ==0 -> oddPrinter(Array,Iter+1).
