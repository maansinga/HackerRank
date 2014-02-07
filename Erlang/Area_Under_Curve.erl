% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

main() ->
    Coes_string=io:get_line(""),
    Exps_string=io:get_line(""),
    Bounds_string=io:get_line(""),
    
    Coes_Tokens=string:tokens(string:substr(Coes_string,1,string:len(Coes_string)-1)," "),
    Exps_Tokens=string:tokens(string:substr(Exps_string,1,string:len(Exps_string)-1)," "),
    Bounds_Tokens=string:tokens(string:substr(Bounds_string,1,string:len(Bounds_string)-1)," "),

    C=buildValues(Coes_Tokens),
    E=buildValues(Exps_Tokens),
    [Start,End]=buildValues(Bounds_Tokens),

    io:format("~.1f~n",[area({equation,C,E},{bounds,Start,End},{step,0.001})]),
    io:format("~.1f~n",[volume({equation,C,E},{bounds,Start,End},{step,0.001})]).

buildValues(IntList)->buildValues([],IntList).
buildValues(Accum,[])->lists:reverse(lists:flatten(Accum));
buildValues(Accum,[Top|Array])->
    {Value,_}=string:to_integer(Top),
    buildValues([Value|Accum],Array).

solveEquation(_,[],[])->0;
solveEquation(X,[CT|C],[ET|E])->CT*math:pow(X,ET)+solveEquation(X,C,E).
    
mod(X) when X>=0->X;
mod(X) when X<0->-X.

area({equation,_,_},{bounds,Start,End},{step,_}) when  Start>=End->0;
area({equation,C,E},{bounds,Start,End},{step,Step}) when  Start<End->
    areaOfTrapezium({equation,C,E},{bounds,Start,Start+Step})
    +area({equation,C,E},{bounds,Start+Step,End},{step,Step}).

areaOfTrapezium({equation,C,E},{bounds,Start,End})->
    Y1=solveEquation(Start,C,E),
    Y2=solveEquation(End,C,E),
    mod(0.5*(Start-End)*(Y1+Y2)).

volumeOfTaperedDisk(R1,R2,H) ->math:pi()*H*(math:pow(R1,2)+R1*R2+math:pow(R2,2))/3.

volume({equation,_,_},{bounds,Start,End},{step,_}) when Start>=End ->0;
volume({equation,C,E},{bounds,Start,End},{step,Step}) when Start<End ->
    R1=solveEquation(Start,C,E),
    R2=solveEquation(Start+Step,C,E),
    volumeOfTaperedDisk(R1,R2,Step)+
    volume({equation,C,E},{bounds,Start+Step,End},{step,Step}).
