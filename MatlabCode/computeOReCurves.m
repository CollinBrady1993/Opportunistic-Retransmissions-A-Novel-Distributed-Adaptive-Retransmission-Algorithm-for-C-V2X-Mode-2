


RRI = 100;
tau = 1000/RRI;
T1 = 2;
T2 = 33;
rhoUE = [1/2.5,1/5,1/10,1/20,1/40];%UE are presumed to be vehicles so they cannot be much closer than every 2.5 m
NRc = 0;




prrNSe1 = cell(length(rhoUE),1);
prrNSe2 = cell(length(rhoUE),1);
prrNSe3 = cell(length(rhoUE),1);
prrNSe4 = cell(length(rhoUE),1);
prrORE2 = cell(length(rhoUE),1);
prrORE3 = cell(length(rhoUE),1);
prrORE4 = cell(length(rhoUE),1);
prr1 = cell(length(rhoUE),1);
prr2 = cell(length(rhoUE),1);
prr3 = cell(length(rhoUE),1);
prr4 = cell(length(rhoUE),1);

for i = 1:length(rhoUE)
    i
    datestr(now)
    [d,prr1{i}] = prrBlindCalcFunc_NoComposition(RRI,T1,T2,rhoUE(i),1);
    datestr(now)
    [~,prr2{i}] = prrBlindCalcFunc_NoComposition(RRI,T1,T2,rhoUE(i),2);
    datestr(now)
    [~,prr3{i}] = prrBlindCalcFunc_NoComposition(RRI,T1,T2,rhoUE(i),3);
    datestr(now)
    [~,prr4{i}] = prrBlindCalcFunc_NoComposition(RRI,T1,T2,rhoUE(i),4);
    datestr(now)
    
    prrNSe1{i} = [d;1 - (1 - prr1{i}).^1];
    
    prrNSe2{i} = [d;1 - (1 - prr2{i}).^2];
    
    prrNSe3{i} = [d;1 - (1 - prr3{i}).^3];
    
    prrNSe4{i} = [d;1 - (1 - prr4{i}).^4];
    
    prrORE2{i} = [d;(NRc/(tau+1))*(1 - (1 - prr2{i}).^1) + ((tau+1-NRc)/(tau+1))*(1 - ((1-prr1{i}).^(1).*(1-prr2{i}).^(1)))];
    
    prrORE3{i} = [d;(NRc/(tau+1))*(1 - (1 - prr3{i}).^2) + ((tau+1-NRc)/(tau+1))*(1 - ((1-prr2{i}).^(1).*(1-prr3{i}).^(2)))];
    
    prrORE4{i} = [d;(NRc/(tau+1))*(1 - (1 - prr4{i}).^2) + ((tau+1-NRc)/(tau+1))*(1 - ((1-prr2{i}).^(2).*(1-prr4{i}).^(2)))];
    
    datestr(now)
end


