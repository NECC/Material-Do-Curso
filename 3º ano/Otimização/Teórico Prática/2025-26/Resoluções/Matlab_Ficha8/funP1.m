function [f,gradf] = funP1(w)

syms w1 w2

fun=w1+w2;
grad=gradient(fun,[w1 w2]);

%calcular no ponto w
f=double(subs(fun,[w1;w2],w));
gradf=double(subs(grad,[w1;w2],w));
end