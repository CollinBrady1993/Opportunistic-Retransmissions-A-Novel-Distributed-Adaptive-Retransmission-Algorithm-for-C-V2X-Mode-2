function [params] = parameterVariableMaker(varArgIn)
%this function takes in a bunch of parameters of variable lengths and makes
%one big matrix for each parameter permutation. its fo easerier itteration
%through sets of variables, instead of doing 5 nested for loops you have
%this then 1 for loop.
L = length(varArgIn);


max = zeros(1,L);
index = [0,ones(1,L-1)];

for i = 1:L
    max(i) = size(varArgIn{i},2);
end
params = cell(prod(max),1);




for i = 1:prod(max)
    index = itterIndex(index,1,max);
    currentParams = cell(1,L);
    for j = 1:L
           currentParams{j} = varArgIn{j}(:,index(j))';
    end
    currentParams = cell2mat(currentParams);
    params{i} = currentParams;
end

params = cell2mat(params);


end

