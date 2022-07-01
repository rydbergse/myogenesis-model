function [tx,y] = shh_model_signal(tspan,y0,p,t0,tau)
    
    % Parameters
    parameters = num2cell(p);
    [Shh, K_shh, K_PC_Ptc, Smo_t, K_PC_Smo, PC_t, k1, k2, V1, V2, V3, K_1, K_2, Km1, Km2,...
        kd1, kd2, kd3, Vdeg, Kdeg, K_I, Imir, Km5, n, m]= deal(parameters{:});
    
    % Variables names
    variables = {'Ptc1', 'Gli', 'Gli3', 'Gli3R', 'Myf5'};

    % Simulation options
    options = odeset('RelTol',1e-8,'AbsTol',1e-10);
    
    % Numericl integrtion
    [tx, yx] = ode23(@shh_model, tspan, y0, options, p, [t0 t0+tau]);
    
    % Output curves
    Shh = Shh*(tspan >= t0 & tspan <= (t0+tau))';
    Ptc_Shh = yx(:,1).*Shh./(K_shh+Shh); % Bound patched    
    
    % Solve non-linear equation for equilibrium
    Ptc = yx(:,1).*K_shh./(K_shh+Shh); % Not bound patched
    solvePC = @(Ptc) @(PC) PC_t - (PC + Ptc*PC/(K_PC_Ptc + PC) +  Smo_t*PC/(K_PC_Smo+ PC));
    options = optimset('Display','off'); 
    PC_vector = arrayfun(@(x) fsolve(solvePC(x), PC_t, options), Ptc')';
    
    % Equilibrium relationships
    Smo_PC = Smo_t.*PC_vector./(K_PC_Smo+ PC_vector); % Smoothened bound to PC
    Ptc_PC = Ptc.*PC_vector./(K_PC_Ptc + PC_vector); % Patched bound to PC
    y = [Shh, Ptc_Shh, Smo_PC, yx];
end

function dy = shh_model(t,y,p,t_signal)  
    
    % Initial conditions
    Ptc_t = y(1); 
    Gli = y(2); 
    Gli3 = y(3); 
    Gli3R = y(4); 
    Myf5 = y(5);
    
    % Parameters
    parameters = num2cell(p);
    [Shh, K_shh, K_PC_Ptc, Smo_t, K_PC_Smo, PC_t, k1, k2, V1, V2, V3, K_1, K_2, Km1, Km2,...
        kd1, kd2, kd3, Vdeg, Kdeg, K_I, Imir, Km5, n, m]= deal(parameters{:});
    
    if t > max(t_signal) || t < min(t_signal)
        Shh = 0;
    end
    
    % Solve non-linear equation for equilibrium
    Ptc = Ptc_t*K_shh/(K_shh+Shh); % Not bound patched
    solvePC = @(PC) PC_t - (PC + Ptc*PC/(K_PC_Ptc + PC) +  Smo_t*PC/(K_PC_Smo+ PC));
    options = optimset('Display','off'); 
    PC = fsolve(solvePC, PC_t, options);
    
    % Equilibrium relationships
    Smo_PC = Smo_t*PC/(K_PC_Smo+ PC); % Smoothened bound to PC
    Ptc_PC = Ptc*PC/(K_PC_Ptc + PC); % Patched bound to PC
    
    %[Shh, Ptc_t, Ptc, PC, Smo_t, Smo_PC, Ptc_PC]
    
    % Differential equations
    dy = zeros(5,1);
    dy(1) = k1 + V1.*(Gli^n)./((K_1^n)+(Gli^n)) - kd1*Ptc_t;
    dy(2) = k2 + V2.*(Gli^m)./((K_2^m)+(Gli^m)) - kd2*Gli - Vdeg*Gli/(Kdeg*(1 + Smo_PC/K_I) + Gli + Gli3);
    dy(3) = (k2)/(1 + Imir*Myf5/(Km5 + Myf5)) -  ...
        kd2*Gli3 - Vdeg*Gli3/(Kdeg*(1 + Smo_PC/K_I) + Gli + Gli3);
    dy(4) = Vdeg*Gli3/(Kdeg*(1 + Smo_PC/K_I) + Gli + Gli3) - kd2*Gli3R;
    dy(5) = V3*(Gli/Km1)/(1+Gli/Km1+Gli3R/Km2) - kd3*Myf5;
    
end
