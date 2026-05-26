%% Exemplo: servidor de chat em Erlang (V2)
-module(server_v2).
-export([start/1, stop/1]).

start(Port) -> spawn(fun() -> server(Port) end).
stop(Server) -> Server ! stop.

server(Port) ->
    {ok, LSock} = gen_tcp:listen(Port, [binary, {packet, line}, {reuseaddr, true}]),
    Room = spawn(fun()->room([]) end),
    FirstAcceptor = spawn(fun() -> acceptor(LSock, Room, self()) end),
    handleServer([FirstAcceptor], Room, LSock).

handleServer(List, Room, LSock) ->
    receive
        {new, Acceptor} -> handleServer([Acceptor | List], Room, LSock);
        stop ->
            [Acceptor ! stop || Acceptor <- List],
            Room ! stop,
            gen_tcp:shutdown(LSock, read_write)
    end.

acceptor(LSock, Room, Server) ->
    {ok, Sock} = gen_tcp:accept(LSock),
    NewAcceptor = spawn(fun() -> acceptor(LSock, Room, Server) end),
    Server ! {new, NewAcceptor},
    Room ! {enter, self()},
    user(Sock, Room).

room(Pids) ->
    receive
        stop -> io:format("room OK~n", []);
        {enter, Pid} ->
            io:format("user entered ~n", []),
            room([Pid | Pids]);
        {line, Data} = Msg ->
            io:format("received ~p ~n", [Data]),
            [Pid ! Msg || Pid <- Pids],
            room(Pids);
        {leave, Pid} ->
            io:format("user left ~n", []),
            room(Pids -- [Pid])
    end.

user(Sock, Room) ->
    receive
        stop ->
            gen_tcp:send(Sock, "close"),
            io:format("user OK~n", []);
        {line, Data} ->
            gen_tcp:send(Sock, Data),
            user(Sock, Room);
        {tcp, _, Data} ->
            Room ! {line, Data},
            user(Sock, Room);
        {tcp_closed, _} ->
            Room ! {leave, self()};
        {tcp_error, _, _} ->
            Room ! {leave, self()}
    end.