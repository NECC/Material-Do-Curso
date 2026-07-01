function [penaltyQ] = penaltyQ_HS6(w,mu)

  
  %----------------------
  % definir a funcao f
  fun=(1-w(1))^2;

  %----------------------
  %definir as funcoes de restricao

  % ---- restricoes do tipo desigualdade (>=0) ----
  c=[];  % 
  % ---- restricoes do tipo igualdade (=0) ----
  ceq=10*(w(2) - w(1)^2);   % temos 1 restrição

   % definir a função de penalidade quadrática Q
  
   penaltyQ=fun+0.5*mu*ceq^2;

   
end