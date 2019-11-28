%file Extended_Levin_calibrate.m
global plot_flag Data statevar

%Data format: Six1 Pax3 Myf5 Mrf4 MyoD MyoG
Data = importdata('emyogenesis_total.txt');

%Initial conditions
statevar = [0 0 0];

%Values to fit
%h
%initial_guess = [1.08 20 360 0.04 0.072 0.9 0.936 1000 3000 5000 2];
initial_guess = z(1:10);

%Setting bounds
Npars=length(initial_guess);
lb=zeros(1,Npars);
ub=10000000000000*ones(1,Npars);

%Simulated Annealing
plot_flag = 0;
%z=simulannealbnd(@myogenesis_model2p_run,initial_guess,lb,ub)
OPTIONS = optimset('MaxIter',10000, 'MaxFunEvals', 10000);
z=fmincon(@myogenesis_model2p_run, initial_guess,[],[],[],[],lb, [],[], OPTIONS);

%Plot fitting
plot_flag = 1;
myogenesis_model2p_run(z);

%% 
%Writing results
file = fopen('parameter_modelo_5.txt','w')
fprintf(file,'%4.50f \n',z);
fclose(file);


