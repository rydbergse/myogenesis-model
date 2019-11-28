function z=Levin_uncertainty(parameters)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Local sensitivity analysis %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parameters = 'parameter_modelo_5.txt';
nom_pars = importdata(parameters);
pert_size=0.01; 

[nom_tdata,nom_sdata]=myogenesis(nom_pars,[0 48  72  96],'ds1.txt',0);
nom_outputdata=nom_sdata(2:end,:);

%Local sensitivities:
S=zeros(size(nom_outputdata,2),length(nom_pars),size(nom_outputdata,1));
absS=zeros(size(nom_outputdata,2),length(nom_pars),size(nom_outputdata,1));

for j=1:length(nom_pars)
    pert_pars=nom_pars;
    pert_pars(j)=nom_pars(j)*(1+pert_size);
    [pert_tdata,pert_sdata]=myogenesis(pert_pars,[0 48  72  96],'ds1.txt',0);
    pert_outputdata=pert_sdata(2:end,:);
    for i=1:size(nom_outputdata,2)
        for k=1:size(nom_outputdata,1)
            if nom_outputdata(k,i) > 0
                S(i,j,k)=(1/pert_size)*(pert_outputdata(k,i)-nom_outputdata(k,i))/nom_outputdata(k,i);
                absS(i,j,k)=(1/(pert_size*nom_pars(j)))*(pert_outputdata(k,i)-nom_outputdata(k,i));
            else
                S(i,j,k)=0;
                absS(i,j,k)=0;
            end
        end
    end
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Structural measures of identifiability %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%overall sensitivity measure
VS=zeros(size(nom_outputdata,2)*size(nom_outputdata,1),length(nom_pars));
absVS=VS;

%vectorized sensitivity matrix: each column corresponds to a parameter, down the
%columns are data points and time points
for j=1:length(nom_pars)
    for i=1:size(nom_outputdata,2)
        for k=1:size(nom_outputdata,1)
            VS(size(nom_outputdata,1)*(i-1)+(k-1)+1,j)= S(i,j,k);
            absVS(size(nom_outputdata,1)*(i-1)+(k-1)+1,j)= absS(i,j,k);
        end
    end
end

overall_sensitivity_measure=length(VS)*rms(VS).^2'

file = fopen('parameter_modelo_os5','w')
fprintf(file,'%4.50f \n',overall_sensitivity_measure);
fclose(file);

%identify most identifiable parameter (i.e. column of VS with largest
%2-norm)
Z=VS;
X=[];
for m=1:length(nom_pars)
    [max0, max_index0]=max(length(Z)*rms(Z).^2');
    order_parameters(m)=max_index0;
    ident_scores_parameters(m)=max0;
    X=[X VS(:,max_index0)];
    Zhat=X*inv(X'*X)*X'*VS;
    Z=VS-Zhat;
end

%generate vector of identifiability scores in original order
for j=1:length(nom_pars)
    ident_scores_of_parameters(order_parameters(j))=ident_scores_parameters(j);
end
ident_scores_of_parameters'

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Practical measures of identifiability %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Covariance matrix from data
data = importdata('emyogenesis_total.txt');
rep = 2
for i=1:size(data,1);
    for j=1:rep:size(data,2);
        std_data(i,(j+rep-1)/rep) = std(data(i,j:j+rep-1));
    end
end

%vectorize the STD data:
for i=1:size(nom_outputdata,2)
    for k=1:size(nom_outputdata,1)
        STDdata(size(nom_outputdata,1)*(i-1)+(k-1)+1)=std_data(i,k);
    end
end
W=diag(STDdata.^2,0);
%FIM
FIM=absVS'*inv(W)*absVS;
%FIM=absVS'*absVS;
%Cramer-Rao bound
sig_squared_lower_bnd=diag(inv(FIM));

%confidence interval:
CI=1.96*sqrt(sig_squared_lower_bnd)
percent_error=(CI./nom_pars)*100

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Blom 95% confidence interval %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%length of parameter vector
m=length(nom_pars);
%number of measurements points
N=prod(size(data));
%min SSE
global Data plot_flag statevar
plot_flag = 0;
statevar = importdata('ds1.txt');
Data = importdata('emyogenesis_total.txt');
MLE=myogenesis_model2p_run(nom_pars);
% F95(m, N-m)
F95=finv(0.95, m, N-m);
C95=m/(N-m)*MLE*F95;
JTJ=transpose(absVS)*absVS;
JTJ_inv=inv(JTJ);
JTJ_diag=diag(JTJ);
JTJ_inv_diag=diag(JTJ_inv);

Delta_D = C95./sqrt(JTJ_diag)
percent_Delta_D=100*Delta_D./nom_pars'

Delta_I=C95.*sqrt(diag(JTJ_inv))
percent_Delta_I=100*Delta_I./nom_pars'

for i=1:5
    for j=1:5
        cor(i,j)=JTJ_inv(i,j)/(sqrt(JTJ_inv(i,i)*JTJ_inv(j,j)));
    end
end
cor;
[U,S,V] = svd(absVS);
sqrt(diag((S)));
end