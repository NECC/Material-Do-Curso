function [c,ceq] = nonlconHS32(w)



% nonlinear inequality c(w) <=0 
c=-6*w(2)-4*w(3)+w(1)^3+3;
% nonlinear equality ceq(w)=0
ceq=[];


end