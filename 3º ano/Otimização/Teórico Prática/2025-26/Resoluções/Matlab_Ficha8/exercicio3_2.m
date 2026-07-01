
 clc;
% Solve the constrained problem  with fmincon
 options= optimoptions('fmincon','Display','iter','SpecifyObjectiveGradient',true);


  w0=[0;0;0];
  % A w <= b
  A=[];b=[];
  % Aeq w = beq
  Aeq=[-1 -1 -1];beq=-1;
  lb=[0;0;0];
  ub=[];

  [w_opt,f_opt,exitflag,output,lambda] = fmincon(@funP2,w0,A,b,Aeq,beq,lb,ub,@nonlconP2,options)