% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

main() ->
    {ok,[Count]}=io:fread("","~d"),
    hello_world_printer(Count)
    .
hello_world_printer(Count)when Count>1->io:format('Hello World\n'),hello_world_printer(Count-1);
hello_world_printer(1)->io:format('Hello World').

