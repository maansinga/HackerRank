% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

main() ->
    {ok,[Count]}=io:fread("","~d"),
    Array=buildArray(Count),
    Max=getMax(Array),
    Fib=buildFibonacci(Max),
    printArray(perform(Array,Fib)).

buildArray(Count)->buildArray(Count,[]).

buildArray(0,Array)->lists:flatten(Array);
buildArray(Count,Array)->
    try io:fread("","~d") of
        {ok,[Input]}->buildArray(Count-1,[Array|[Input]]);
        {error,_}->io:format("Some error has occured while reading")
    catch
        _->io:format("Some error has occured while reading")
    end.

getMax(Array)->getMax(0,Array).

getMax(Active,[])->Active;
getMax(Active,[Top|Array]) when Top>=Active->getMax(Top,Array);
getMax(Active,[Top|Array]) when Top<Active->getMax(Active,Array).

arrayAtIndex([Top|_],0)->Top;
arrayAtIndex([_|Array],Index) when Index>0->arrayAtIndex(Array,Index-1).
    
buildFibonacci(Size)->buildFibonacci([1,0],Size,1).

buildFibonacci(Accum,Size,Size)->lists:reverse(lists:flatten(Accum));
buildFibonacci(Accum,Size,Iter) when Iter<Size ->
    [N_1|[N_2|_]]=Accum,
    buildFibonacci([N_1+N_2|Accum],Size,Iter+1).
    
printArray([])->ok;
printArray([Top|Array])->io:format("~p~n",[Top]),printArray(Array).


perform(Array,Fib)->perform([],Array,Fib).

perform(Accum,[],_)->lists:reverse(lists:flatten(Accum));
perform(Accum,[Top|Array],Fib)->
    FibValue=arrayAtIndex(Fib,Top),
    Compute=(FibValue rem round(math:pow(10,8)+7)),
    perform([Compute|Accum],Array,Fib).
