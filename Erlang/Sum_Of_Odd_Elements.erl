% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0]).

reader(Array)->
    try io:fread("","~d") of
        {ok,[Input]}->reader([Array|[Input]]);
        _->lists:flatten(Array)
    catch
        _:_->ok
    end.

adder(Array)->adder(Array,1,0).
adder([Top|Array],Iter,Accum) when Top>=0 , Top rem 2 == 1 ->adder(Array,Iter+1,Accum+Top);
adder([Top|Array],Iter,Accum) when Top<0 , -Top rem 2 == 1 ->adder(Array,Iter+1,Accum+Top);
adder([Top|Array],Iter,Accum) when Top>=0 , Top rem 2 == 0 ->adder(Array,Iter+1,Accum);
adder([Top|Array],Iter,Accum) when Top<0 , -Top rem 2 == 0 ->adder(Array,Iter+1,Accum);
adder([],_,Accum)->Accum.

main() ->
    Array=reader([]),
    io:format("~p",[adder(Array)]).

