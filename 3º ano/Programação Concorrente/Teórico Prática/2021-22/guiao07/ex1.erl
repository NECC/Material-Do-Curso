-module(ex1).
-export([create/0, enqueue/2, dequeue/1]).

create() -> {[],[]}.

enqueue({In, Out}, Item) -> {[Item | In], Out}.

dequeue({[], []}) -> empty;
dequeue({In, [Item | Out]}) -> {{In, Out}, Item};
dequeue({In, []}) -> dequeue({[], lists:reverse(In)}).


%create() -> [].

%enqueue(Queue, Item) -> Queue ++ [Item].

%dequeue([]) -> empty;
%dequeue([Item|Queue]) -> {Queue, Item}.