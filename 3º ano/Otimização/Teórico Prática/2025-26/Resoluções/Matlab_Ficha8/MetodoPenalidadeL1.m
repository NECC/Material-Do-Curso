function [wopt,penL1opt,violation,output1] = MetodoPenalidadeL1(penaltyL1,P,w0, mu0)

%Algoritmo do Método de Penalidade L1: 


% USAR fminunc == para resolver os subproblemas de penalidade L1:  f+mu*abs(ceq)+mu*max(0,-c)
% options = optimset('fminunc');

% USAR o fminsearch == para resolver os subproblemas de penalidade L1:  f+mu*abs(ceq)+mu*max(0,-c)
options = optimset('fminsearch');


options.Display = 'iter'; % Display optimization progress
 
  
  
%========= parametros do algoritmo =========

  tol=1e-6;
  kmax=100;

  mu=mu0;
  ws=w0;
   
  b=10; %2, 10
  output1=[];

    
    for k=1:kmax
        %minimização da função de penalidade L1 usando fminunc
        [wopt, penL1opt, exitflag, output] = fminsearch(@(w) penaltyL1(w,mu),ws, options)                
        
        % critério de paragem final 
        [fk,ck,ceqk]=P(wopt);
        %calcular o vetor da violação das restriçõe
        v=[max(0,-ck); abs(ceqk)];
        violation=norm(v, inf);
           
        %%%%%%%%%

        output1=[output1; k wopt' violation fk penL1opt mu exitflag]

         %função objetivo
         if (violation <= tol)   %
            
          break;
          
        else
            mu=b*mu;  
            ws=wopt;  
        
        end
          
    end
      
end

