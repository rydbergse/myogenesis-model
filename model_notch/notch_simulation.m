% Parameters
Dll = 10; k1 = 1; k2 = 1; k3 = 1; k4 = 1; k5 = 1; k6 = 1; k7 = 1; k8 = 1; k9 = 1; k10 = 1;
k11 = 1; k12 = 1; k13 = 1; k14 = 1; RBPJK = 10; V1 = 1; V2 = 1; V3 = 1; V4 = 1; K1 = 1; K2 = 1;
K3 = 1; K4 = 1; K5 = 1; K6 = 1; K7 = 1; K8 = 2;
    
    
p = [Dll, k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, RBPJK, V1, V2, V3, V4,...
    K1, K2, K3, K4, K5, K6, K7, K8];

% Output names    
variables = {'Notch', 'Notch-Dll', 'NICD', 'NICD-RBPJK', 'Hey', 'Pax7', 'MyoD', 'MyoG',...
    'Pax7-MyoD'};
    
% Simulation
y0 = [10, 0, 0, 0, 0, 0, 0, 0, 0];
tspan = 0:1:1000;
options = odeset('RelTol',1e-8,'AbsTol',1e-10);
[t, y] = ode23s(@notch_model, tspan, y0, options, p, [200,600]);

% Plot
i = [4:8];
%f = figure('Position', [488 342 560 420]);
set(gca, 'Fontsize', 14)
hold on
plot(t, y(:,i), 'LineWidth', 2)
%ylim([0,1]);
xlabel('Tiempo')
ylabel('Concentración')
title('Activación de Notch, Delta = 10')
legend(variables{i}, 'Location', 'eastoutside')

saveas(gcf, 'notchdelta_on.jpg')