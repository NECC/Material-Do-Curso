function [f,gradf] = funHS6(w)

syms w1 w2

fun=(1-w1)^2;
grad=gradient(fun,[w1 w2]);

%calcular no ponto w
f=double(subs(fun,[w1;w2],w));
gradf=double(subs(grad,[w1;w2],w));
end