
%% loading data
exclusions251 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd2.5,NSe1\eliminatedResources.csv');
exclusions252 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd2.5,NSe2\eliminatedResources.csv');
exclusions253 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd2.5,NSe3\eliminatedResources.csv');
exclusions254 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd2.5,NSe4\eliminatedResources.csv');

exclusions51 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd5,NSe1\eliminatedResources-3.csv');
exclusions52 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd5,NSe2\eliminatedResources.csv');
exclusions53 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd5,NSe3\eliminatedResources.csv');
exclusions54 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd5,NSe4\eliminatedResources.csv');

exclusions6661 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd6.66,NSe1\eliminatedResources.csv');
exclusions6662 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd6.66,NSe2\eliminatedResources.csv');
exclusions6663 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd6.66,NSe3\eliminatedResources.csv');
exclusions6664 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd6.66,NSe4\eliminatedResources.csv');

exclusions101 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd10,NSe1\eliminatedResources-3.csv');
exclusions102 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd10,NSe2\eliminatedResources.csv');
exclusions103 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd10,NSe3\eliminatedResources.csv');
exclusions104 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd10,NSe4\eliminatedResources.csv');

exclusions201 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd20,NSe1\eliminatedResources-3.csv');
exclusions202 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd20,NSe2\eliminatedResources.csv');
exclusions203 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd20,NSe3\eliminatedResources.csv');
exclusions204 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd20,NSe4\eliminatedResources.csv');

exclusions401 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd40,NSe1\eliminatedResources.csv');
exclusions402 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd40,NSe2\eliminatedResources.csv');
exclusions403 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd40,NSe3\eliminatedResources.csv');
exclusions404 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd40,NSe4\eliminatedResources.csv');

rsrpThresh251 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd2.5,NSe1\rsrpThreshold.csv') + 110;
rsrpThresh252 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd2.5,NSe2\rsrpThreshold.csv') + 110;
rsrpThresh253 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd2.5,NSe3\rsrpThreshold.csv') + 110;
rsrpThresh254 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd2.5,NSe4\rsrpThreshold.csv') + 110;
rsrpThresh251(rsrpThresh251 < 0) = 0;
rsrpThresh252(rsrpThresh252 < 0) = 0;
rsrpThresh253(rsrpThresh253 < 0) = 0;
rsrpThresh254(rsrpThresh254 < 0) = 0;

rsrpThresh51 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd5,NSe1\rsrpThreshold-3.csv') + 110;
rsrpThresh52 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd5,NSe2\rsrpThreshold.csv') + 110;
rsrpThresh53 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd5,NSe3\rsrpThreshold.csv') + 110;
rsrpThresh54 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd5,NSe4\rsrpThreshold.csv') + 110;
rsrpThresh51(rsrpThresh51 < 0) = 0;
rsrpThresh52(rsrpThresh52 < 0) = 0;
rsrpThresh53(rsrpThresh53 < 0) = 0;
rsrpThresh54(rsrpThresh54 < 0) = 0;

rsrpThresh6661 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd6.66,NSe1\rsrpThreshold.csv') + 110;
rsrpThresh6662 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd6.66,NSe2\rsrpThreshold.csv') + 110;
rsrpThresh6663 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd6.66,NSe3\rsrpThreshold.csv') + 110;
rsrpThresh6664 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd6.66,NSe4\rsrpThreshold.csv') + 110;
rsrpThresh6661(rsrpThresh6661 < 0) = 0;
rsrpThresh6662(rsrpThresh6662 < 0) = 0;
rsrpThresh6663(rsrpThresh6663 < 0) = 0;
rsrpThresh6664(rsrpThresh6664 < 0) = 0;

rsrpThresh101 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd10,NSe1\rsrpThreshold-3.csv') + 110;
rsrpThresh102 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd10,NSe2\rsrpThreshold.csv') + 110;
rsrpThresh103 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd10,NSe3\rsrpThreshold.csv') + 110;
rsrpThresh104 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd10,NSe4\rsrpThreshold.csv') + 110;
rsrpThresh101(rsrpThresh101 < 0) = 0;
rsrpThresh102(rsrpThresh102 < 0) = 0;
rsrpThresh103(rsrpThresh103 < 0) = 0;
rsrpThresh104(rsrpThresh104 < 0) = 0;

rsrpThresh201 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd20,NSe1\rsrpThreshold-3.csv') + 110;
rsrpThresh202 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd20,NSe2\rsrpThreshold.csv') + 110;
rsrpThresh203 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd20,NSe3\rsrpThreshold.csv') + 110;
rsrpThresh204 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd20,NSe4\rsrpThreshold.csv') + 110;
rsrpThresh201(rsrpThresh201 < 0) = 0;
rsrpThresh202(rsrpThresh202 < 0) = 0;
rsrpThresh203(rsrpThresh203 < 0) = 0;
rsrpThresh204(rsrpThresh204 < 0) = 0;

rsrpThresh401 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd40,NSe1\rsrpThreshold.csv') + 110;
rsrpThresh402 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd40,NSe2\rsrpThreshold.csv') + 110;
rsrpThresh403 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd40,NSe3\rsrpThreshold.csv') + 110;
rsrpThresh404 = csvread('D:\Journal-C-V2X-Results\new-model-validation\t233,divd40,NSe4\rsrpThreshold.csv') + 110;
rsrpThresh401(rsrpThresh401 < 0) = 0;
rsrpThresh402(rsrpThresh402 < 0) = 0;
rsrpThresh403(rsrpThresh403 < 0) = 0;
rsrpThresh404(rsrpThresh404 < 0) = 0;

%% processing

possibleThresholds = 0:3:110;
possibleEliminations = 0:1:(32*4*.8+1);

hist = cell(24,1);

for i = 1:24
    hist{i} = zeros(length(possibleThresholds),length(possibleEliminations));
end


for i = 1:length(possibleThresholds)
    for j = 1:length(possibleEliminations)
        hist{1}(i,j) = sum(exclusions251(rsrpThresh251==possibleThresholds(i))==possibleEliminations(j))/length(exclusions251(rsrpThresh251==possibleThresholds(i)));
        hist{2}(i,j) = sum(exclusions252(rsrpThresh252==possibleThresholds(i))==possibleEliminations(j))/length(exclusions252(rsrpThresh252==possibleThresholds(i)));
        hist{3}(i,j) = sum(exclusions253(rsrpThresh253==possibleThresholds(i))==possibleEliminations(j))/length(exclusions253(rsrpThresh253==possibleThresholds(i)));
        hist{4}(i,j) = sum(exclusions254(rsrpThresh254==possibleThresholds(i))==possibleEliminations(j))/length(exclusions254(rsrpThresh254==possibleThresholds(i)));
        
        hist{5}(i,j) = sum(exclusions51(rsrpThresh51==possibleThresholds(i))==possibleEliminations(j))/length(exclusions51(rsrpThresh51==possibleThresholds(i)));
        hist{6}(i,j) = sum(exclusions52(rsrpThresh52==possibleThresholds(i))==possibleEliminations(j))/length(exclusions52(rsrpThresh52==possibleThresholds(i)));
        hist{7}(i,j) = sum(exclusions53(rsrpThresh53==possibleThresholds(i))==possibleEliminations(j))/length(exclusions53(rsrpThresh53==possibleThresholds(i)));
        hist{8}(i,j) = sum(exclusions54(rsrpThresh54==possibleThresholds(i))==possibleEliminations(j))/length(exclusions54(rsrpThresh54==possibleThresholds(i)));
        
        hist{9}(i,j) = sum(exclusions6661(rsrpThresh6661==possibleThresholds(i))==possibleEliminations(j))/length(exclusions6661(rsrpThresh6661==possibleThresholds(i)));
        hist{10}(i,j) = sum(exclusions6662(rsrpThresh6662==possibleThresholds(i))==possibleEliminations(j))/length(exclusions6662(rsrpThresh6662==possibleThresholds(i)));
        hist{11}(i,j) = sum(exclusions6663(rsrpThresh6663==possibleThresholds(i))==possibleEliminations(j))/length(exclusions6663(rsrpThresh6663==possibleThresholds(i)));
        hist{12}(i,j) = sum(exclusions6664(rsrpThresh6664==possibleThresholds(i))==possibleEliminations(j))/length(exclusions6664(rsrpThresh6664==possibleThresholds(i)));
        
        hist{13}(i,j) = sum(exclusions101(rsrpThresh101==possibleThresholds(i))==possibleEliminations(j))/length(exclusions101(rsrpThresh101==possibleThresholds(i)));
        hist{14}(i,j) = sum(exclusions102(rsrpThresh102==possibleThresholds(i))==possibleEliminations(j))/length(exclusions102(rsrpThresh102==possibleThresholds(i)));
        hist{15}(i,j) = sum(exclusions103(rsrpThresh103==possibleThresholds(i))==possibleEliminations(j))/length(exclusions103(rsrpThresh103==possibleThresholds(i)));
        hist{16}(i,j) = sum(exclusions104(rsrpThresh104==possibleThresholds(i))==possibleEliminations(j))/length(exclusions104(rsrpThresh104==possibleThresholds(i)));
        
        hist{17}(i,j) = sum(exclusions201(rsrpThresh201==possibleThresholds(i))==possibleEliminations(j))/length(exclusions201(rsrpThresh201==possibleThresholds(i)));
        hist{18}(i,j) = sum(exclusions202(rsrpThresh202==possibleThresholds(i))==possibleEliminations(j))/length(exclusions202(rsrpThresh202==possibleThresholds(i)));
        hist{19}(i,j) = sum(exclusions203(rsrpThresh203==possibleThresholds(i))==possibleEliminations(j))/length(exclusions203(rsrpThresh203==possibleThresholds(i)));
        hist{20}(i,j) = sum(exclusions204(rsrpThresh204==possibleThresholds(i))==possibleEliminations(j))/length(exclusions204(rsrpThresh204==possibleThresholds(i)));
        
        hist{21}(i,j) = sum(exclusions401(rsrpThresh401==possibleThresholds(i))==possibleEliminations(j))/length(exclusions401(rsrpThresh401==possibleThresholds(i)));
        hist{22}(i,j) = sum(exclusions402(rsrpThresh402==possibleThresholds(i))==possibleEliminations(j))/length(exclusions402(rsrpThresh402==possibleThresholds(i)));
        hist{23}(i,j) = sum(exclusions403(rsrpThresh403==possibleThresholds(i))==possibleEliminations(j))/length(exclusions403(rsrpThresh403==possibleThresholds(i)));
        hist{24}(i,j) = sum(exclusions404(rsrpThresh404==possibleThresholds(i))==possibleEliminations(j))/length(exclusions404(rsrpThresh404==possibleThresholds(i)));
    end
end

maxLikelyhood = cell(4,1);

for i = 1:4
    maxLikelyhood{i} = zeros(length(possibleThresholds),length(possibleEliminations));
end

for i = 1:length(possibleThresholds)
    for j = 1:length(possibleEliminations)
        temp1 = hist{1}(i,j);
        if isnan(temp1)
            temp1 = 0;
        end
        if temp1 > 0
            maxLikelyhood{1}(i,j) = 1;
        end
        for k = 5:4:24
            if hist{k}(i,j) > temp1
                temp1 = hist{k}(i,j);
                maxLikelyhood{1}(i,j) = k;
            end
        end
        
        temp2 = hist{2}(i,j);
        if isnan(temp2)
            temp2 = 0;
        end
        if temp2 > 0
            maxLikelyhood{2}(i,j) = 2;
        end
        for k = 6:4:24
            if hist{k}(i,j) > temp2
                temp2 = hist{k}(i,j);
                maxLikelyhood{2}(i,j) = k;
            end
        end
        
        temp3 = hist{3}(i,j);
        if isnan(temp3)
            temp3 = 0;
        end
        if temp3 > 0
            maxLikelyhood{3}(i,j) = 3;
        end
        for k = 7:4:24
            if hist{k}(i,j) > temp3
                temp3 = hist{k}(i,j);
                maxLikelyhood{3}(i,j) = k;
            end
        end
        
        temp4 = hist{4}(i,j);
        if isnan(temp4)
            temp4 = 0;
        end
        if temp4 > 0
            maxLikelyhood{4}(i,j) = 4;
        end
        for k = 8:4:24
            if hist{k}(i,j) > temp4
                temp4 = hist{k}(i,j);
                maxLikelyhood{4}(i,j) = k;
            end
        end
    end
end


%% filling in the blanks
for i = 1:length(possibleThresholds)
    
    temp1 = find(maxLikelyhood{1}(i,:)>0,1,'first');%maxLikelyhood{1} is special because it doesn't max out eliminated resources
    
    for j = 1:length(possibleEliminations)
        
        if maxLikelyhood{1}(i,j) == 0 && ~isempty(temp1) && j < temp1
            maxLikelyhood{1}(i,j) = maxLikelyhood{1}(i,find(maxLikelyhood{1}(i,:)>0,1,'first'));
        end
        if maxLikelyhood{1}(i,j) == 0 && ~isempty(temp1) && j > temp1
            maxLikelyhood{1}(i,j) = maxLikelyhood{1}(i,find(maxLikelyhood{1}(i,:)>0,1,'last'));
        end
        if maxLikelyhood{1}(i,j) == 0 && isempty(temp1)
            maxLikelyhood{1}(i,j) = maxLikelyhood{1}(find(maxLikelyhood{1}(:,end)>0,1,'last'),end);
        end
        
        if maxLikelyhood{2}(i,j) == 0 && ~isempty(find(maxLikelyhood{2}(i,:)>0,1,'first'))
            maxLikelyhood{2}(i,j) = maxLikelyhood{2}(i,find(maxLikelyhood{2}(i,:)>0,1,'first'));
        end
        if maxLikelyhood{2}(i,j) == 0 && isempty(find(maxLikelyhood{2}(i,:)>0,1,'first'))
            maxLikelyhood{2}(i,j) = maxLikelyhood{2}(find(maxLikelyhood{2}(:,end)>0,1,'last'),end);
        end
        
        if maxLikelyhood{3}(i,j) == 0 && ~isempty(find(maxLikelyhood{3}(i,:)>0,1,'first'))
            maxLikelyhood{3}(i,j) = maxLikelyhood{3}(i,find(maxLikelyhood{3}(i,:)>0,1,'first'));
        end
        if maxLikelyhood{3}(i,j) == 0 && isempty(find(maxLikelyhood{3}(i,:)>0,1,'first'))
            maxLikelyhood{3}(i,j) = maxLikelyhood{3}(find(maxLikelyhood{3}(:,end)>0,1,'last'),end);
        end
        
        if maxLikelyhood{4}(i,j) == 0 && ~isempty(find(maxLikelyhood{4}(i,:)>0,1,'first'))
            maxLikelyhood{4}(i,j) = maxLikelyhood{4}(i,find(maxLikelyhood{4}(i,:)>0,1,'first'));
        end
        if maxLikelyhood{4}(i,j) == 0 && isempty(find(maxLikelyhood{4}(i,:)>0,1,'first'))
            maxLikelyhood{4}(i,j) = maxLikelyhood{4}(find(maxLikelyhood{4}(:,end)>0,1,'last'),end);
        end
    end
end

%% interpretation

for i = 1:length(possibleThresholds)
    for j = 1:length(possibleEliminations)
        for k = 1:4
            if maxLikelyhood{k}(i,j) <= 4
                maxLikelyhood{k}(i,j) = 2/4;
            elseif maxLikelyhood{k}(i,j) <= 8
                maxLikelyhood{k}(i,j) = 2/5;
            elseif maxLikelyhood{k}(i,j) <= 12
                maxLikelyhood{k}(i,j) = .3;
            elseif maxLikelyhood{k}(i,j) <= 16
                maxLikelyhood{k}(i,j) = 2/10;
            elseif maxLikelyhood{k}(i,j) <= 20
                maxLikelyhood{k}(i,j) = 2/20;
            elseif maxLikelyhood{k}(i,j) <= 24
                maxLikelyhood{k}(i,j) = 2/40;
            end
        end
    end
end














