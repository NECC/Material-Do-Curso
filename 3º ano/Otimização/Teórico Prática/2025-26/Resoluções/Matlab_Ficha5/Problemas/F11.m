function [f] = F11(w)

syms w1;
%----------------------
fun = w1^2-w1^4/4;


%calcular a funcao e o gradiente no pto. w
f=double(subs(fun,w1,w(1)));

%----------------------
end