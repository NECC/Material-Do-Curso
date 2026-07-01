function [f,gradf] = funHS39(w)

syms w1 w2 w3 w4

fun=-w1;
grad=gradient(fun,[w1 w2 w3 w4]);

%calcular no ponto w
f=double(subs(fun,[w1;w2;w3;w4],w));
gradf=double(subs(grad,[w1;w2;w3;w4],w));
end