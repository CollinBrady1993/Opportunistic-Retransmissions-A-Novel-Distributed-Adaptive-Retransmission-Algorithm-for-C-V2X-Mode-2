%separation=5;%m
numLanes = 2;
laneSeparation = 4;%m
numUe = 300;
speed = 0;%m/s
RRI = .1;%s
rho = 1/RRI;%hz
deadTime = 400*RRI;%this is the amount of time to throw away at the begining of the trace, due to the transient effects of starting the simulation. it allows for each UE to have gone through reselection a MINIMUM of 50 times
endTime = 48 + deadTime;%this is because if the records are too long then it can take forever to process the data

conn = sqlite('D:\Journal-C-V2X-Results\alg-results\D-Re\dv5,alpha.5-new\default-nr-v2x-west-to-east-highway.db');

%find PDR
disp('fetching time')
sqlquery = 'SELECT timeSec FROM pktTxRx';
time = fetch(conn, sqlquery);
time = cell2mat(time);

start = find(time < min(time)+deadTime,1,'last');
time(1:start) = [];
finish = find(time > endTime,1,'first');
time(finish:end) = [];


disp('fetching txRx')
sqlquery = 'SELECT txRx FROM pktTxRx';
txRx = fetch(conn, sqlquery);
txRx = strcmp(txRx,'tx');

txRx(1:start) = [];
txRx(finish:end) = [];

disp('fetching sourceIp')
sqlquery = 'SELECT srcIp FROM pktTxRx';
srcIp = fetch(conn, sqlquery);
srcIp(1:start) = [];
srcIp(finish:end) = [];
srcIp = split(srcIp,'.');
srcIp = 256*str2double(srcIp(:,3)) + str2double(srcIp(:,4))-2;%-2 converts from ip to node id



disp('fetching nodeId')
sqlquery = 'SELECT nodeId FROM pktTxRx';
nodeId = fetch(conn, sqlquery);
nodeId = double(cell2mat(nodeId));

nodeId(1:start) = [];
nodeId(finish:end) = [];


disp('fetching pktSeqNum')
sqlquery = 'SELECT pktSeqNum FROM pktTxRx';
pktSeqNum = fetch(conn, sqlquery);
pktSeqNum = double(cell2mat(pktSeqNum));

pktSeqNum(1:start) = [];
pktSeqNum(finish:end) = [];



txRecord = [time(txRx),nodeId(txRx),pktSeqNum(txRx)];%time,sender,seqNum
rxRecord = [time(not(txRx)),srcIp(not(txRx)),nodeId(not(txRx)),pktSeqNum(not(txRx))];%time, sender,reciever,seqNum


clear('time','txRx','decoded','nodeId','pktSeqNum','srcIp','conn','sqlquery')

disp('inputs found')


%placing UE
initialPos = zeros(numUe,2);
for i = 1:numLanes
    for j = 1:numUe/numLanes%this will always be a whole number
        initialPos((i-1)*numUe/numLanes + j,1) = (j-1)*separation;
        initialPos((i-1)*numUe/numLanes + j,2) = (i-1)*laneSeparation;
    end
end

%deterimining relevant UE. Relevant UE are ones central to the simulation,
%no edge effects. Right now that means UE which will remain within the
%central 300 meters the whole sim.
disp('determining receptions')

rawData = zeros(size(txRecord,1)*numUe,5);
a = 1;
for i = 1:300
    temp = rxRecord(rxRecord(:,2)==i-1,:);%all receptions with matching transmitter
    if mod(i,10) == 0 || i == 1
        i;
        disp(['UE ',num2str(i),' of 300'])
        datestr(now)
    end
    for j = (min(temp(:,4))+1):(max(temp(:,4))-1)%the first and last packets tend to only be partial data, so we ignore them
        temp2 = temp(temp(:,4)==j,:);%all receptions with matching seqNum and transmitter
        
        rtx = initialPos(i-1+1,:);%double([initialPos(txRecord(i,2)+1,1) + (-1)^(txRecord(i,2) < numUe/2)*speed*txRecord(i,1),initialPos(txRecord(i,2)+1,2)]);%current tx Pos
        rxList = [0:(numUe-1)]';
        rrx = initialPos;%double([initialPos(rxList+1,1) + (-1).^(rxList < numUe/2).*speed.*min(temp(:,1)),initialPos(rxList+1,2)]);%current rx Pos

        rxBool = rxList~=(i-1) & rrx(:,1) <= max(initialPos(:,1)) + separation - 300 & rrx(:,1) >= min(initialPos(:,1)) + 300;%only consider central UE as recievers

        dr = vecnorm((rtx-rrx)')';

        receptions = ismember(rxList,temp2(:,3));
        dataTime = zeros(length(rxList),1);
        dataTime(receptions) = min(temp2(:,1));

        if isempty(temp2(:,3))%if NOBODY recieved the packet
            dataTime(dataTime == 0) = temp(1,1);
        else
            dataTime(dataTime == 0) = min(temp2(:,1));
        end

        rawData(a:(a+sum(rxBool)-1),:) = [dataTime(rxBool),repmat(i-1,sum(rxBool),1),rxList(rxBool),dr(rxBool),receptions(rxBool)];
        a = a + sum(rxBool);
    end
end

rawData(a:end,:) = [];

binEdges = separation/2:separation:2000;

%% PDR
disp('calculating PDR')
PDR = zeros(length(binEdges)-1,3);

for i = 1:length(binEdges)-1
    binData = rawData(rawData(:,4) <= binEdges(i+1) & rawData(:,4) > binEdges(i),5);
    
    if isempty(binData)
        PDR(i,1) = 0;
        PDR(i,2) = 0;
        PDR(i,3) = sum(initialPos(:,1) <= max(initialPos(:,1)) + separation - 300 & initialPos(:,1) >= min(initialPos(:,1)) + 300);
    else
        PDR(i,1) = mean(binData);
        PDR(i,2) = std(binData);
        PDR(i,3) = sum(initialPos(:,1) <= max(initialPos(:,1)) + separation - 300 & initialPos(:,1) >= min(initialPos(:,1)) + 300);
    end
end

%% throughput
disp('calculating per-UE throughput')

throughput = zeros(length(binEdges),3);
simTime = max(rawData(:,1)) - min(rawData(:,1));
for i = 1:length(binEdges)-1
    
    if mod(i,10) == 0 || i == 1
        disp(['Calculating throughput ',num2str(i),' of ',num2str(length(binEdges)-1)])
        datestr(now)
    end
    
    binData = rawData(rawData(:,4) <= binEdges(i+1) & rawData(:,4) > binEdges(i),[2,3,5]);
    
    tx = unique(binData(:,1));
    throughputBinData = zeros(1,length(tx)*length(unique(binData(:,2))));
    a = 1;
    for j = 1:length(tx)
        temp = binData(binData(:,1)==tx(j),2:3);
        rx = unique(temp(:,1));
        for k = 1:length(rx)
            
            throughputBinData(a) = sum(temp(temp(:,1)==rx(k),2))/simTime;%the throughput of this UE2UE link
            a = a+1;
        end
        
    end
    
    if a < length(throughputBinData)
        throughputBinData(a:end) = [];
    end
    
    if isempty(binData)
        throughput(i,1) = 0;
        throughput(i,2) = 0;
        throughput(i,3) = sum(initialPos(:,1) <= max(initialPos(:,1)) + separation - 300 & initialPos(:,1) >= min(initialPos(:,1)) + 300);
    else
        throughput(i,1) = mean(throughputBinData);
        throughput(i,2) = std(throughputBinData);
        throughput(i,3) = sum(initialPos(:,1) <= max(initialPos(:,1)) + separation - 300 & initialPos(:,1) >= min(initialPos(:,1)) + 300);
    end
    
end













