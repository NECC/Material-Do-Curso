function [wopt,Qopt,violation,output1] = PenalidadeQuadratica(penaltyQ,P,w0, mu0)

%Algoritmo do Método de Penalidade Quadrática

% Usa o fminunc para resolver os subproblemas de penalidade quadrática
  options = optimoptions('fminunc');
  options.Display = 'iter'; % Display optimization progress
 
  
  
%========= parametros do algoritmo =========
  toll=1e-6;  
  tol=1e-6;
  kmax=100;

  mu=mu0;mu
  tau= 1/mu;
  ws=w0;
   
  b=2; %2, 10
  output1=[];
    for k=1:kmax
        options.OptimalityTolerance = tau; % Set the gradient tolerance
        %minimização da função de penalidade quadrática usando fminunc
        [wopt, Qopt, exitflag, output, gradQ] = fminunc(@(w) penaltyQ(w,mu),ws, options)                
        
        % critério de paragem final 
        [fk,ck,ceqk]=P(wopt);
        %calcular o vetor da violação das restriçõe
        v=[max(0,-ck); abs(ceqk)];
        violation=norm(v, inf);
        normQ=norm(gradQ,inf);
    
        %%%%%%%%%

        output1=[output1; k wopt' normQ violation fk Qopt tau mu exitflag]

         if (violation <= tol  )   
            
          break;
          
        else
            mu=b*mu;  
            tau=max(1/mu,toll);
            ws=wopt;             
        end
          
    end
      
end

