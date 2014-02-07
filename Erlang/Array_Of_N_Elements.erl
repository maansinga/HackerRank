% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

array_builder(Count) when Count>1->[Count|array_builder(Count-1)];
array_builder(1)->[1].
    
main() ->
    {ok, [N]} = io:fread("", "~d"),
% Fill up these questions marks to call a function (written by you)
% Which creates an array with N elements     
    Arr=array_builder(N),
   io:format("~B~n", [length(Arr)]).
% Do not change the lines of code already present.
% That is to assist us in evaluating whether the array you created
% has, indeed N elements.
