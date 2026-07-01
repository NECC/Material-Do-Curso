function [f,gradf] = funHS32(w)

syms w1 w2 w3

fun=(w1+3*w2+w3)^2+4*(w1-w2)^2;
grad=gradient(fun,[w1 w2 w3]);

%calcular no ponto w
f=double(subs(fun,[w1;w2;w3],w));
gradf=double(subs(grad,[w1;w2;w3],w));
end