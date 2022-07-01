% Parameters
Shh = 2; K_shh = 1; K_PC_Ptc = 0.1; Smo_t = 1; K_PC_Smo = 1; PC_t = 1; k1 = 1; k2 = 1;
V1 = 1; V2 = 1; V3 = 50; K_1 = 1; K_2 = 1; Km1 = 0.01; Km2 = 0.01; kd1 = 1; kd2 = 1; kd3 = 1;
Vdeg = 10; Kdeg = 1; K_I = 0.4; Imir = 2; Km5 = 1; n = 10; m = 10;

Shh = 2; K_shh = 1; K_PC_Ptc = 1; Smo_t = 1; K_PC_Smo = 1; PC_t = 1; k1 = 1; k2 = 1;
V1 = 1; V2 = 1; V3 = 1; K_1 = 1; K_2 = 1; Km1 = 1; Km2 = 1; kd1 = 1; kd2 = 1; kd3 = 1;
Vdeg = 1; Kdeg = 1; K_I = 1; Imir = 1; Km5 = 1; n = 10; m = 10;

p = [Shh, K_shh, K_PC_Ptc, Smo_t, K_PC_Smo, PC_t, k1, k2, V1, V2, V3, K_1, K_2, Km1, Km2,...
    kd1, kd2, kd3, Vdeg, Kdeg, K_I, Imir, Km5, n, m];

% Output names    
variables = {'Shh', 'Ptc1_{Shh}', 'Smo_{A}', 'Ptc1', 'Gli', 'Gli3', 'Gli3R', 'Myf5'};

y0 = [0, 0, 0, 0, 0];
tspan = 0:0.1:100;
options = odeset('RelTol',1e-8,'AbsTol',1e-10);
[t, y] = shh_model_signal(tspan, y0, p, 20, 60);

%f = figure('Position', [488 342 560 420]);
set(gca, 'Fontsize', 14)
hold on
plot(t, y(:,[2,3,5,7,8]), 'LineWidth', 2)
xlabel('Tiempo')
ylabel('Concentración')
title('Activación de Shh, Shh = 2')
legend(variables{[2,3,5,7,8]}, 'Location', 'eastoutside')

saveas(gcf, 'shh_off.png')


%%

% Parameters

Shh = 20; K_shh = 1; K_PC_Ptc = 1; Smo_t = 1; K_PC_Smo = 1; PC_t = 1; k1 = 1; k2 = 1;
V1 = 1; V2 = 1; V3 = 1; K_1 = 1; K_2 = 1; Km1 = 1; Km2 = 1; kd1 = 1; kd2 = 1; kd3 = 1;
Vdeg = 1; Kdeg = 1; K_I = 1; Imir = 1; Km5 = 1; n = 10; m = 10;

p = [Shh, K_shh, K_PC_Ptc, Smo_t, K_PC_Smo, PC_t, k1, k2, V1, V2, V3, K_1, K_2, Km1, Km2,...
    kd1, kd2, kd3, Vdeg, Kdeg, K_I, Imir, Km5, n, m];

% Output names    
variables = {'Shh', 'Ptc1_{Shh}', 'Smo_{A}', 'Ptc1', 'Gli', 'Gli3', 'Gli3R', 'Myf5'};

y0 = [0, 0, 0, 0, 0];
tspan = 0:0.1:100;
options = odeset('RelTol',1e-8,'AbsTol',1e-10);
[t, y] = shh_model_signal(tspan, y0, p, 20, 60);

%f = figure('Position', [488 342 560 420]);
set(gca, 'Fontsize', 14)
hold on
plot(t, y(:,[2,3,5,7,8]), 'LineWidth', 2)
xlabel('Tiempo')
ylabel('Concentración')
title('Activación de Shh, Shh = 20')
legend(variables{[2,3,5,7,8]}, 'Location', 'eastoutside')

saveas(gcf, 'shh_on.png')
