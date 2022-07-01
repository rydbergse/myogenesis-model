% Parameters
% k1 = 0.2; k2 = 0.5; BMP4 = 100; k3 = 1; k4 = 100; Vmax_K = 0.7; Km_K= 0.3; Vmax_P = 3; Km_P = 0.4;
% k5 = 1; k6 = 2; k7 = 0.7; k8 = 2; k9 = 0.8; k10 = 1; k11 = 0.8; k12 = 1; k13 = 200; d = 10;
% Trs_max = 200; Kd = 0.3; Vmax_P2 = 0.5; Km_P2 = 1;

k1 = 1; k2 = 1; BMP4 = 10; k3 = 1; k4 = 1; Vmax_K = 1; Km_K= 1; Vmax_P = 1; Km_P = 1;
k5 = 1; k6 = 1; k7 = 1; k8 = 1; k9 = 1; k10 = 1; k11 = 1; k12 = 10; k13 = 1; d = 1;
Trs_max = 1; Kd = 1; Vmax_P2 = 1; Km_P2 = 1;

p = [k1, k2, BMP4, k3, k4, Vmax_K, Km_K, Vmax_P, Km_P, Vmax_P2, Km_P2, k5, k6, k7, k8, k9,...
        k10, k11, k12, k13, d, Trs_max, Kd];

% Output names    
variables = {'BMPR2', 'BMPR1', 'BMP4-BMPR1', 'BMP4-BMPR1-BMPR2', 'BMP4-BMPR1P-BMPR2',...
    'BMP4-BMPR1P-BMPR2-SMAD1/5/8', 'SMAD1/5/8', 'SMAD1/5/8-P', 'SMAD4', 'SMAD1/5/8-P-SMAD4',...
    'SMAD1/5/8-P-SMAD4_{nuclear}', 'Id', 'MyoD', 'Id-MyoD'};
    
% Simulation
y0 = [1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0];
tspan = 0:0.1:1000;
options = odeset('RelTol',1e-8,'AbsTol',1e-10);
[t, y] = ode23s(@bmp_model, tspan, y0, options, p, [200,600]);

% Plot
i = [3,8,12:14];
f = figure('Position', [488 342 560 420]);
set(gca, 'Fontsize', 14)
hold on
plot(t, y(:,i), 'LineWidth', 2)
ylim([0,1]);
xlabel('Tiempo')
ylabel('Concentración')
title('Activación de BMP4, BMP4 = 10')
legend(variables{i}, 'Location', 'eastoutside')

saveas(gcf, 'bmp_on.jpg')