
p = [1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 10, 1, 1, 1, 5, 10, 20, 10, 20];

variables = {'C1', 'C2', 'C3', '\beta-catenina', '\beta-catenina_{n}', 'Myf5'};
y0 = [0, 0, 0, 0, 0, 0];
tspan = 0:0.1:60;
options = odeset('RelTol',1e-8,'AbsTol',1e-10);

[t, y] = ode23(@canonical_wnt_model, tspan, y0, options, p);

%f = figure('Position', [488 342 560 420]);
set(gca, 'Fontsize', 14)
hold on
plot(t, y(:,4), 'LineWidth', 2)
plot(t, y(:,5), 'LineWidth', 2)
plot(t, y(:,6), 'LineWidth', 2)
xline(20, '--', 'LineWidth', 2);
xlabel('Tiempo')
ylabel('Concentración')
title('Activación de Wnt canónica, Wnt = 10')
legend(variables{4:6}, 'Location', 'eastoutside')

saveas(gcf, 'wnt_canonico.png')


%%


p = [1, 1, 1, 1, 1, 15, 1, 1, 20, 1, 20, 1, 300, 5, 1, 1, 1, 1, 1, 20, 5, 20, 50, 50, 30, 10];

variables = {'C1nc', 'G_{\alpha}', 'PIP_{2}', 'DAG', 'IP_{3}', 'Ca^{2+}', 'Pax3', 'MyoD'};
y0 = [0, 0, 30, 0, 0, 10, 0, 0];
tspan = 0:0.01:15;
options = odeset('RelTol',1e-8,'AbsTol',1e-10);

[t, y] = ode23(@noncanonical_wnt_model, tspan, y0, options, p);

f = figure('Position', [488 342 560 420]);
set(gca, 'Fontsize', 14)
hold on
plot(t, y(:,[1:3,6:8]), 'LineWidth', 2)
xline(5, '--', 'LineWidth', 2);
xlabel('Tiempo')
ylabel('Concentración')
title('Activación de Wnt no-canónica, Wnt = 20')
legend(variables{:,[1:3,6:8]}, 'Location', 'eastoutside')

saveas(gcf, 'wnt_no_canonico.png')
