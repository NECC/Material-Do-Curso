-module(lock).
-export([create/0, acquire/1, release/1]).

% Basic lock (not read/write)
% Untested
create() -> spawn(fun() -> lock(null, []) end).

lock(State, Pids) ->
    receive
        {acquire, Pid} ->
            if
                State == null ->
                    lock(Pid, Pids);
                true ->
                    lock(State, Pids ++ [Pid])
            end;
        {release, Pid} ->
            case State of
                null ->
                    lock(State, Pids);
                Pid ->
                    {L1, L2} = lists:split(1, Pids),
                    case L1 of
                        [First] ->
                            First ! done,
                            NewState = First;
                        [] ->
                            NewState = null
                    end,
                    lock(NewState, L2)
            end
    end.

acquire(Lock) ->
    Lock ! {acquire, self()},
    receive
        done -> ok
    end.

release(Lock) ->
    Lock ! {release, self()},
    ok.