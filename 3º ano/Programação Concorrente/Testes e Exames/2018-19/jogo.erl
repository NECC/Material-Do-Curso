-module(jogo).
-export([server/0, jogador/1, jogar/2]).

server() -> spawn(fun() -> jogo([]) end).

jogo(Jogadores) ->
    receive
        {participa, Pid} ->
            NewJogadores = [Pid | Jogadores],
            if
                length(NewJogadores) == 4 ->
                    io:format("Nova Partida: ~p, ~p, ~p, ~p~n", NewJogadores),
                    Partida = spawn(fun() -> initPartida(NewJogadores, false, 0, false, rand:uniform(100)) end), % partida(Jogadores, ganhou, tentativas, tempo)
                    [JogadorPid ! {start, Partida} || JogadorPid <- NewJogadores],
                    jogo([]);
                true ->
                    jogo(NewJogadores)
            end
    end.

timer(Pid) ->
    timer:sleep(20000),
    Pid ! tempo,
    io:fwrite("Tempo acabou.~n").

initPartida(Jogadores, Ganhou, Tentativas, Tempo, Numero) ->
    spawn(fun() -> timer(self()) end),
    partida(Jogadores, Ganhou, Tentativas, Tempo, Numero).

partida(Jogadores, Ganhou, Tentativas, Tempo, Numero) ->
    io:format("~p~n", [Numero]),
    receive
        tempo -> partida(Jogadores, Ganhou, Tentativas, true, Numero);
        {tentativa, N, Pid} ->
            if
                Tempo ->
                    Pid ! {resposta, "TEMPO\n"},
                    partida(Jogadores, Ganhou, Tentativas, Tempo, Numero);
                Ganhou ->
                    Pid ! {resposta, "PERDEU\n"},
                    partida(Jogadores, Ganhou, Tentativas, Tempo, Numero);
                Tentativas >= 100 ->
                    Pid ! {resposta, "TENTATIVAS\n"},
                    partida(Jogadores, Ganhou, Tentativas, Tempo, Numero);
                true ->
                    if 
                        N == Numero ->
                            Pid ! {resposta, "GANHOU\n"},
                            partida(Jogadores, true, Tentativas + 1, Tempo, Numero);
                        N < Numero ->
                            Pid ! {resposta, "MAIOR\n"},
                            partida(Jogadores, Ganhou, Tentativas + 1, Tempo, Numero);
                        true ->
                            Pid ! {resposta, "MENOR\n"},
                            partida(Jogadores, Ganhou, Tentativas + 1, Tempo, Numero)                            
                    end
            end
    end.

jogador(Server) -> spawn(fun() -> initJogador(Server) end).

initJogador(Server) ->
    Server ! {participa, self()},
    receive
        {start, Partida} -> loopJogador(Partida)
    end.

loopJogador(Partida) ->
    receive
        {jogar, N} ->
            Partida ! {tentativa, N, self()};
        {resposta, Res} -> io:fwrite(Res)
    end,
    loopJogador(Partida).

jogar(Pid, N) -> Pid ! {jogar, N}.