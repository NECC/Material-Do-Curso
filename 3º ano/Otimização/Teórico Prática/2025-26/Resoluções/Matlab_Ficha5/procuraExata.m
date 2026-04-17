function [etak] = procuraExata(F,wk,sk)
    
    syms eta;

    waux=wk+eta*sk;
    phi=F(waux);
    % calcular os pontos estacionários de phi: 
    grad_phi=gradient(phi);
    sol_pe=double(solve(grad_phi==0,eta));  %
    %calcular phi nos pontos estacionários, e escolher o eta para o qual phi é minimo
    vals_phi=double(subs(phi,eta,sol_pe));
    [min_phi index]=min(vals_phi);
    etak=sol_pe(index);
end