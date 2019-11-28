% Calculate the SSE
function [output]=myogenesis_model_run(pars,data,rep,timepoints,statevars,modelo)

global p

%Load parameters 
if isa(pars,'char')
    p = importdata(pars);
elseif isa(pars, 'double')
    p = pars;
end

%Load initial conditions for state variables
if isa(statevars,'char')
    statevars = importdata(statevars);
elseif isa(pars, 'double')
    statevars = statevars;
end

%Your data need to have genes in the rows and time points (with replicates)
%in the columns, then tranpose
data = importdata(data)';

%Define the timepoins; the first one are the initial conditions
Timepoints = timepoints;

%Create an array, first dimension are the timepoints, second dimension are 
%the genes and third dimension the replicates
for i=1:rep
    for j=1:length(Timepoints)-1;
        Data(j,1:size(data,2),i) = data((j-1)*rep+i,:);
    end
end

%Simulate the model predictions in the timespan
[tdata,sdata]=ode23s(modelo, Timepoints, statevars);

%Calculate the mean of each time point for each gene 
m = mean(Data,3);

%Calculate the standard deviation of each time point for each gene 
s = std(Data,0,3);

%Calculate the sum of square errors
SSE = sum(sum(((sdata(2:end,:) - m).^2)./ s));
output=SSE;
SSE

end