function [f,gradf,hessf] = F13withgradHess(w)

syms w1 w2;

F = sqrt(w1^2+1)+sqrt(w2^2+1);
grad = gradient(F,[w1 w2]);
hess = hessian(F,[w1 w2]);

%calcular a funcao e o gradiente no pto. w
f=double(subs(fun,[w1,w2],[w(1),w(2)]));
gradf=double(subs(grad,[w1,w2],[w(1),w(2)]));
hessf=double(subs(hess,[w1,w2],[w(1),w(2)]));
%----------------------
end