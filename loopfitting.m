global plot_flag Data statevar

%Data format: Six1 Pax3 Myf5 Mrf4 MyoD MyoG
Data = importdata('emyogenesis_total.txt');

%Initial conditions
statevar = [0 0 0];

%Setting bounds
Npars=10;
lb=zeros(1,Npars);
ub=10000000000000*ones(1,Npars);

sse = [];
parameters = {};
k = 1;

for i = 0.1:0.01:2.5
    %Values to fit
    %h
    initial_guess = i*ones(1,10);
    plot_flag = 0;
    OPTIONS = optimset('MaxIter',10000, 'MaxFunEvals', 10000);
    z=fmincon(@myogenesis_model2p_run, initial_guess,[],[],[],[],lb, ub,[], OPTIONS);
    parameters{k} = z;
    k = k + 1;
    sse = [sse , myogenesis_model2p_run(z)];
    disp(i*100./2.5)
end
