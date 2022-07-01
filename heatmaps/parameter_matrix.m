function parametersmatrix=parameter_matrix(parametervector,range_size,index1,index2,range1,range2,scale1,scale2)

% How many values to test

if strcmp(scale1,'log10')
    range_values_1 = logspace(log10(range1(1)),log10(range1(2)),range_size); 
elseif strcmp(scale1,'lin')
    range_values_1 = linspace((range1(1)),(range1(2)),range_size);
end

if strcmp(scale2,'log10')
    range_values_2 = logspace(log10(range2(1)),log10(range2(2)),range_size); 
elseif strcmp(scale2,'lin')
    range_values_2 = linspace((range2(1)),(range2(2)),range_size);
end

[par_1 , par_2] = meshgrid(range_values_1,range_values_2); 
par_grid = reshape(cat(2,par_1',par_2'),[],2); 
parametersmatrix = repmat(parametervector,size(par_grid,1),1);
parametersmatrix(:,[index1,index2]) = par_grid;

end