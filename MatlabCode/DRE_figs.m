%D-Re alg
throughput50 = csvread('Results\ThroughputCurves\DRe\DRE,throughput,dv5,alpha1.csv');
throughput51 = csvread('Results\ThroughputCurves\DRe\DRE,throughput,dv5,alphap1.csv');
throughput525 = csvread('Results\ThroughputCurves\DRe\DRE,throughput,dv5,alphap25.csv');
throughput55 = csvread('Results\ThroughputCurves\DRe\DRE,throughput,dv5,alphap5.csv');

throughput105 = csvread('Results\ThroughputCurves\DRe\DRE,throughput,dv10,alphap5.csv');
throughput205 = csvread('Results\ThroughputCurves\DRe\DRE,throughput,dv20,alphap5.csv');

%must be generated via ns-3 simulations, files not included. once generated
%change path to location of currentRhoUeEstimate.csv
rhoUeEstimate50 = csvread('Results\rhoUeEstimates\D-Re\dv5,alpha1\currentRhoUeEstimate.csv');
rhoUeEstimate51 = csvread('Results\rhoUeEstimates\D-Re\dv5,alpha.1\currentRhoUeEstimate.csv');
rhoUeEstimate525 = csvread('Results\rhoUeEstimates\D-Re\dv5,alpha.25\currentRhoUeEstimate.csv');
rhoUeEstimate55 = csvread('Results\rhoUeEstimates\D-Re\dv5,alpha.5\currentRhoUeEstimate.csv');

rhoUeEstimate105 = csvread('Results\rhoUeEstimates\D-Re\dv10,alpha.5\currentRhoUeEstimate.csv');
rhoUeEstimate205 = csvread('Results\rhoUeEstimates\D-Re\dv20,alpha.5\currentRhoUeEstimate.csv');


%DRE fig12
figure
hold on
grid on
set(gca,'FontSize',30)
plot(rhoUeEstimate51(:,1)/1000,mean([rhoUeEstimate51(:,31:119),rhoUeEstimate51(:,181:269)],2),'linewidth',3)
plot(rhoUeEstimate525(:,1)/1000,mean([rhoUeEstimate525(:,31:119),rhoUeEstimate525(:,181:269)],2),'linewidth',3)
plot(rhoUeEstimate55(:,1)/1000,mean([rhoUeEstimate55(:,31:119),rhoUeEstimate55(:,181:269)],2),'linewidth',3)
plot(rhoUeEstimate50(:,1)/1000,mean([rhoUeEstimate50(:,31:119),rhoUeEstimate50(:,181:269)],2),'linewidth',3)
legend('\alpha=.1','\alpha=.25','\alpha=.5','\alpha=1','Location','Southeast')
xlabel 'time (s)'
ylabel('$\mu_{\hat{\rho}}$','interpreter','latex')
set(gca,'XLim',[2,90])
set(gca,'YLim',[.1,.4])

%DRE fig12b, unused in paper
figure
hold on
grid on
set(gca,'FontSize',30)
plot(rhoUeEstimate51(:,1)/1000,var([rhoUeEstimate51(:,31:119),rhoUeEstimate51(:,181:269)],0,2),'linewidth',3)
plot(rhoUeEstimate525(:,1)/1000,var([rhoUeEstimate525(:,31:119),rhoUeEstimate525(:,181:269)],0,2),'linewidth',3)
plot(rhoUeEstimate55(:,1)/1000,var([rhoUeEstimate55(:,31:119),rhoUeEstimate55(:,181:269)],0,2),'linewidth',3)
plot(rhoUeEstimate50(:,1)/1000,var([rhoUeEstimate50(:,31:119),rhoUeEstimate50(:,181:269)],0,2),'linewidth',3)
legend('\alpha=.1','\alpha=.25','\alpha=.5','\alpha=1')
xlabel 'time (s)'
ylabel('$\sigma_{\hat{\rho}}^2$','interpreter','latex')
set(gca,'XLim',[2,92])
set(gca,'YLim',[0,.02])


%DRE fig13
figure
hold on
grid on
set(gca,'FontSize',30)
errorbar(5:5:2000,throughput51(:,1),1.96*throughput51(:,2)./sqrt(throughput51(:,3)),'linewidth',3,'capSize',15)
errorbar(5:5:2000,throughput525(:,1),1.96*throughput525(:,2)./sqrt(throughput525(:,3)),'linewidth',3,'capSize',15)
errorbar(5:5:2000,throughput55(:,1),1.96*throughput55(:,2)./sqrt(throughput55(:,3)),'linewidth',3,'capSize',15)
errorbar(5:5:2000,throughput50(:,1),1.96*throughput50(:,2)./sqrt(throughput50(:,3)),'linewidth',3,'capSize',15)
legend('Simulated \Lambda_{D-Re}(d_{t,r}) w/ 95% Confidence Interval, \alpha=.1','Simulated \Lambda_{D-Re}(d_{t,r}) w/ 95% Confidence Interval, \alpha=.25','Simulated \Lambda_{D-Re}(d_{t,r}) w/ 95% Confidence Interval, \alpha=.5','Simulated \Lambda_{D-Re}(d_{t,r}) w/ 95% Confidence Interval, \alpha=1')
xlabel 'd_{t,r}'
ylabel '\Lambda_{D-Re}(d_{t,r}) (Packets/(UE \cdot s))'
set(gca,'XLim',[5,200])
set(gca,'YLim',[0,10])
