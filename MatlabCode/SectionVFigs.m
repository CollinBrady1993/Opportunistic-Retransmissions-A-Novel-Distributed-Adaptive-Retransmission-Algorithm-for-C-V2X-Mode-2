 
throughput5133 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv5,NSe1.csv');
throughput5233 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv5,NSe2.csv');
throughput5333 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv5,NSe3.csv');
throughput5433 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv5,NSe4.csv');

throughput10133 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv10,NSe1.csv');
throughput10233 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv10,NSe2.csv');
throughput10333 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv10,NSe3.csv');
throughput10433 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv10,NSe4.csv');

throughput20133 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv20,NSe1.csv');
throughput20233 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv20,NSe2.csv');
throughput20333 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv20,NSe3.csv');
throughput20433 = csvread('Results\ThroughputCurves\standards\throughput,t233,dv20,NSe4.csv');

[d5331,prr5331] = prrBlindCalcFunc(100,2,33,1/5,1);
[d5332,prr5332] = prrBlindCalcFunc(100,2,33,1/5,2);
[d5333,prr5333] = prrBlindCalcFunc(100,2,33,1/5,3);
[d5334,prr5334] = prrBlindCalcFunc(100,2,33,1/5,4);
[d10331,prr10331] = prrBlindCalcFunc(100,2,33,1/10,1);
[d10332,prr10332] = prrBlindCalcFunc(100,2,33,1/10,2);
[d10333,prr10333] = prrBlindCalcFunc(100,2,33,1/10,3);
[d10334,prr10334] = prrBlindCalcFunc(100,2,33,1/10,4);
[d20331,prr20331] = prrBlindCalcFunc(100,2,33,1/20,1);
[d20332,prr20332] = prrBlindCalcFunc(100,2,33,1/20,2);
[d20333,prr20333] = prrBlindCalcFunc(100,2,33,1/20,3);
[d20334,prr20334] = prrBlindCalcFunc(100,2,33,1/20,4);


MSE = zeros(3,4);
MSE(1,1) = mean((10*prr5331(1:1:32)-throughput5133(1:32,1)').^2);
MSE(1,2) = mean((10*prr5332(1:1:32)-throughput5233(1:32,1)').^2);
MSE(1,3) = mean((10*prr5333(1:1:32)-throughput5333(1:32,1)').^2);
MSE(1,4) = mean((10*prr5334(1:1:32)-throughput5433(1:32,1)').^2);

MSE(2,1) = mean((10*prr10331(2:2:32)-throughput10133(1:1:16,1)').^2);
MSE(2,2) = mean((10*prr10332(2:2:32)-throughput10233(1:1:16,1)').^2);
MSE(2,3) = mean((10*prr10333(2:2:32)-throughput10333(1:1:16,1)').^2);
MSE(2,4) = mean((10*prr10334(2:2:32)-throughput10433(1:1:16,1)').^2);

MSE(3,1) = mean((10*prr20331(4:4:32)-throughput20133(1:1:8,1)').^2);
MSE(3,2) = mean((10*prr20332(4:4:32)-throughput20233(1:1:8,1)').^2);
MSE(3,3) = mean((10*prr20333(4:4:32)-throughput20333(1:1:8,1)').^2);
MSE(3,4) = mean((10*prr20334(4:4:32)-throughput20433(1:1:8,1)').^2);


%4c
figure
hold on
grid on
set(gca,'FontSize',30)
xlabel 'd_{t,r} (m)'
ylabel '\Lambda(d_{t,r},N_{Se}) (Packets/(UE \cdot s)'
errorbar(5:5:2000,throughput5133(:,1),1.96*throughput5133(:,2)./sqrt(throughput5133(:,3)),'linewidth',3,'capSize',15)
errorbar(5:5:2000,throughput5433(:,1),1.96*throughput5433(:,2)./sqrt(throughput5433(:,3)),'linewidth',3,'capSize',15)
plot(d5331,10*prr5331,'linewidth',3)
plot(d5334,10*prr5334,'linewidth',3)
legend('Simulated \Lambda(d_{t,r},N_{Se}=1) w/ 95% Confidence Interval','Simulated \Lambda(d_{t,r},N_{Se}=4) w/ 95% Confidence Interval','Calculated \Lambda(d_{t,r},N_{Se}=1)','Calculated \Lambda(d_{t,r},N_{Se}=4)')
set(gca,'XLim',[0,200])
set(gca,'YLim',[0,10])

%4b
figure
hold on
grid on
set(gca,'FontSize',30)
xlabel 'd_{t,r} (m)'
ylabel '\Lambda(d_{t,r},N_{Se}) (Packets/(UE \cdot s)'
errorbar(10:10:2000,throughput10133(:,1),1.96*throughput10133(:,2)./sqrt(throughput10133(:,3)),'linewidth',3,'capSize',15)
errorbar(10:10:2000,throughput10433(:,1),1.96*throughput10433(:,2)./sqrt(throughput10433(:,3)),'linewidth',3,'capSize',15)
plot(d10331,10*prr10331,'linewidth',3)
plot(d10334,10*prr10334,'linewidth',3)
legend('Simulated \Lambda(d_{t,r},N_{Se}=1) w/ 95% Confidence Interval','Simulated \Lambda(d_{t,r},N_{Se}=4) w/ 95% Confidence Interval','Calculated \Lambda(d_{t,r},N_{Se}=1)','Calculated \Lambda(d_{t,r},N_{Se}=4)')
set(gca,'XLim',[0,200])
set(gca,'YLim',[0,10])

%4a
figure
hold on
grid on
set(gca,'FontSize',30)
xlabel 'd_{t,r} (m)'
ylabel '\Lambda(d_{t,r},N_{Se}) (Packets/(UE \cdot s)'
errorbar(20:20:2000,throughput20133(:,1),1.96*throughput20133(:,2)./sqrt(throughput20133(:,3)),'linewidth',3,'capSize',15)
errorbar(20:20:2000,throughput20433(:,1),1.96*throughput20433(:,2)./sqrt(throughput20433(:,3)),'linewidth',3,'capSize',15)
plot(d20331,10*prr20331,'linewidth',3)
plot(d20334,10*prr20334,'linewidth',3)
legend('Simulated \Lambda(d_{t,r},N_{Se}=1) w/ 95% Confidence Interval','Simulated \Lambda(d_{t,r},N_{Se}=4) w/ 95% Confidence Interval','Calculated \Lambda(d_{t,r},N_{Se}=1)','Calculated \Lambda(d_{t,r},N_{Se}=4)')
set(gca,'XLim',[0,200])
set(gca,'YLim',[0,10])


