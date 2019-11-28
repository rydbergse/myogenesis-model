% Calculate the SSE
function [output]=myogenesis_model_run(pars)

global p plot_flag Data statevar
p=pars;

%%%%%%%%%%%%%%%%%
%%%Calibration%%%
%%%%%%%%%%%%%%%%%

Timepoints = [0 12  24  48  72  96];
[tdata,sdata]=ode23s(@model, Timepoints, statevar);
[t,s]=ode23s(@model, [0 Timepoints(end)], statevar);

pax3pred=sdata(:,1);
myf5pred=sdata(:,2);
myodpred=sdata(:,3);

rep = 2;
first = 1;
last = rep;
pax3data = [];
myf5data = [];
myoddata = [];

for i=1:length(Timepoints)-3
    pax3data = [pax3data mean(Data(1,first:last))];
    myf5data = [myf5data mean(Data(2,first:last))];
    myoddata = [myoddata mean(Data(3,first:last))];
    first = last + 1;
    last = last + rep;
end

rep = 2;
first = 1;
last = rep;
pax3sd = [];
myf5sd = [];
myodsd = [];

for i=1:length(Timepoints)-3
    pax3sd = [pax3sd std(Data(1,first:last))];
    myf5sd = [myf5sd std(Data(2,first:last))];
    myodsd = [myodsd std(Data(3,first:last))];
    first = last + 1;
    last = last + rep;
end

error=sum(((pax3pred(4:6)-pax3data').^2)'./pax3sd);
error=error+sum(((myf5pred(4:6)-myf5data').^2)'./myf5sd);
error=error+sum(((myodpred(4:6)-myoddata').^2)'./myodsd);

SSE = error;
output=SSE;
SSE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if plot_flag == 1
    figure
    hold on
    set(gca,'fontsize',14)
    semilogy(t, s(:,1), 'b', t, s(:,2), 'g', t, s(:,3), 'r','Linewidth', 2)
    legend('Pax3','Myf5','MyoD')
    title('Trunk muscle progenitors November,2012')
    set(gca,'xtick',[0 12 24 48 72 96]); 
    set(gca,'xticklabel',{'E7.5','E8','E8.5','E9.5','E10.5','E11.5'});
    xlabel('Hours')
    ylabel('Intensity')
    grid off
    Timepoints = Timepoints(4:6);
    plot(Timepoints, pax3data, 'b+',Timepoints, myf5data,'g+',...
        Timepoints, myoddata,'r+')
    errorbar(Timepoints, pax3data, pax3sd,'b+')
    errorbar(Timepoints, myf5data, myf5sd,'g+')
    errorbar(Timepoints, myoddata, myodsd,'r+')
    hold off
end

end