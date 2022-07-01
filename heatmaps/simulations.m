
% Parameter names
parameter_names = {'k_{p3}' 'k_{m5}' 'k_{md}' 'k_{mi}' 'k_{mg}' ...
    '\delta_{p3}' '\delta_{m5}' '\delta_{md}' '\delta_{mg}' ...
    'K_{mi}' 'K_{p3m5}' 'K_{m5md}' 'K_{p3md}' 'K_{mdmg}' ...
    'K_{mg}' 'k_{p7}' 'K_{mgp7} ' '\delta_{p7}' 't_{p7md}' ...
    'Ruta Notch' 'Ruta Wnt' 'Ruta Shh' 'Ruta BMP4'};

% Parameter values
opt_p = 10.^z; kp7 = opt_p(1); Kmgp7 = 5e2; dp7 = opt_p(6); 
tp7md = 1e0; N = 0; W = 0; S = 0; B = 0;
opt_p = [opt_p, kp7, Kmgp7, dp7, tp7md, N, W, S, B];

% Ranges
shh_range = [1e-2 1e0];
wnt_range = [1e-2 1e0];
bmp_range = [1e-4 1e-1];
notch_range = [1e-7 1e-5];

% Parameter matrix for Wnt and Shh
P1 = opt_p;
parametersmatrix_1 = parameter_matrix(P1, 100, 21, 22, ...
    wnt_range, shh_range,'log10','log10');

% Parameter matrix for Wnt and Notch
P2 = opt_p;
parametersmatrix_2 = parameter_matrix(P2, 100, 21, 20, ...
    wnt_range, notch_range,'log10','log10');

% Parameter matrix for Wnt and BMP
P3 = opt_p;
parametersmatrix_3 = parameter_matrix(P3, 100, 21, 23, ...
    wnt_range, bmp_range,'log10','log10');

% Parameter matrix for Shh and Notch
P4 = opt_p;
parametersmatrix_4 = parameter_matrix(P4, 100, 22, 20, ...
    shh_range, notch_range, 'log10', 'log10');

% Parameter matrix for Shh and BMP
P5 = opt_p;
parametersmatrix_5 = parameter_matrix(P5, 100, 22, 23, ...
    shh_range, bmp_range, 'log10', 'log10');

% Parameter matrix for Notch and BMP
P6 = opt_p;
parametersmatrix_6 = parameter_matrix(P6, 100, 20, 23, ...
    notch_range, bmp_range, 'log10', 'log10');

% Initial conditions
ic = [0, 0, 0, 0, 0]; 

% Simulation through the bidimensional parameter space
tic
output_Wnt_Shh = parameter_space_simulation(parametersmatrix_1, ...
    ic, 0:1000);
save('output_Wnt_Shh','output_Wnt_Shh')

output_Wnt_Notch = parameter_space_simulation(parametersmatrix_2, ...
    ic, 0:1000);
save('output_Wnt_Notch','output_Wnt_Notch')

output_Wnt_BMP = parameter_space_simulation(parametersmatrix_3, ...
    ic, 0:1000);
save('output_Wnt_BMP','output_Wnt_BMP')

output_Shh_Notch = parameter_space_simulation(parametersmatrix_4, ...
    ic, 0:1000);
save('output_Shh_Notch','output_Shh_Notch')

output_Shh_BMP = parameter_space_simulation(parametersmatrix_5, ...
    ic, 0:1000);
save('output_Shh_BMP','output_Shh_BMP')

output_Notch_BMP = parameter_space_simulation(parametersmatrix_6, ...
    ic, 0:1000);
save('output_Notch_BMP','output_Notch_BMP')
toc

%%

% Name of the plots
plotnames = {'[Pax3]', '[Pax7]', '[Myf5]','[MyoD]','[MyoG]'};

% Axis limits for the heatmap color variable
caxisv = {'auto','auto','auto','auto', 'auto'};

% Plots for first parameter sweep
ParameterSpaceHeatmaps(output_Wnt_Shh, parametersmatrix_1(:,[21 22]), 1, 1, parameter_names{22},...
    parameter_names{21}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps','Wnt_Shh_')
close all

% Plots for second parameter sweep
ParameterSpaceHeatmaps(output_Wnt_Notch, parametersmatrix_2(:,[21 20]), 1, 1,parameter_names{20},...
    parameter_names{21}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps','Wnt_Notch_')
close all

% Plots for third parameter sweep
ParameterSpaceHeatmaps(output_Wnt_BMP, parametersmatrix_3(:,[21 23]), 1, 1,parameter_names{23},...
    parameter_names{21}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps','Wnt_BMP_')
close all

% Plots for fourth parameter sweep
ParameterSpaceHeatmaps(output_Shh_Notch, parametersmatrix_4(:,[22 20]), 1, 1,parameter_names{20},...
    parameter_names{22}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps','Shh_Notch_')
close all

% Plots for fifth parameter sweep
ParameterSpaceHeatmaps(output_Shh_BMP, parametersmatrix_5(:,[22 23]), 1, 1,parameter_names{23},...
    parameter_names{22}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps','Shh_BMP_')
close all

% Plots for sixth parameter sweep
ParameterSpaceHeatmaps(output_Notch_BMP, parametersmatrix_6(:,[20 23]), 1, 1,parameter_names{23},...
    parameter_names{20}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps','Notch_BMP_')
close all





%% Single simulation



ic = [0, 0, 0, 0, 0];
[t, s] = ode23s(@(t, x) mrfs_network(t, x, opt_p), [0 500], ic);
figure
hold on
set(gca,'fontsize',14)
semilogy(t, s(:,1), 'b', t, s(:,3), 'g', t, s(:,4), 'r', ...
    t, s(:,5), 'k', 'Linewidth', 2)
ylim([0, 3500])
set(gca,'xtick',[0 24 48 72 96 120 144 168 192, 216, 240, 264, 288]); 
set(gca,'xticklabel',{'E7.5','E8.5','E9.5','E10.5','E11.5', 'E12.5', ...
    'E13.5', 'E14.5', 'E15.5', 'E16.5', 'E17.5', 'E18.5', 'E19.5'});
xlabel('Tiempo (días embrionarios)')
ylabel('Nivel de expresión')
grid off
legend({'Pax3','Myf5','MyoD','MyoG'})
hold off

%% 
% Parameter names

% Parameter names
parameter_names = {'k_{p3}' 'k_{m5}' 'k_{md}' 'k_{mi}' 'k_{mg}' ...
    '\delta_{p3}' '\delta_{m5}' '\delta_{md}' '\delta_{mg}' ...
    'K_{mi}' 'K_{p3m5}' 'K_{m5md}' 'K_{p3md}' 'K_{mdmg}' ...
    'K_{mg}' 'k_{p7}' '\delta_{p7}' 't_{p7md}' 'N' 'W' 'S' 'B'};

% kp3 = 1; kmi = 1; Kmi = 1; dp3 = 1; kp7 = 1; Knrp7 = 1; Kmgp7 = 1; k1 = 1; k_1 = 1; 
% dp7 = 1; km5 = 1; Kp3m5 = 1; Kbcm5 = 1; Kglim5 = 1; Kgli3rm5 = 1; dm5 = 1; kmd = 1;
% Kmdm5 = 1; Kp3md = 1; k2 = 1; k_2 = 1; dmd = 1; kmg = 1; Kmdmg = 1; Kmg = 1; dmg = 1;
% Trsmax = 1; Kd = 1; did = 1; NR = 1; Bcn = 1; Gli = 1; Gli3R = 1; C4n = 1;

% Standard parameter vector for GDS4326
load('A_111.642_error_P_10.mat')

% Parameter matrix for Wnt and Shh
P1 = opt_p;
parametersmatrix_1 = parameter_matrix(P1,20,31,32,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Parameter matrix for Wnt and Notch
P2 = opt_p;
parametersmatrix_2 = parameter_matrix(P2,20,30,31,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Parameter matrix for Wnt and BMP
P3 = opt_p;
parametersmatrix_3 = parameter_matrix(P3,20,31,34,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Parameter matrix for Shh and Notch
P4 = opt_p;
parametersmatrix_4 = parameter_matrix(P4,20,30,32,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Parameter matrix for Shh and BMP
P5 = opt_p;
parametersmatrix_5 = parameter_matrix(P5,20,32,34,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Parameter matrix for Notch and BMP
P6 = opt_p;
parametersmatrix_6 = parameter_matrix(P6,20,30,34,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Initial conditions
ic = [1 1 1 1 1 1 1 1]; 

% Simulation through the bidimensional parameter space
tic
output_Wnt_Shh = parameter_space_simulation(parametersmatrix_1, ic, 0:1000);
save('output_Wnt_Shh_GDS4326','output_Wnt_Shh')

output_Wnt_Notch = parameter_space_simulation(parametersmatrix_2, ic, 0:1000);
save('output_Wnt_Notch_GDS4326','output_Wnt_Notch')

output_Wnt_BMP = parameter_space_simulation(parametersmatrix_3, ic, 0:1000);
save('output_Wnt_BMP_GDS4326','output_Wnt_BMP')

output_Shh_Notch = parameter_space_simulation(parametersmatrix_4, ic, 0:1000);
save('output_Shh_Notch_GDS4326','output_Shh_Notch')

output_Shh_BMP = parameter_space_simulation(parametersmatrix_5, ic, 0:1000);
save('output_Shh_BMP_GDS4326','output_Shh_BMP')

output_Notch_BMP = parameter_space_simulation(parametersmatrix_6, ic, 0:1000);
save('output_Notch_BMP_GDS4326','output_Notch_BMP')
toc


% Name of the plots
plotnames = {'[Pax3]','[Myf5]','[MyoD]','[MyoG]'};

% Axis limits for the heatmap color variable
caxisv = {'auto','auto','auto','auto', 'auto'};

% Plots for first parameter sweep
ParameterSpaceHeatmaps(output_Wnt_Shh, parametersmatrix_1(:,[31 32]), 1, 1,parameter_names{32},...
    parameter_names{31}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326','Wnt_Shh_')
close all

% Plots for second parameter sweep
ParameterSpaceHeatmaps(output_Wnt_Notch, parametersmatrix_2(:,[30 31]), 1, 1,parameter_names{31},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326','Wnt_Notch_')
close all

% Plots for third parameter sweep
ParameterSpaceHeatmaps(output_Wnt_BMP, parametersmatrix_3(:,[31 34]), 1, 1,parameter_names{34},...
    parameter_names{31}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326','Wnt_BMP_')
close all

% Plots for fourth parameter sweep
ParameterSpaceHeatmaps(output_Shh_Notch, parametersmatrix_4(:,[30 32]), 1, 1,parameter_names{32},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326','Shh_Notch_')
close all

% Plots for fifth parameter sweep
ParameterSpaceHeatmaps(output_Shh_BMP, parametersmatrix_5(:,[32 34]), 1, 1,parameter_names{34},...
    parameter_names{32}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326','Shh_BMP_')
close all

% Plots for sixth parameter sweep
ParameterSpaceHeatmaps(output_Notch_BMP, parametersmatrix_6(:,[30 34]), 1, 1,parameter_names{34},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326','Notch_BMP_')
close all


%%

% Parameter names
parameter_names = {'k_{p3}' 'k_{mi}' 'K_{mi}' '\delta_{p3}' 'k_{p7}' 'K_{nrp7}' 'K_{mgp7}'...
    'k_{1}' 'k_{_1}' '\delta_{p7}' 'k_{m5}' 'K_{p3m5}' 'K_{bcm5}' 'K_{glim5}' 'K_{gli3rm5}'...
    '\delta_{m5}' 'k_{md}' 'K_{mdm5}' 'K_{p3md}' 'k_{2}' 'k_{_2}' '\delta_{md}' 'k_{mg}'...
    'K_{mdmg}' 'K_{mg}' '\delta_mg' 'Trs_{max}' 'K_{d}' '\delta_{id}' 'NR' 'B_{cn}' 'Gli'...
    'Gli_{3R}' 'C4_{n}'};

% kp3 = 1; kmi = 1; Kmi = 1; dp3 = 1; kp7 = 1; Knrp7 = 1; Kmgp7 = 1; k1 = 1; k_1 = 1; 
% dp7 = 1; km5 = 1; Kp3m5 = 1; Kbcm5 = 1; Kglim5 = 1; Kgli3rm5 = 1; dm5 = 1; kmd = 1;
% Kmdm5 = 1; Kp3md = 1; k2 = 1; k_2 = 1; dmd = 1; kmg = 1; Kmdmg = 1; Kmg = 1; dmg = 1;
% Trsmax = 1; Kd = 1; did = 1; NR = 1; Bcn = 1; Gli = 1; Gli3R = 1; C4n = 1;

% Standard parameter vector for GDS586
load('A_204.5942_error_P_63.mat')

% Parameter matrix for Wnt and Shh
P1 = opt_p;
parametersmatrix_1 = parameter_matrix(P1,20,31,32,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Parameter matrix for Wnt and Notch
P2 = opt_p;
parametersmatrix_2 = parameter_matrix(P2,20,30,31,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Parameter matrix for Wnt and BMP
P3 = opt_p;
parametersmatrix_3 = parameter_matrix(P3,20,31,34,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Parameter matrix for Shh and Notch
P4 = opt_p;
parametersmatrix_4 = parameter_matrix(P4,20,30,32,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Parameter matrix for Shh and BMP
P5 = opt_p;
parametersmatrix_5 = parameter_matrix(P5,20,32,34,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Parameter matrix for Notch and BMP
P6 = opt_p;
parametersmatrix_6 = parameter_matrix(P6,20,30,34,[1e-6 1e6],[1e-6 1e6],'log10','log10');

% Initial conditions
ic = [1 1 1 1 1 1 1 1]; 

% Simulation through the bidimensional parameter space
tic
output_Wnt_Shh = parameter_space_simulation(parametersmatrix_1, ic, 0:1000);
save('output_Wnt_Shh_GDS586','output_Wnt_Shh')

output_Wnt_Notch = parameter_space_simulation(parametersmatrix_2, ic, 0:1000);
save('output_Wnt_Notch_GDS586','output_Wnt_Notch')

output_Wnt_BMP = parameter_space_simulation(parametersmatrix_3, ic, 0:1000);
save('output_Wnt_BMP_GDS586','output_Wnt_BMP')

output_Shh_Notch = parameter_space_simulation(parametersmatrix_4, ic, 0:1000);
save('output_Shh_Notch_GDS586','output_Shh_Notch')

output_Shh_BMP = parameter_space_simulation(parametersmatrix_5, ic, 0:1000);
save('output_Shh_BMP_GDS586','output_Shh_BMP')

output_Notch_BMP = parameter_space_simulation(parametersmatrix_6, ic, 0:1000);
save('output_Notch_BMP_GDS586','output_Notch_BMP')
toc


% Name of the plots
plotnames = {'[Pax3]','[Myf5]','[MyoD]','[MyoG]'};

% Axis limits for the heatmap color variable
caxisv = {'auto','auto','auto','auto'};

% Plots for first parameter sweep
ParameterSpaceHeatmaps(output_Wnt_Shh, parametersmatrix_1(:,[31 32]), 1, 1,parameter_names{32},...
    parameter_names{31}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586','Wnt_Shh_')
close all

% Plots for second parameter sweep
ParameterSpaceHeatmaps(output_Wnt_Notch, parametersmatrix_2(:,[30 31]), 1, 1,parameter_names{31},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586','Wnt_Notch_')
close all

% Plots for third parameter sweep
ParameterSpaceHeatmaps(output_Wnt_BMP, parametersmatrix_3(:,[31 34]), 1, 1,parameter_names{34},...
    parameter_names{31}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586','Wnt_BMP_')
close all

% Plots for fourth parameter sweep
ParameterSpaceHeatmaps(output_Shh_Notch, parametersmatrix_4(:,[30 32]), 1, 1,parameter_names{32},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586','Shh_Notch_')
close all

% Plots for fifth parameter sweep
ParameterSpaceHeatmaps(output_Shh_BMP, parametersmatrix_5(:,[32 34]), 1, 1,parameter_names{34},...
    parameter_names{32}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586','Shh_BMP_')
close all

% Plots for sixth parameter sweep
ParameterSpaceHeatmaps(output_Notch_BMP, parametersmatrix_6(:,[30 34]), 1, 1,parameter_names{34},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586','Notch_BMP_')
close all








%% 
% Parameter names
parameter_names = {'k_{p3}' 'k_{mi}' 'K_{mi}' '\delta_{p3}' 'k_{p7}' 'K_{nrp7}' 'K_{mgp7}'...
    'k_{1}' 'k_{_1}' '\delta_{p7}' 'k_{m5}' 'K_{p3m5}' 'K_{bcm5}' 'K_{glim5}' 'K_{gli3rm5}'...
    '\delta_{m5}' 'k_{md}' 'K_{mdm5}' 'K_{p3md}' 'k_{2}' 'k_{_2}' '\delta_{md}' 'k_{mg}'...
    'K_{mdmg}' 'K_{mg}' '\delta_mg' 'Trs_{max}' 'K_{d}' '\delta_{id}' 'NR' 'B_{cn}' 'Gli'...
    'Gli_{3R}' 'C4_{n}'};

% kp3 = 1; kmi = 1; Kmi = 1; dp3 = 1; kp7 = 1; Knrp7 = 1; Kmgp7 = 1; k1 = 1; k_1 = 1; 
% dp7 = 1; km5 = 1; Kp3m5 = 1; Kbcm5 = 1; Kglim5 = 1; Kgli3rm5 = 1; dm5 = 1; kmd = 1;
% Kmdm5 = 1; Kp3md = 1; k2 = 1; k_2 = 1; dmd = 1; kmg = 1; Kmdmg = 1; Kmg = 1; dmg = 1;
% Trsmax = 1; Kd = 1; did = 1; NR = 1; Bcn = 1; Gli = 1; Gli3R = 1; C4n = 1;

% Standard parameter vector for GDS4326
load('A_111.642_error_P_10.mat')

% Parameter matrix for Wnt and Shh
P1 = opt_p;
parametersmatrix_1 = parameter_matrix(P1,30,31,32,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Parameter matrix for Wnt and Notch
P2 = opt_p;
parametersmatrix_2 = parameter_matrix(P2,30,30,31,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Parameter matrix for Wnt and BMP
P3 = opt_p;
parametersmatrix_3 = parameter_matrix(P3,30,31,34,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Parameter matrix for Shh and Notch
P4 = opt_p;
parametersmatrix_4 = parameter_matrix(P4,30,30,32,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Parameter matrix for Shh and BMP
P5 = opt_p;
parametersmatrix_5 = parameter_matrix(P5,30,32,34,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Parameter matrix for Notch and BMP
P6 = opt_p;
parametersmatrix_6 = parameter_matrix(P6,30,30,34,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Initial conditions
ic = [1 1 1 1 1 1 1 1]; 

% Simulation through the bidimensional parameter space
tic
output_Wnt_Shh = parameter_space_simulation(parametersmatrix_1, ic, 0:1000);
save('output_Wnt_Shh_GDS4326_1000','output_Wnt_Shh')

output_Wnt_Notch = parameter_space_simulation(parametersmatrix_2, ic, 0:1000);
save('output_Wnt_Notch_GDS4326_1000','output_Wnt_Notch')

output_Wnt_BMP = parameter_space_simulation(parametersmatrix_3, ic, 0:1000);
save('output_Wnt_BMP_GDS4326_1000','output_Wnt_BMP')

output_Shh_Notch = parameter_space_simulation(parametersmatrix_4, ic, 0:1000);
save('output_Shh_Notch_GDS4326_1000','output_Shh_Notch')

output_Shh_BMP = parameter_space_simulation(parametersmatrix_5, ic, 0:1000);
save('output_Shh_BMP_GDS4326_1000','output_Shh_BMP')

output_Notch_BMP = parameter_space_simulation(parametersmatrix_6, ic, 0:1000);
save('output_Notch_BMP_GDS4326_1000','output_Notch_BMP')
toc


% Name of the plots
plotnames = {'[Pax3]','[Myf5]','[MyoD]','[MyoG]'};

% Axis limits for the heatmap color variable
caxisv = {'auto','auto','auto','auto'};

% Plots for first parameter sweep
ParameterSpaceHeatmaps(output_Wnt_Shh, parametersmatrix_1(:,[31 32]), 1, 1,parameter_names{32},...
    parameter_names{31}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326_1000','Wnt_Shh_')
close all

% Plots for second parameter sweep
ParameterSpaceHeatmaps(output_Wnt_Notch, parametersmatrix_2(:,[30 31]), 1, 1,parameter_names{31},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326_1000','Wnt_Notch_')
close all

% Plots for third parameter sweep
ParameterSpaceHeatmaps(output_Wnt_BMP, parametersmatrix_3(:,[31 34]), 1, 1,parameter_names{34},...
    parameter_names{31}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326_1000','Wnt_BMP_')
close all

% Plots for fourth parameter sweep
ParameterSpaceHeatmaps(output_Shh_Notch, parametersmatrix_4(:,[30 32]), 1, 1,parameter_names{32},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326_1000','Shh_Notch_')
close all

% Plots for fifth parameter sweep
ParameterSpaceHeatmaps(output_Shh_BMP, parametersmatrix_5(:,[32 34]), 1, 1,parameter_names{34},...
    parameter_names{32}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326_1000','Shh_BMP_')
close all

% Plots for sixth parameter sweep
ParameterSpaceHeatmaps(output_Notch_BMP, parametersmatrix_6(:,[30 34]), 1, 1,parameter_names{34},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS4326_1000','Notch_BMP_')
close all


%%

% Parameter names
parameter_names = {'k_{p3}' 'k_{mi}' 'K_{mi}' '\delta_{p3}' 'k_{p7}' 'K_{nrp7}' 'K_{mgp7}'...
    'k_{1}' 'k_{_1}' '\delta_{p7}' 'k_{m5}' 'K_{p3m5}' 'K_{bcm5}' 'K_{glim5}' 'K_{gli3rm5}'...
    '\delta_{m5}' 'k_{md}' 'K_{mdm5}' 'K_{p3md}' 'k_{2}' 'k_{_2}' '\delta_{md}' 'k_{mg}'...
    'K_{mdmg}' 'K_{mg}' '\delta_mg' 'Trs_{max}' 'K_{d}' '\delta_{id}' 'NR' 'B_{cn}' 'Gli'...
    'Gli_{3R}' 'C4_{n}'};

% kp3 = 1; kmi = 1; Kmi = 1; dp3 = 1; kp7 = 1; Knrp7 = 1; Kmgp7 = 1; k1 = 1; k_1 = 1; 
% dp7 = 1; km5 = 1; Kp3m5 = 1; Kbcm5 = 1; Kglim5 = 1; Kgli3rm5 = 1; dm5 = 1; kmd = 1;
% Kmdm5 = 1; Kp3md = 1; k2 = 1; k_2 = 1; dmd = 1; kmg = 1; Kmdmg = 1; Kmg = 1; dmg = 1;
% Trsmax = 1; Kd = 1; did = 1; NR = 1; Bcn = 1; Gli = 1; Gli3R = 1; C4n = 1;

% Standard parameter vector for GDS586
load('A_204.5942_error_P_63.mat')

% Parameter matrix for Wnt and Shh
P1 = opt_p;
parametersmatrix_1 = parameter_matrix(P1,20,31,32,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Parameter matrix for Wnt and Notch
P2 = opt_p;
parametersmatrix_2 = parameter_matrix(P2,20,30,31,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Parameter matrix for Wnt and BMP
P3 = opt_p;
parametersmatrix_3 = parameter_matrix(P3,20,31,34,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Parameter matrix for Shh and Notch
P4 = opt_p;
parametersmatrix_4 = parameter_matrix(P4,20,30,32,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Parameter matrix for Shh and BMP
P5 = opt_p;
parametersmatrix_5 = parameter_matrix(P5,20,32,34,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Parameter matrix for Notch and BMP
P6 = opt_p;
parametersmatrix_6 = parameter_matrix(P6,20,30,34,[1e-3 1e3],[1e-3 1e3],'log10','log10');

% Initial conditions
ic = [1 1 1 1 1 1 1 1]; 

% Simulation through the bidimensional parameter space
tic
output_Wnt_Shh = parameter_space_simulation(parametersmatrix_1, ic, 0:1000);
save('output_Wnt_Shh_GDS586_1000','output_Wnt_Shh')

output_Wnt_Notch = parameter_space_simulation(parametersmatrix_2, ic, 0:1000);
save('output_Wnt_Notch_GDS586_1000','output_Wnt_Notch')

output_Wnt_BMP = parameter_space_simulation(parametersmatrix_3, ic, 0:1000);
save('output_Wnt_BMP_GDS586_1000','output_Wnt_BMP')

output_Shh_Notch = parameter_space_simulation(parametersmatrix_4, ic, 0:1000);
save('output_Shh_Notch_GDS586_1000','output_Shh_Notch')

output_Shh_BMP = parameter_space_simulation(parametersmatrix_5, ic, 0:1000);
save('output_Shh_BMP_GDS586_1000','output_Shh_BMP')

output_Notch_BMP = parameter_space_simulation(parametersmatrix_6, ic, 0:1000);
save('output_Notch_BMP_GDS586_1000','output_Notch_BMP')
toc


% Name of the plots
plotnames = {'[Pax3]','[Myf5]','[MyoD]','[MyoG]'};

% Axis limits for the heatmap color variable
caxisv = {'auto','auto','auto','auto'};

% Plots for first parameter sweep
ParameterSpaceHeatmaps(output_Wnt_Shh, parametersmatrix_1(:,[31 32]), 1, 1,parameter_names{32},...
    parameter_names{31}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586_1000','Wnt_Shh_')
close all

% Plots for second parameter sweep
ParameterSpaceHeatmaps(output_Wnt_Notch, parametersmatrix_2(:,[30 31]), 1, 1,parameter_names{31},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586_1000','Wnt_Notch_')
close all

% Plots for third parameter sweep
ParameterSpaceHeatmaps(output_Wnt_BMP, parametersmatrix_3(:,[31 34]), 1, 1,parameter_names{34},...
    parameter_names{31}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586_1000','Wnt_BMP_')
close all

% Plots for fourth parameter sweep
ParameterSpaceHeatmaps(output_Shh_Notch, parametersmatrix_4(:,[30 32]), 1, 1,parameter_names{32},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586_1000','Shh_Notch_')
close all

% Plots for fifth parameter sweep
ParameterSpaceHeatmaps(output_Shh_BMP, parametersmatrix_5(:,[32 34]), 1, 1,parameter_names{34},...
    parameter_names{32}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586_1000','Shh_BMP_')
close all

% Plots for sixth parameter sweep
ParameterSpaceHeatmaps(output_Notch_BMP, parametersmatrix_6(:,[30 34]), 1, 1,parameter_names{34},...
    parameter_names{30}, jet, 'auto', 'auto', plotnames,caxisv, 'surfacemaps_GDS586_1000','Notch_BMP_')
close all
