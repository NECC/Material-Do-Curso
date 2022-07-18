-module(msg).
-export([start/0, envia/2, recebe/0]).

envia(BoxPid,0) ->
    BoxPid ! stop;
envia(BoxPid,N)->
    BoxPid ! {msg,"nova mensagem!"},
    timer:sleep(5000),
    envia(BoxPid,N-1).

recebe() ->
    receive
        {msg,Texto} ->
            io:format("mensagem recebida: ~p ~n",[Texto]),
            recebe();
        stop ->
            io:format("hora de terminar~n",[]),
            ok
end.

start() ->
    BoxPid = spawn(msg, recebe, []),
    spawn(msg, envia, [BoxPid,3]).


