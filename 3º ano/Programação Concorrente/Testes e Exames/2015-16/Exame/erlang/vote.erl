-module(vote).
-export([start/0, vota/0, espera/3, votos/2]).


vota() ->
    receive
        sofia -> 
            votos ! {sofia},
            vota();
        tiago -> 
            votos ! {tiago},
            vota()
end.

votos(S,T)->
    espera ! {S,T},
    receive
        {sofia} ->
            io:format("Voto para a Sofia~n"),
            %espera ! {S+1,T},
            votos(S+1,T);
        {tiago} ->
            io:format("Voto para o Tiago~n"),
            %espera ! {S,T+1},
            votos(S,T+1);
        {show} ->
            io:format("S= ~p, T= ~p ~n",[S,T]),
            votos(S,T)
end.


espera(_,_,true) ->
    io:format("Tiago ultrapassou a Sofia~n");
espera(_,_,false) ->
    receive
        {S,T} ->
            %io:format("recebi os votos da votacao ~n",[]),
            Res = if
                T > S -> true;
                T < S -> false;
                T == S -> false
            end,
    espera(S,T,Res)
end.


start() ->
    register (espera, spawn(vote, espera, [0,0,false])),
    register (votos, spawn(vote, votos,[0,0])),
    io:format("criado o processo de votos~n"),

    timer:sleep(2000),
    votos ! {sofia},
    timer:sleep(2000),
    votos ! {tiago},
    timer:sleep(2000),
    votos ! {tiago},
    timer:sleep(2000),
    votos ! {show}.