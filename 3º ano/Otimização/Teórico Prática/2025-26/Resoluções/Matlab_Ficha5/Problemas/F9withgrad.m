function [f,gradf] = F9withgrad(w)

syms w1 w2;

beta=1; %1;5;15
%----------------------
fun = w1^2+beta*w2^2;
grad = gradient(fun,[w1 w2]);

%calcular a funcao e o gradiente no pto. w
f=double(subs(fun,[w1 w2],[w(1) w(2)]));
gradf=double(subs(grad,[w1 w2],[w(1) w(2)]));
%----------------------
end