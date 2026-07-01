function [penaltyQ] = penaltyQ_HS32(w,mu)

  
  %----------------------
  % definir a funcao f
  fun=(w(1)+3*w(2)+w(3))^2+4*(w(1)-w(2))^2;

  %----------------------
  %definir as funcoes de restricao

  % ---- restricoes do tipo desigualdade (>=0) ----
  c=[6*w(2)+4*w(3)-w(1)^3-3;w(1);w(2);w(3)];  % 5 restrições
  % ---- restricoes do tipo igualdade (=0) ----
  ceq=1-w(1)-w(2)-w(3);   % 
  % definir a função de penalidade quadrática Q
  penaltyQ=fun+0.5*mu*ceq^2+0.5*mu*(max(0,-c(1))^2+max(0,-c(2))^2+max(0,-c(3))^2+max(0,-c(4))^2);

   
end