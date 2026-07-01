
 clc;
% Solve the constrained problem  with fmincon
 options= optimoptions('fmincon','Display','iter','SpecifyObjectiveGradient',true);


  w0=[0.1;0.7;0.2];
  % A w <= b
  A=[];b=[];
  % Aeq w = beq
  Aeq=[1 1 1];beq=1;
  lb=[0;0;0];
  ub=[];

  [w_opt,f_opt,exitflag,output,lambda] = fmincon(@funHS32,w0,A,b,Aeq,beq,lb,ub,@nonlconHS32,options)