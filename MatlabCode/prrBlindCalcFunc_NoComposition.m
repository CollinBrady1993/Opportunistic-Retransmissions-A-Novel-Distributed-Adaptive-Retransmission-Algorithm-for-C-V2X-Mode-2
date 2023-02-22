function [d,PRRCalc] = prrBlindCalcFunc_NoComposition(RRI,T1,T2,rhoUE,NSe)


%% setup
tau = 1000/RRI;%Hz
PKeep = 0.0;
mu = 0;%numerology indicator, mu=[0,1,2,3] = subcarrier spacing = [15,30,60,120] kHz
fc = 5.89;%GHz
Pt = 15;%dBm
PtWpHzPSCCH = 10^((Pt-30)/10)/(180000*10);%power spectral density in one PSCCH RB as calculated by ns-3, 10 RB used for PSCCH
rbPerSubchannel = 50;%total number
subchannelsPerChannel = 4;
sensingThreshold = 10*log10(4.5*10^(-17));%dBm,
N0dBm = -174;
pueSeparation = 1/(rhoUE);%m
numLanes = 2;
laneSeparation = 4;


Nr = subchannelsPerChannel*(T2-T1+1);%size of the selection window

dStep = 5;%this number has to be lower than the granularity of pueSeparation and dueSeparation
dMax = max(100*pueSeparation,2000);
d = dStep:dStep:dMax;%m
dPUE = sort([laneSeparation,pueSeparation:pueSeparation:(100*pueSeparation),(sqrt(laneSeparation^2+(pueSeparation:pueSeparation:(100*pueSeparation)).^2))]);%m

%% deltaHd

deltaHd = ((NSe - (NSe - 1)*tau/(1000*2^mu)*(T2-T1+1))*tau/(1000*2^mu))^1;

%% deltaFTR

pathLoss = 32.4 + 20*log10(d) + 20*log10(fc);%d in meters, fc in GHz, highway model
meanPr = 10*log10(PtWpHzPSCCH)-pathLoss;%for the FTR error we are concerned with the PSCCH which has the same EIRP but used 5 times less RB, increaing the power in each RB by 5 times.
sigmaSF = 3;

deltaFTR = .5*(1 - erf((meanPr-sensingThreshold)/(sigmaSF*sqrt(2))));%

%% deltaCol
%with the mixture model this now has two parts, the component from periodic
%ue (PUE) and dynamic UE (DUE), references to p or d in variables are
%referincing these two types of UE. pInt is identical for both, but pSim is
%different.


txPathLoss = 32.4 + 20*log10(d) + 20*log10(fc);%d in meters, fc in GHz
intPathLoss = 32.4 + 20*log10(d) + 20*log10(fc);%d in meters, fc in GHz


meanTxPr = 10*log10(PtWpHzPSCCH)-txPathLoss;
meanIntPr = 10*log10(PtWpHzPSCCH)-intPathLoss;
pSinr = zeros(length(d));

s = linspace(meanTxPr(end) + 10*log10(10.^(meanIntPr(1)/10) + 10^((N0dBm-30)/10)) - 12*sigmaSF,meanTxPr(1) - 10*log10(10.^(meanIntPr(end)/10) + 10^((N0dBm-30)/10)) + 12*sigmaSF,6*length(d));
BLER = SINR2BLER(s,rbPerSubchannel,1774*8,14);
meanSINR = zeros(length(meanTxPr));
for i = 1:length(meanTxPr)
    length(meanTxPr);
    for j = 1:length(meanIntPr)
        meanSINR(i,j) = meanTxPr(i) - 10*log10(10.^(meanIntPr(j)/10) + 10^((N0dBm-30)/10));
        intSigma = log((exp(sigmaSF^2)-1)*(exp(2*meanTxPr(i)) + exp(2*meanIntPr(j)))/(exp(meanTxPr(i)) + exp(meanIntPr(j)))^2 + 1);%Fenton approximation
        fSINR = normpdf(s,meanSINR(i,j),sqrt(intSigma));
        
        
        temp1 = BLER.*fSINR;
        temp2 = trapz(s,temp1);%row it d_{tx,rx}, column is d_{int,rx}
        pSinr(i,j) = temp2;
    end
end


pInt = pSinr;


PoPUE = ((2*(T2-T1+1)-1)/(RRI));
NshPUE = (T2-T1+1)^2/(2*(T2-T1)+1);
PshPUE = (subchannelsPerChannel*NshPUE/(Nr))^2;

%psim for PUE
TB = formT(round(subchannelsPerChannel*NshPUE));
C1 = numLanes*NSe;

meanPr = 10*log10(PtWpHzPSCCH)-pathLoss;
C2 = rhoUE*NSe;
a=(C2/(subchannelsPerChannel*NshPUE))*sqrt((PtWpHzPSCCH)/((10^3.24)*fc^2));
%the post miltiplies term (10^(x)) is determined by selecting x such that
%abs(.8 - (CEx(1) + NExt(1))/(subchannelsPerChannel*NshPUE)) is minimized.
%.8 comes from the cv2x standard


metric = 0;
gammaX = 0;
dGammaX = .3;
epsilon = .001;
indreaseDecreaseFlag = 1;

b = 4.5*10^(-17)*10^(gammaX);
metricTh = .75;
while abs(metric - metricTh) > epsilon

    
    gammaSPS = 10*log10((a^2+2*b-sqrt(a^4+4*a^2*b))/2);%10*log10(b);%10*log10(b/6);%
    deltaFTR2 = .5*(1 - erf((meanPr-gammaSPS)/(sigmaSF*sqrt(2))));%this is for the deltaCol calculation, needed if gammaSPS ~= gammaFTR


    Nrxt = zeros(1,length(d));%number sensed exclusively by UEtx
    NrxB = zeros(1,length(d));%number sensed by both UEtx and UEint
    CEx = zeros(1,length(d));%number of resources excluded by both UEtx and UEint

    NExt = zeros(1,length(d));
    OEx = zeros(1,length(d));
    deltaFTRM = [fliplr(deltaFTR2),1/numLanes,deltaFTR2];%1/numlanes to eliminate the transmitter and reciever

    for i = 1:length(d)

        deltaFTRMS = circshift(deltaFTRM,i);
        deltaFTRMS(1:i) = ones(1,i);%no shift right logical for doubles



        
        Nrxt(i) = 1*sum(C1*(1-deltaFTRM(1:(1/(dStep*rhoUE)):end)).*(deltaFTRMS(1:(1/(dStep*rhoUE)):end)));
        NrxB(i) = 1*sum(C1*(1-deltaFTRM(1:(1/(dStep*rhoUE)):end)).*(1-deltaFTRMS(1:(1/(dStep*rhoUE)):end)));
        
        PExCEx1 = TB^floor(NrxB(i));
        PExCEx2 = TB^ceil(NrxB(i));

        CEx1 = sum([0:(round(subchannelsPerChannel*NshPUE))].*PExCEx1(1,:));
        CEx2 = sum([0:(round(subchannelsPerChannel*NshPUE))].*PExCEx2(1,:));
        CEx(i) = CEx1*(ceil(NrxB(i)) - NrxB(i)) + CEx2*(NrxB(i) - floor(NrxB(i)));

        PExNExt1 = TB^floor(Nrxt(i));
        PExNExt2 = TB^ceil(Nrxt(i));

        NExt1 = sum([0:(round(subchannelsPerChannel*NshPUE))].*PExNExt1(floor(CEx(i))+1,:)) - CEx(i);
        NExt2 = sum([0:(round(subchannelsPerChannel*NshPUE))].*PExNExt1(ceil(CEx(i))+1,:)) - CEx(i);
        NExt3 = sum([0:(round(subchannelsPerChannel*NshPUE))].*PExNExt2(floor(CEx(i))+1,:)) - CEx(i);
        NExt4 = sum([0:(round(subchannelsPerChannel*NshPUE))].*PExNExt2(ceil(CEx(i))+1,:)) - CEx(i);

        if mod(CEx(i),1)==0%check if integer, this really only happens if CEx==0
            NExt(i) = (ceil(Nrxt(i)) - Nrxt(i))*NExt1 + (Nrxt(i) - floor(Nrxt(i)))*NExt3;
        else
            NExt(i) = (ceil(Nrxt(i)) - Nrxt(i))*(NExt1*(ceil(CEx(i)) - CEx(i)) + NExt2*(CEx(i) - floor(CEx(i)))) + (Nrxt(i) - floor(Nrxt(i)))*(NExt3*(ceil(CEx(i)) - CEx(i)) + NExt4*(CEx(i) - floor(CEx(i))));
        end

        OEx(i) = (NExt(i)^2)/(subchannelsPerChannel*NshPUE - CEx(i));

    end
    X = (subchannelsPerChannel*NshPUE - 2*(NExt- OEx) - (CEx+OEx));
    N = (subchannelsPerChannel*NshPUE - CEx - NExt);
    metric = (CEx(end) + NExt(end))/(subchannelsPerChannel*NshPUE);
    
    if abs(metric - metricTh) < epsilon
        break
    else
        if metric < metricTh && gammaX == 0
            break%gammaX cant be less than 0
        elseif metric > metricTh && gammaX >= 0
            gammaX = gammaX + dGammaX;
            if ~indreaseDecreaseFlag%if last itteration gammaX was decreased
                dGammaX = dGammaX/2;
            end
        elseif metric < metricTh && gammaX > 0
            gammaX = gammaX - dGammaX;
            if indreaseDecreaseFlag%if last itteration gammaX was increased
                dGammaX = dGammaX/2;
            end
        end
    end
    b = 4.5*10^(-17)*10^(gammaX);
end

pSimPUE = 1*PoPUE.*PshPUE.*(1 - (1 - 1*((1 - PKeep)/(tau)))*(1 - deltaFTR2.^(NSe)).^(1)).*(X./N).*(1./N);

tempPUE = ones(length(d),length(dPUE));


for i = 1:length(d)%d_{t,r}
    dri1 = d(i)+dPUE;%dPUE is d_{t,i}
    dri2 = abs(d(i)-dPUE);
   
    tempPUE(i,dri1 > d(end) & dri2 < d(1)) = tempPUE(i,dri1 > d(end) & dri2 < d(1))     .* (1 - pInt(i,end).*interp1(d,pSimPUE,dPUE(dri1 > d(end) & dri2 < d(1)),'linear','extrap')).^(NSe)                                                                     .*(1 - pInt(i,1).*interp1(d,pSimPUE,dPUE(dri1 > d(end) & dri2 < d(1)),'linear','extrap')).^(NSe);
    tempPUE(i,dri1 <= d(end) & dri2 < d(1)) = tempPUE(i,dri1 <= d(end) & dri2 < d(1))   .* (1 - interp1(d,pInt(i,:),dri1(dri1 <= d(end) & dri2 < d(1)),'linear','extrap').*interp1(d,pSimPUE,dPUE(dri1 <= d(end) & dri2 < d(1)),'linear','extrap')).^(NSe)      .*(1 - pInt(i,1).*interp1(d,pSimPUE,dPUE(dri1 <= d(end) & dri2 < d(1)),'linear','extrap')).^(NSe);
    tempPUE(i,dri1 > d(end) & dri2 >= d(1)) = tempPUE(i,dri1 > d(end) & dri2 >= d(1))   .* (1 - pInt(i,end).*interp1(d,pSimPUE,dPUE(dri1 > d(end) & dri2 >= d(1)),'linear','extrap')).^(NSe)                                                                    .*(1 - interp1(d,pInt(i,:),dri2(dri1 > d(end) & dri2 >= d(1)),'linear','extrap').*interp1(d,pSimPUE,dPUE(dri1 > d(end) & dri2 >= d(1)),'linear','extrap')).^(NSe);
    tempPUE(i,dri1 <= d(end) & dri2 >= d(1)) = tempPUE(i,dri1 <= d(end) & dri2 >= d(1)) .* (1 - interp1(d,pInt(i,:),dri1(dri1 <= d(end) & dri2 >= d(1)),'linear','extrap').*interp1(d,pSimPUE,dPUE(dri1 <= d(end) & dri2 >= d(1)),'linear','extrap')).^(NSe)    .*(1 - interp1(d,pInt(i,:),dri2(dri1 <= d(end) & dri2 >= d(1)),'linear','extrap').*interp1(d,pSimPUE,dPUE(dri1 <= d(end) & dri2 >= d(1)),'linear','extrap')).^(NSe);
    
end


deltaCol = 1*(1 - 1.*prod(tempPUE,2)');



%% final touches
PRRCalc = (1 - (1 - (1 - deltaHd).*(1 - deltaFTR).*(1 - deltaCol)));
end
