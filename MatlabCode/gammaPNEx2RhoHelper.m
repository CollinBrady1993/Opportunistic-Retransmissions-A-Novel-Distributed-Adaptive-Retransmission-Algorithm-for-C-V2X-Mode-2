function [PEx] = gammaPNEx2RhoHelper(RRI,T1,T2,rhoUE,NSe,gammaX)


%% setup
tau = 1000/RRI;%Hz
mu = 0;%numerology indicator, mu=[0,1,2,3] = subcarrier spacing = [15,30,60,120] kHz
fc = 5.89;%GHz
Pt = 23;%dBm
PtWpHzPSCCH = 10^((Pt-30)/10)/(180000*10);%power spectral density in one PSCCH RB as calculated by ns-3, 10 RB used for PSCCH
subchannelsPerChannel = 4;
pueSeparation = 1/(rhoUE);%m
numLanes = 2;



dStep = 5;%pueSeparation;%this number has to be lower than the granularity of pueSeparation and dueSeparation
dMax = max(100*pueSeparation,1000);%8000;
d = dStep:dStep:dMax;%m


pathLoss = 32.4 + 20*log10(d) + 20*log10(fc);%d in meters, fc in GHz, highway model
sigmaSF = 3;




NshPUE = (T2-T1+1);%(T2-T1+1)^2/(2*(T2-T1)+1);

TB = formT(round(subchannelsPerChannel*NshPUE));
C1 = dStep*rhoUE*((tau/(1000*2^mu))*NshPUE*numLanes)*NSe;

meanPr = 10*log10(PtWpHzPSCCH/5)-pathLoss;
a=(2*rhoUE*numLanes*NSe/(subchannelsPerChannel*100))*sqrt((PtWpHzPSCCH/5)/((10^3.24)*fc^2));
b = 4.5*10^(-17)*10^(gammaX)/5;

gammaSPS = 10*log10((a^2+2*b-sqrt(a^4+4*a^2*b))/2);%10*log10(b);%
deltaFTR2 = .5*(1 - erf((meanPr-gammaSPS)/(sigmaSF*sqrt(2))));%this is for the deltaCol calculation, needed if gammaSPS ~= gammaFTR


deltaFTRM = [fliplr(deltaFTR2),1/numLanes,deltaFTR2];%1/numlanes to eliminate the transmitter and reciever
Nrx = trapz(dStep,C1*(1-deltaFTRM));
PEx1 = TB^floor(Nrx);
PEx2 = TB^ceil(Nrx);
PEx = (PEx1 + PEx2)/2;
PEx = PEx(1,:);%dont care about the other rows
    

end
