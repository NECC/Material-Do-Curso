function [fun,c,ceq] = HS6(w)

  
  %----------------------
  % definir a funcao f
  fun=(1-w(1))^2;

  %----------------------
  %definir as funcoes de restricao

  % ---- restricoes do tipo desigualdade (>=0) ----
  c=[];  % 
  % ---- restricoes do tipo igualdade (=0) ----
  ceq=10*(w(2) - w(1)^2);   % temos 1 restrição
   
end