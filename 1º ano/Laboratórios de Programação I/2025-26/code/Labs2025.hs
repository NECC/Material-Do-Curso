module Labs2025 where 

import Tarefa0geral

data Estado = Estado 
    { mapaEstado :: Mapa 
    , objetoEstado :: [Objeto]
    , minhocasEstado :: [Minchoca]}
     deriving (Show, Eq, Read, Ord) 

