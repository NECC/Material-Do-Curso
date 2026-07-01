
 clc;
% Solve the constrained problem  with fmincon
 options= optimoptions('fmincon','Display','iter','SpecifyObjectiveGradient',true);


  w0=[2;2;2;2];
  % A w <= b
  A=[];b=[];
  % Aeq w = beq
  Aeq=[];beq=[];
  lb=[];
  ub=[];

  [w_opt,f_opt,exitflag,output,lambda] = fmincon(@funHS39,w0,A,b,Aeq,beq,lb,ub,@nonlconHS39,options)