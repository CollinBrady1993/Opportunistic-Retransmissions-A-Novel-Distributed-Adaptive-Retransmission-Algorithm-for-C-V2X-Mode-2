

RRI = 100;
tau = 1000/RRI;
T1 = 2;
T2 = 33;
rhoUE = .01:.0025:.8;
NSe = 1:4;
gammaX = 0:.05:30;

data1 = cell(length(rhoUE),length(gammaX));
data2 = cell(length(rhoUE),length(gammaX));
data3 = cell(length(rhoUE),length(gammaX));
data4 = cell(length(rhoUE),length(gammaX));

for i = 1:length(rhoUE)
    i
    for j = 1:length(gammaX)
        data1{i,j} = gammaPNEx2RhoHelper(RRI,T1,T2,rhoUE(i),1,gammaX(j));
        data2{i,j} = gammaPNEx2RhoHelper(RRI,T1,T2,rhoUE(i),2,gammaX(j));
        data3{i,j} = gammaPNEx2RhoHelper(RRI,T1,T2,rhoUE(i),3,gammaX(j));
        data4{i,j} = gammaPNEx2RhoHelper(RRI,T1,T2,rhoUE(i),4,gammaX(j));
    end
end

table1 = zeros(129,length(gammaX));
table2 = zeros(129,length(gammaX));
table3 = zeros(129,length(gammaX));
table4 = zeros(129,length(gammaX));
for i = 1:length(gammaX)
    for j = 1:129
        save1 = [0,0];
        save2 = [0,0];
        save3 = [0,0];
        save4 = [0,0];
        for k = 1:length(rhoUE)
            if data1{k,i}(j) > save1(2)
                save1 = [k,data1{k,i}(j)];
            end
            if data2{k,i}(j) > save2(2)
                save2 = [k,data2{k,i}(j)];
            end
            if data3{k,i}(j) > save3(2)
                save3 = [k,data3{k,i}(j)];
            end
            if data4{k,i}(j) > save4(2)
                save4 = [k,data4{k,i}(j)];
            end
        end
        
        if save1(1) > 0%this whole monstrosity deals with edge cases
            table1(j,i) = rhoUE(save1(1));
        elseif j == 1
            table1(j,i) = rhoUE(1);
        elseif table1(j-1,i) > rhoUE(1)
            table1(j,i) = rhoUE(end);
        else
            table1(j,i) = rhoUE(1);
        end
        
        if save2(1) > 0%this whole monstrosity deals with edge cases
            table2(j,i) = rhoUE(save2(1));
        elseif j == 1
            table2(j,i) = rhoUE(1);
        elseif table2(j-1,i) > rhoUE(1)
            table2(j,i) = rhoUE(end);
        else
            table2(j,i) = rhoUE(1);
        end
        
        if save3(1) > 0%this whole monstrosity deals with edge cases
            table3(j,i) = rhoUE(save3(1));
        elseif j == 1
            table3(j,i) = rhoUE(1);
        elseif table3(j-1,i) > rhoUE(1)
            table3(j,i) = rhoUE(end);
        else
            table3(j,i) = rhoUE(1);
        end
        
        if save4(1) > 0%this whole monstrosity deals with edge cases
            table4(j,i) = rhoUE(save4(1));
        elseif j == 1
            table4(j,i) = rhoUE(1);
        elseif table4(j-1,i) > rhoUE(1)
            table4(j,i) = rhoUE(end);
        else
            table4(j,i) = rhoUE(1);
        end
        
    end
end



csvwrite(strcat('NEx+gammaX2rhoUE,NSe1,T2T1',num2str(T2-T1+1),',RRI',num2str(RRI),'.csv'),[[0;[0:128]'],[gammaX;table1]])
csvwrite(strcat('NEx+gammaX2rhoUE,NSe2,T2T1',num2str(T2-T1+1),',RRI',num2str(RRI),'.csv'),[[0;[0:128]'],[gammaX;table2]])
csvwrite(strcat('NEx+gammaX2rhoUE,NSe3,T2T1',num2str(T2-T1+1),',RRI',num2str(RRI),'.csv'),[[0;[0:128]'],[gammaX;table3]])
csvwrite(strcat('NEx+gammaX2rhoUE,NSe4,T2T1',num2str(T2-T1+1),',RRI',num2str(RRI),'.csv'),[[0;[0:128]'],[gammaX;table4]])




