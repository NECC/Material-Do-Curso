
 clc;
% Solve the constrained problem  with fmincon
 options= optimoptions('fmincon','Display','iter','SpecifyObjectiveGradient',true);


  w0=[-1.2;1];
  % A w <= b
  A=[];b=[];
  % Aeq w = beq
  Aeq=[];beq=[];
  lb=[];
  ub=[];

  [w_opt,f_opt,exitflag,output,lambda] = fmincon(@funHS6,w0,A,b,Aeq,beq,lb,ub,@nonlconHS6,options)