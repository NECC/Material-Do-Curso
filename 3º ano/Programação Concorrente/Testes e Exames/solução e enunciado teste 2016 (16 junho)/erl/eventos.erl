-module(eventos).
-export([start/0, sinaliza/2, votos/2, espera/1]).

sinaliza(Tipo,Pid) ->
    Pid ! {Tipo}.

votos(T1,T2) ->
    receive
        tipo1 -> 
            espera ! {T1+1,T2},
            votos(T1+1,T2);
        tipo2 -> 
            espera ! {T1,T2+1},
            votos(T1,T2+1);
        votos -> 
            io:format("Votos sao t1: ~p, t2: ~p. ~n",[T1,T2]),
            votos(T1,T2)
    
    end.




espera(true) ->
    io:format("Sai da espera~n",[]);
espera(false) -> 
    io:format("ainda espero~n",[]),
    receive
        {T1,T2} ->
            Res = if
                T1 == 3 andalso T2 == 2 -> true;
                T1 < 3 -> false;
                T2 < 2 -> false
            end,
    espera(Res)
end.






start() ->
    register (espera, spawn(eventos, espera, [false])),
    Pid = spawn(eventos, votos,  [0,0]),

    Pid ! tipo1,
    timer:sleep(3000),
    Pid ! tipo2,
    Pid ! tipo2,
    timer:sleep(3000),

    Pid ! tipo1,
    timer:sleep(3000),

    Pid ! tipo1,
    timer:sleep(3000),

    Pid ! votos,
ok.
        


