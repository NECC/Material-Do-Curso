function [penaltyQ] = penaltyL1_P1(w,mu)

  %----------------------
  % definir a funcao f
  fun=w(1)+w(2);

  %definir a restrição de igualdade  ceq(w)=0
  ceq=w(1)^2+w(2)^2-2;

  %definir a função de penalidade quadrática Q
  penaltyQ=fun+0.5*mu*abs(ceq);

  
end