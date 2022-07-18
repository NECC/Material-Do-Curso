-module(ex2).
-export([create/0, enqueue/3, dequeue/1]).

create() -> [].

enqueue([], Item, Priority) -> [{Item, Priority}];
enqueue([{HeadItem, HeadPriority} | Tail], Item, Priority) ->
    if
        Priority > HeadPriority ->
            [{Item, Priority} | [{HeadItem, HeadPriority} | Tail]];
        true -> 
            [{HeadItem, HeadPriority} | enqueue(Tail, Item, Priority)]
    end.


dequeue([]) -> empty;
dequeue([{HeadItem, HeadPriority} | Tail]) -> {HeadItem, Tail}.