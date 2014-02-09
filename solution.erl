% Enter your code here. Read input from STDIN. Print output to STDOUT
% Your class should be named solution

-module(solution).
-export([main/0,prepareMemory/2,setData/3]).

main() ->
    {ok,[N,M]}=io:fread("","~d ~d"),
    Input=readInput(N),
    Program=readProgram(M),
    % io:format("Input::~p~n~n",[Input]),
    % io:format("Program::~p~n~n",[Program])
    bfEngine({Program,[],0,0,Input,0,[]})
    .
%Read Input
readInput(Count)->
    if 
        Count>0->Input=string:substr(io:get_line(""),1,Count);
        true->io:get_line(""),Input=""
    end,
    Input.

%Reading Program
readProgram(Lines)->readProgram(Lines,"").
readProgram(Lines,Read)when Lines=<0->cleanProgram(Read);
readProgram(Lines,Read)when Lines>0->readProgram(Lines-1,Read++io:get_line("")).

%Clean Program
isValidSymbol(Symbol)->
    case Symbol of
        $[->true;
        $]->true;
        $+->true;
        $-->true;
        $>->true;
        $<->true;
        $.->true;
        $,->true;
        _->false
    end.
cleanProgram(Program)->cleanProgram(Program,"").
cleanProgram(eof,Accum)->lists:reverse(lists:flatten(Accum));
cleanProgram("",Accum)->lists:reverse(lists:flatten(Accum));
cleanProgram([Top|Program],Accum)->
    case isValidSymbol(Top) of
        true->cleanProgram(Program,[Top|Accum]);
        false->cleanProgram(Program,Accum)
    end.
% State {Program,Memory,IP,DP,Data,Counter,LS}

%SubRoutines
getData([],_)->0;
getData([Top|_],Index) when Index==0->Top;
getData([_|Array],Index) when Index>0->getData(Array,Index-1).

prepareMemory([],-1)->[];
prepareMemory(Memory,Index)->prepareMemory([],Memory,Index).
prepareMemory(Carry,Memory,-1)->lists:flatten([lists:reverse(Carry)|Memory]);
prepareMemory(Carry,[],Index)->prepareMemory([0|Carry],[],Index-1);
prepareMemory(Carry,[Top|Memory],Index)->prepareMemory([Top|Carry],Memory,Index-1).

setData([],Index,Val)->setData(prepareMemory([],Index),Index,Val);
setData(Array,Index,Val)->setData([],Array,Index,Val).
setData(Left,[],Index,Val)when Index==0->lists:reverse([Val|Left]);
setData(Left,[],Index,Val)when Index>0->setData([0|Left],[],Index,Val);
setData(Left,[_|Right],0,Val)->lists:reverse([Val|Left])++Right;
setData(Left,[Top|Right],Index,Val)->setData([Top|Left],Right,Index-1,Val).
    
incData([],Index)->incData(prepareMemory([],Index),Index);
incData(Array,Index)->incData([],Array,Index).
incData(Right,[],0)->lists:flatten(lists:reverse([1|Right]));
incData(Right,[],Index)when Index>0->incData([0|Right],[],Index-1);
incData(Right,[Top|Array],Index)when Index==0,Top+1>255->lists:flatten(lists:reverse([0|Right]))++Array;
incData(Right,[Top|Array],Index)when Index==0->lists:flatten(lists:reverse([Top+1|Right]))++Array;
incData(Right,[Top|Array],Index)when Index>0->incData([Top|Right],Array,Index-1).

decData([],Index)->decData(prepareMemory([],Index),Index);
decData(Array,Index)->decData([],Array,Index).
decData(Right,[],0)->lists:flatten(lists:reverse([255|Right]));
decData(Right,[],Index)when Index>0->decData([0|Right],[],Index-1);
decData(Right,[Top|Array],Index)when Index==0,Top-1<0->lists:flatten(lists:reverse([255|Right]))++Array;
decData(Right,[Top|Array],Index)when Index==0->lists:flatten(lists:reverse([Top-1|Right]))++Array;
decData(Right,[Top|Array],Index)when Index>0->decData([Top|Right],Array,Index-1).

incDP({Program,Memory,IP,DP,Data,Counter,LS})->{Program,Memory,IP+1,DP+1,Data,Counter+1,LS}.                                    %>

decDP({Program,Memory,IP,0,Data,Counter,LS})->{Program,Memory,IP+1,0,Data,Counter+1,LS};                                      %<
decDP({Program,Memory,IP,DP,Data,Counter,LS})->{Program,Memory,IP+1,DP-1,Data,Counter+1,LS}.                                    %<

inc({Program,Memory,IP,DP,Data,Counter,LS})->{Program,incData(Memory,DP),IP+1,DP,Data,Counter+1,LS}.                        %+
dec({Program,Memory,IP,DP,Data,Counter,LS})->{Program,decData(Memory,DP),IP+1,DP,Data,Counter+1,LS}.                                       %-

printData({Program,Memory,IP,DP,Data,Counter,LS})->io:format("~c",[getData(Memory,DP)]),{Program,Memory,IP+1,DP,Data,Counter+1,LS}. %.
readData({Program,Memory,IP,DP,[Top|Data],Counter,LS})->{Program,setData(Memory,DP,Top),IP+1,DP,Data,Counter+1,LS}. %,

loopStart({Program,Memory,IP,DP,Data,Counter,LS})->{Program,Memory,IP+1,DP,Data,Counter+1,lists:flatten([IP+1|LS])}.            %[
loopReiter({Program,Memory,_,DP,Data,Counter,[Top|LS]})->{Program,Memory,Top,DP,Data,Counter+1,lists:flatten([Top|LS])}.       %]
loopEnd({Program,Memory,IP,DP,Data,Counter,[_|LS]})->{Program,Memory,IP+1,DP,Data,Counter+1,LS}.                              %]

bfEngine({Program,Memory,IP,DP,Data,Counter,LS})->
    % io:get_line("Continue..."),
    % io:format("~p~n",[{Program,Memory,IP,DP,Data,Counter,LS}]),
    ProgramLength=string:len(Program),
    if 
        Counter>100000->io:format("~nPROCESS TIME OUT. KILLED!!!");
        ProgramLength<IP->io:format("",[]);
        true->
            CurrentInstruction=getData(Program,IP),
            CurrentData=getData(Memory,DP),
            case CurrentInstruction of
                $> -> bfEngine(incDP({Program,Memory,IP,DP,Data,Counter,LS}));
                $< -> bfEngine(decDP({Program,Memory,IP,DP,Data,Counter,LS}));
                $+ -> bfEngine(inc({Program,Memory,IP,DP,Data,Counter,LS}));
                $- -> bfEngine(dec({Program,Memory,IP,DP,Data,Counter,LS}));
                $. -> bfEngine(printData({Program,Memory,IP,DP,Data,Counter,LS}));
                $, -> bfEngine(readData({Program,Memory,IP,DP,Data,Counter,LS}));
                $[ -> bfEngine(loopStart({Program,Memory,IP,DP,Data,Counter,LS}));
                $] when CurrentData==0-> bfEngine(loopEnd({Program,Memory,IP,DP,Data,Counter,LS}));
                $] when CurrentData=/=0-> bfEngine(loopReiter({Program,Memory,IP,DP,Data,Counter,LS}));
                _->io:format("",[])
            end
    end.