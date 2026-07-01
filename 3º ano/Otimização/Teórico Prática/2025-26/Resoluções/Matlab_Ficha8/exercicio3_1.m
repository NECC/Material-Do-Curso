
 clc;
% Solve the constrained problem  with fmincon
 options= optimoptions('fmincon','Display','iter','SpecifyObjectiveGradient',true);


  w0=[0;0];
  A=[];b=[];
  Aeq=[];beq=[];
  lb=[];
  ub=[];

  [w_opt,f_opt,exitflag,output,lambda] = fmincon(@funP1,w0,A,b,Aeq,beq,lb,ub,@nonlconP1,options)