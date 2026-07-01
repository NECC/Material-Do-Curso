function [fun,c,ceq] = HS39(w)

  
  %----------------------
  % definir a funcao f
  fun=-w(1);

  %----------------------
  %definir as funcoes de restricao

  % ---- restricoes do tipo desigualdade (>=0) ----
  c=[];  % 
  % ---- restricoes do tipo igualdade (=0) ----
  ceq=[w(2)-w(1)^3-w(3)^2;w(1)^2-w(2)-w(4)^2];   % temos 2 restrição

      
end