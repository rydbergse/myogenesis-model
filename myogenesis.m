%%% Rydberg model of MRF's activation
function [time, statevars] = myogenesis(parameters,t,ics,plotflag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 1:  Define constants 

if isa(parameters,'char')
    p = importdata(parameters);
elseif isa(parameters, 'double')
    p = parameters;
end

global kp3 km5 kmd kmi 
global dgp3 dgm5 dgmd
global Kmi Kp3m5 Km5md

kp3 = p(1);
km5 = p(2);
kmd = p(3);
kmi = p(4);

dgp3 = p(5);
dgm5 = p(6);
dgmd = p(7);

Kmi = p(8);
Kp3m5 = p(9);
Km5md = p(10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 2:  Define simulation time 

tlast = t ; % s

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 3:  Initial conditions 

if isa(ics,'char')
    ic = importdata(ics);
elseif isa(ics, 'double')
    ic = ics;
end

pax3 = ic(1);
myf5 = ic(2) ;
myod = ic(3) ;

species = {'Pax3','Myf5','MyoD'};
statevar_i = [pax3,myf5,myod] ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 4:  Run it!

[time,statevars] = ode45(@dydt_myogenesis,tlast,statevar_i) ;

pax3 = statevars(:,1) ;
myf5 = statevars(:,2) ;
myod = statevars(:,3) ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Step 5:  Plot/save results

if plotflag==1
figure
hold on
col = ['b','g','r']
for i=1:size(statevars,2)
    plot(time,statevars(:,i),col(i),'LineWidth',1.5)
    set(gca,'TickDir','Out','Fontsize',15)
    xlabel('Hours')
    ylabel('Quantity')
end
legend(species)
end
end



