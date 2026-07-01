function [f,c,ceq] = P1(w)

  %----------------------
  % definir/calcular funcao f no ponto w
  f=w(1)+w(2);
     
  %definir/calcular a restrição de igualdade  ceq(w)=0
  ceq=w(1)^2+w(2)^2-2;

  %não existem restrições c(w)>=0
  c=[];
end