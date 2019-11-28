%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Local sensitivity analysis %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parameters = 'parameter_modelo_5.txt';
nom_pars = importdata(parameters);
pert_size=0.5:0.01:1.5;

[nom_tdata,nom_sdata]=myogenesis(nom_pars,[0 48  72  96],'ds1.txt',0);
nom_outputdata=nom_sdata(2:end,:);

%Local sensitivities:
s = zeros(length(nom_pars),length(pert_size));

for j=1:length(nom_pars)
    pert_pars=nom_pars;
    for i=1:length(pert_size)
        pert_pars(j)=nom_pars(j)*pert_size(i);
        SSE = sse_myogenesis(pert_pars,'emyogenesis_total.txt',2,[0 48 72 96],'ds1.txt',@model);
        s(j,i) = SSE;
    end
end


parameters = {'kp3','km5','kmd','kmi'}
figure(1)
plot(pert_size, s(1:4,:),'LineWidth',2.5)
    set(gca,'TickDir','Out','Fontsize',15)
    xlabel('Deviation from the fit (fold-change)')
    ylabel('Sum of squared errors (SSE)')
legend(parameters)

parameters = {'dgp3','dgm5','dgmd'}
figure(2)
plot(pert_size, s(5:7,:),'LineWidth',2.5)
    set(gca,'TickDir','Out','Fontsize',15)
    xlabel('Deviation from the fit (fold-change)')
    ylabel('Sum of squared errors (SSE)')
legend(parameters)

parameters = {'Kmi','Kp3m5','Km5md'};
figure(3)
plot(pert_size, s(8:10,:),'LineWidth',2.5)
    set(gca,'TickDir','Out','Fontsize',15)
    xlabel('Deviation from the fit (fold-change)')
    ylabel('Sum of squared errors (SSE)')
legend(parameters)
    