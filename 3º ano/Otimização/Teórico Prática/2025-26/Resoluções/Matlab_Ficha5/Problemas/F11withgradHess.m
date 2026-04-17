function [f,gradf,hessf] = F11withgradHess(w)

syms w1;
%----------------------
fun = w1^2-w1^4/4;
grad = gradient(fun,w1);
hess = hessian(grad,w1);

%calcular a funcao e o gradiente no pto. w
f=double(subs(fun,w1,w(1)));
gradf=double(subs(grad,w1,w(1)));
hessf=double(subs(hess,w1,w(1)));
%----------------------
end