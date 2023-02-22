%O-Re results
OReThroughput2505 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.25,gamma0.05.csv');
OReThroughput251 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.25,gamma0.1.csv');
OReThroughput25175 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.25,gamma0.175.csv');
OReThroughput2525 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.25,gamma0.25.csv');

OReThroughput505 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.5,gamma0.05.csv');
OReThroughput51 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.5,gamma0.1.csv');
OReThroughput5175 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.5,gamma0.175.csv');
OReThroughput525 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.5,gamma0.25.csv');

OReThroughput7505 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.5,gamma0.05.csv');
OReThroughput751 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.75,gamma0.1.csv');
OReThroughput75175 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.75,gamma0.175.csv');
OReThroughput7525 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta0.5,gamma0.25.csv');

OReThroughput105 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta1,gamma0.05.csv');
OReThroughput11 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta1,gamma0.1.csv');
OReThroughput1175 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta1,gamma0.175.csv');
OReThroughput125 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv5,alphap5,beta1,gamma0.25.csv');

OReThroughput1051 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv10,alphap5,beta0.5,gamma0.1.csv');
OReThroughput2051 = csvread('Results\ThroughputCurves\ORe\ORE,throughput,dv20,alphap5,beta0.5,gamma0.1.csv');


%must be generated via ns-3 simulations, files not included. once generated
%change path to location of currentRhoUeEstimate.csv/currentDEdgeEstimate.csv
ORerhoUeEstimate2505 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.25,gamma0.05\currentRhoUeEstimate.csv');
ORerhoUeEstimate251 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.25,gamma0.1\currentRhoUeEstimate.csv');
ORerhoUeEstimate25175 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.25,gamma0.175\currentRhoUeEstimate.csv');
ORerhoUeEstimate2525 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.25,gamma0.25\currentRhoUeEstimate.csv');

ORerhoUeEstimate505 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.5,gamma0.05\currentRhoUeEstimate.csv');
ORerhoUeEstimate51 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.5,gamma0.1\currentRhoUeEstimate.csv');
ORerhoUeEstimate5175 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.5,gamma0.175\currentRhoUeEstimate.csv');
ORerhoUeEstimate525 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.5,gamma0.25\currentRhoUeEstimate.csv');

ORerhoUeEstimate7505 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.75,gamma0.05\currentRhoUeEstimate.csv');
ORerhoUeEstimate751 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.75,gamma0.1\currentRhoUeEstimate.csv');
ORerhoUeEstimate75175 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.75,gamma0.175\currentRhoUeEstimate.csv');
ORerhoUeEstimate7525 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta0.75,gamma0.25\currentRhoUeEstimate.csv');

ORerhoUeEstimate105 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta1,gamma0.05\currentRhoUeEstimate.csv');
ORerhoUeEstimate11 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta1,gamma0.1\currentRhoUeEstimate.csv');
ORerhoUeEstimate1175 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta1,gamma0.175\currentRhoUeEstimate.csv');
ORerhoUeEstimate125 = csvread('Results\rhoUeEstimates\O-Re\dv5,alphap5,beta1,gamma0.25\currentRhoUeEstimate.csv');

ORedEdgeEstimate2505 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.25,gamma0.05\currentDEdgeEstimate.csv');
ORedEdgeEstimate251 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.25,gamma0.1\currentDEdgeEstimate.csv');
ORedEdgeEstimate25175 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.25,gamma0.175\currentDEdgeEstimate.csv');
ORedEdgeEstimate2525 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.25,gamma0.25\currentDEdgeEstimate.csv');

ORedEdgeEstimate505 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.5,gamma0.05\currentDEdgeEstimate.csv');
ORedEdgeEstimate51 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.5,gamma0.1\currentDEdgeEstimate.csv');
ORedEdgeEstimate5175 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.5,gamma0.175\currentDEdgeEstimate.csv');
ORedEdgeEstimate525 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.5,gamma0.25\currentDEdgeEstimate.csv');

ORedEdgeEstimate7505 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.75,gamma0.05\currentDEdgeEstimate.csv');
ORedEdgeEstimate751 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.75,gamma0.1\currentDEdgeEstimate.csv');
ORedEdgeEstimate75175 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.75,gamma0.175\currentDEdgeEstimate.csv');
ORedEdgeEstimate7525 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta0.75,gamma0.25\currentDEdgeEstimate.csv');

ORedEdgeEstimate105 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta1,gamma0.05\currentDEdgeEstimate.csv');
ORedEdgeEstimate11 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta1,gamma0.1\currentDEdgeEstimate.csv');
ORedEdgeEstimate1175 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta1,gamma0.175\currentDEdgeEstimate.csv');
ORedEdgeEstimate125 = csvread('Results\dEdgeEstimates\O-Re\dv5,alphap5,beta1,gamma0.25\currentDEdgeEstimate.csv');

%D-Re alg
DReThroughput55 = csvread('Results\ThroughputCurves\DRe\DRE,throughput,dv5,alphap5.csv');
DReThroughput105 = csvread('Results\ThroughputCurves\DRe\DRE,throughput,dv10,alphap5.csv');
DReThroughput205 = csvread('Results\ThroughputCurves\DRe\DRE,throughput,dv20,alphap5.csv');

%baseline standards alg
standardsThroughput5133 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv5,NSe1.csv');
standardsThroughput5233 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv5,NSe2.csv');
standardsThroughput5333 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv5,NSe3.csv');
standardsThroughput5433 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv5,NSe4.csv');

standardsThroughput10133 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv10,NSe1.csv');
standardsThroughput10233 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv10,NSe2.csv');
standardsThroughput10333 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv10,NSe3.csv');
standardsThroughput10433 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv10,NSe4.csv');

standardsThroughput20133 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv20,NSe1.csv');
standardsThroughput20233 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv20,NSe2.csv');
standardsThroughput20333 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv20,NSe3.csv');
standardsThroughput20433 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv20,NSe4.csv');


%ORE fig15
figure
hold on
grid on
set(gca,'FontSize',30)
plot(ORedEdgeEstimate251(:,1)/1000,mean([ORedEdgeEstimate251(:,31:119),ORedEdgeEstimate251(:,181:269)],2),'linewidth',3)
plot(ORedEdgeEstimate51(:,1)/1000,mean([ORedEdgeEstimate51(:,31:119),ORedEdgeEstimate51(:,181:269)],2),'linewidth',3)
plot(ORedEdgeEstimate751(:,1)/1000,mean([ORedEdgeEstimate751(:,31:119),ORedEdgeEstimate751(:,181:269)],2),'linewidth',3)
plot(ORedEdgeEstimate11(:,1)/1000,mean([ORedEdgeEstimate11(:,31:119),ORedEdgeEstimate11(:,181:269)],2),'linewidth',3)
legend('\beta=.25','\beta=.5','\beta=.75','\beta=1','Location','Southeast')
xlabel 'time (s)'
ylabel('$\mu_{d_{edge}}$','interpreter','latex')
set(gca,'XLim',[2,95])
%set(gca,'YLim',[.1,.4])

%ORE fig15b, unused
figure
hold on
grid on
set(gca,'FontSize',30)
plot(ORedEdgeEstimate251(:,1)/1000,var([ORedEdgeEstimate251(:,31:119),ORedEdgeEstimate251(:,181:269)],0,2),'linewidth',3)
plot(ORedEdgeEstimate51(:,1)/1000,var([ORedEdgeEstimate51(:,31:119),ORedEdgeEstimate51(:,181:269)],0,2),'linewidth',3)
plot(ORedEdgeEstimate751(:,1)/1000,var([ORedEdgeEstimate751(:,31:119),ORedEdgeEstimate751(:,181:269)],0,2),'linewidth',3)
plot(ORedEdgeEstimate11(:,1)/1000,var([ORedEdgeEstimate11(:,31:119),ORedEdgeEstimate11(:,181:269)],0,2),'linewidth',3)
legend('\beta=.25','\beta=.5','\beta=.75','\beta=1')
xlabel 'time (s)'
ylabel('$\mu_{d_{edge}}$','interpreter','latex')
set(gca,'XLim',[2,95])
%set(gca,'YLim',[.1,.4])

%ORE fig14
figure
hold on
grid on
set(gca,'FontSize',30)
plot(ORedEdgeEstimate505(:,1)/1000,mean([ORedEdgeEstimate505(:,31:119),ORedEdgeEstimate505(:,181:269)],2),'linewidth',3)
plot(ORedEdgeEstimate51(:,1)/1000,mean([ORedEdgeEstimate51(:,31:119),ORedEdgeEstimate51(:,181:269)],2),'linewidth',3)
plot(ORedEdgeEstimate5175(:,1)/1000,mean([ORedEdgeEstimate5175(:,31:119),ORedEdgeEstimate5175(:,181:269)],2),'linewidth',3)
plot(ORedEdgeEstimate525(:,1)/1000,mean([ORedEdgeEstimate525(:,31:119),ORedEdgeEstimate525(:,181:269)],2),'linewidth',3)
legend('\gamma=.05','\gamma=.1','\gamma=.175','\gamma=.25','Location','Southeast')
xlabel 'time (s)'
ylabel('$\mu_{d_{edge}}$','interpreter','latex')
set(gca,'XLim',[2,105])
%set(gca,'YLim',[.1,.4])

%ORE fig14b, unused
figure
hold on
grid on
set(gca,'FontSize',30)
plot(ORedEdgeEstimate505(:,1)/1000,var([ORedEdgeEstimate505(:,31:119),ORedEdgeEstimate505(:,181:269)],0,2),'linewidth',3)
plot(ORedEdgeEstimate51(:,1)/1000,var([ORedEdgeEstimate51(:,31:119),ORedEdgeEstimate51(:,181:269)],0,2),'linewidth',3)
plot(ORedEdgeEstimate5175(:,1)/1000,var([ORedEdgeEstimate5175(:,31:119),ORedEdgeEstimate5175(:,181:269)],0,2),'linewidth',3)
plot(ORedEdgeEstimate525(:,1)/1000,var([ORedEdgeEstimate525(:,31:119),ORedEdgeEstimate525(:,181:269)],0,2),'linewidth',3)
legend('\gamma=.05','\gamma=.1','\gamma=.175','\gamma=.25','Location','Southeast')
xlabel 'time (s)'
ylabel('$\sigma_{d_{edge}}^2$','interpreter','latex')
set(gca,'XLim',[2,95])
%set(gca,'YLim',[.1,.4])

%ORE table V
muLambda = zeros(3,4);

muLambda(1,1) = mean(OReThroughput2505(1:32,1));
muLambda(1,2) = mean(OReThroughput251(1:32,1));
muLambda(1,3) = mean(OReThroughput25175(1:32,1));
muLambda(1,4) = mean(OReThroughput2525(1:32,1));

muLambda(2,1) = mean(OReThroughput505(1:32,1));
muLambda(2,2) = mean(OReThroughput51(1:32,1));
muLambda(2,3) = mean(OReThroughput5175(1:32,1));
muLambda(2,4) = mean(OReThroughput525(1:32,1));

muLambda(3,1) = mean(OReThroughput7505(1:32,1));
muLambda(3,2) = mean(OReThroughput751(1:32,1));
muLambda(3,3) = mean(OReThroughput75175(1:32,1));
muLambda(3,4) = mean(OReThroughput7525(1:32,1));

muLambda(4,1) = mean(OReThroughput105(1:32,1));
muLambda(4,2) = mean(OReThroughput11(1:32,1));
muLambda(4,3) = mean(OReThroughput1175(1:32,1));
muLambda(4,4) = mean(OReThroughput125(1:32,1));


figure
surf([.05,.1,.175,.25],[.25,.5,.75,1],muLambda)
set(gca,'FontSize',30)
ylabel '\beta'
xlabel '\gamma'
zlabel('$\mu_{\Lambda}$','interpreter','latex')
%set(gca,'ZLim',[4.65,4.85])
%set(gca,'YLim',[.1,.4])

%DRE fig16
rho = [2/20,2/10,2/5];
dreMean = [mean(DReThroughput205(1:8,1)),mean(DReThroughput105(1:16,1)),mean(DReThroughput55(1:32,1))];
oreMean = [mean(OReThroughput2051(1:8,1)),mean(OReThroughput1051(1:16,1)),mean(OReThroughput51(1:32,1))];
NSe1Mean = [mean(standardsThroughput20133(1:8,1)),mean(standardsThroughput10133(1:16,1)),mean(standardsThroughput5133(1:32,1))];
NSe2Mean = [mean(standardsThroughput20233(1:8,1)),mean(standardsThroughput10233(1:16,1)),mean(standardsThroughput5233(1:32,1))];
NSe3Mean = [mean(standardsThroughput20333(1:8,1)),mean(standardsThroughput10333(1:16,1)),mean(standardsThroughput5333(1:32,1))];
NSe4Mean = [mean(standardsThroughput20433(1:8,1)),mean(standardsThroughput10433(1:16,1)),mean(standardsThroughput5433(1:32,1))];

figure
hold on
grid on
set(gca,'FontSize',30)
plot(rho,dreMean,'--o','linewidth',3)
plot(rho,oreMean,'-.diamond','linewidth',3)
plot(rho,NSe1Mean,'-o','linewidth',3)
plot(rho,NSe2Mean,'-o','linewidth',3)
plot(rho,NSe3Mean,'-o','linewidth',3)
plot(rho,NSe4Mean,'-o','linewidth',3)
legend('\mu_{\Lambda,D-Re}','\mu_{\Lambda,O-Re}','\mu_{\Lambda}(N_{Se}=1)','\mu_{\Lambda}(N_{Se}=2)','\mu_{\Lambda}(N_{Se}=3)','\mu_{\Lambda}(N_{Se}=4)')
xlabel '\rho_{UE} (UE/m)'
ylabel 'Distance Averaged Throughput \newline           (Packets/(UE \cdot s)'
set(gca,'XLim',[.1,.4])
%set(gca,'YLim',[3.75,6.5])



