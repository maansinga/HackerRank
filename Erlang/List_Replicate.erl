% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

main() ->
    {ok,[Count]}=io:fread("","~d"),
    Array=reader([]),
    iterator(Array,Count)
	.

reader(Array)->
    try io:fread("","~d") of
        {ok,[Value]}->reader([Array|[Value]]);
        _->lists:flatten(Array)
    catch
        _->lists:flatten(Array)
    end.

repeater(Num,Count) when Count>0 ->io:format("~p~n",[Num]),repeater(Num,Count-1);
repeater(Num,Count) when Count==0 ->ok.

iterator([],_)->ok;
iterator([Top|Array],Count)->repeater(Top,Count),iterator(Array,Count).

