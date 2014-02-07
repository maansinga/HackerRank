% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

main() ->
    {ok,[Input]}=io:fread("","~d"),
    io:format("~p~n",[fibonacci(Input)]).


fibonacci(1)->0;
fibonacci(2)->1;
fibonacci(N) when N>2 ->fibonacci(N-2)+fibonacci(N-1).
