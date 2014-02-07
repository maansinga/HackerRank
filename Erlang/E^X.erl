
-module(solution).
-export([main/0]).

main() ->
    {ok,[Size]}=io:fread("","~d"),
    Array=arrayBuilder(Size),
    arrayPrinter(perform(Array)).

arrayBuilder(Size)->arrayBuilder(Size,[]).

arrayBuilder(0,Array)->lists:flatten(Array);
arrayBuilder(Size,Array)->
    try io:fread("","~f") of
        {ok,[Input]}->arrayBuilder(Size-1,[Array|[Input]]);
        {error,_}->io:format("Some error occured!~n")
    catch
        {error,_}->io:format("Some error occured!~n")    
    end.

arrayPrinter([Top|[]])->io:format("~.5g~n",[Top]);
arrayPrinter([Top|Array])->io:format("~.5g~n",[Top]),arrayPrinter(Array).

factorial(1)->1;
factorial(X)->X*factorial(X-1).

ePowerX(X)->ePowerX(X,10).

ePowerX(X,0)->1;
ePowerX(X,Exp)->ePowerX(X,Exp-1)+(math:pow(X,Exp)/factorial(Exp)).

perform(Array)->perform(Array,[]).

perform([],Accum)->lists:flatten(Accum);
perform([Top|Array],Accum)->perform(Array,[Accum|[ePowerX(Top)]]).
