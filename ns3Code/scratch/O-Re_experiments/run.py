# -*- Mode: python; py-indent-offset: 4; indent-tabs-mode: nil; coding: utf-8; -*-
# Copyright (c) 2020 Huazhong University of Science and Technology, Dian Group
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation;
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# Author: Pengyu Liu <eic_lpy@hust.edu.cn>
#         Hao Yin <haoyin@uw.edu>

# An example for the ns3-ai model to illustrate the data exchange
# between python-based AI frameworks and ns-3.
#
# In this example, we have two variable a and b in ns-3,
# and then put them into the shared memory using python to calculate
#
#       c = a + b
#
# Finally, we put back c to the ns-3.

import random
import csv
import math
import numpy as np
import os
import time
from ctypes import *

from py_interface import *


def Sort(sub_li,n):
    sub_li.sort(key = lambda x: x[n],reverse=True)
    return sub_li

# The environment (in this example, contain 'a' and 'b')
# shared between ns-3 and python with the same shared memory
# using the ns3-ai model.
class Env(Structure):
    _pack_ = 1
    _fields_ = [
        ('imsi', c_int),
        ('time', c_double),
        ('occupiedResources', c_int),
        ('rsrpThreshold', c_int),
        ('srcRnti', c_int),
        ('Rc', c_int),
        ('srcSlotNum', c_int),
        ('srcScNum', c_int),
        ('index', c_int),
        ('estimatorUpdateFlag', c_int),
        ('addRecievedPacketFlag', c_int),
        ('selectionModeSelectionFlag', c_int),
        ('getNumResourcesSelectedFlag', c_int),
        ('getChosenSlotFlag', c_int),
        ('getChosenSubChannelFlag', c_int),
        ('nSeQueryFlag', c_int),
        ('firstCallFlag', c_int),
        ('encodedSrcRnti', c_double),
        ('encodedRc', c_double),
        ('encodedSrcSlot', c_double),
        ('encodedSrcSc', c_double),
        ('sensningDataFlag', c_int),
    ]

# The result (in this example, contain 'c') calculated by python
# and put back to ns-3 with the shared memory.
class Act(Structure):
    _pack_ = 1
    _fields_ = [
        ('selectionMode', c_int),
        ('NSe', c_int),
        ('numResourcesSelected',c_int),
        ('chosenSlot',c_int),
        ('chosenSubChannel',c_int),
        ('encodedSelectionInstructions',c_double),
    ]


NExGammaX2NSe1 = []
NExGammaX2NSe2 = []
NExGammaX2NSe3 = []
NExGammaX2NSe4 = []
NEx = []
with open('NEx+gammaX2rhoUE,NSe1,T2T132,RRI100.csv') as csvFile:#all the values of gammaX and NEx are identical for all NSe so theres no need to get them after the first file read
    csvReader=csv.reader(csvFile,delimiter=',')
    lineCount = 0
    for row in csvReader:
        if lineCount == 0:
            gammaX = [float(x) for x in row[1:]]
            lineCount += 1
        else:
            NEx.append(int(row[0]))
            NExGammaX2NSe1.append([float(x) for x in row[1:]])


with open('NEx+gammaX2rhoUE,NSe2,T2T132,RRI100.csv') as csvFile:
    csvReader=csv.reader(csvFile,delimiter=',')
    lineCount = 0
    for row in csvReader:
        if lineCount == 0:
            lineCount += 1
        else:
            NExGammaX2NSe2.append([float(x) for x in row[1:]])

with open('NEx+gammaX2rhoUE,NSe3,T2T132,RRI100.csv') as csvFile:
    csvReader=csv.reader(csvFile,delimiter=',')
    lineCount = 0
    for row in csvReader:
        if lineCount == 0:
            lineCount += 1
        else:
            NExGammaX2NSe3.append([float(x) for x in row[1:]])

with open('NEx+gammaX2rhoUE,NSe4,T2T132,RRI100.csv') as csvFile:
    csvReader=csv.reader(csvFile,delimiter=',')
    lineCount = 0
    for row in csvReader:
        if lineCount == 0:
            lineCount += 1
        else:
            NExGammaX2NSe4.append([float(x) for x in row[1:]])


rhoUE = []
bestMode = []
with open('bestNSe,T2T132,RRI100.csv') as csvFile:
    csvReader=csv.reader(csvFile,delimiter=',')
    lineCount = 0
    for row in csvReader:
        if lineCount == 0:
            rhoUE = [float(x) for x in row]
            lineCount += 1
        else:
            bestMode = [int(x) for x in row]


settingsChoicesRhoUEp1 = []
settingsChoicesRhoUEp2 = []
settingsChoicesRhoUEp4 = []
with open('settingsTable,rhoUE,rhoUEp1,T2T132,RRI100.csv') as csvFile:
    csvReader=csv.reader(csvFile,delimiter=',')
    for row in csvReader:
        settingsChoicesRhoUEp1.append([float(x) for x in row[0:]])

with open('settingsTable,rhoUE,rhoUEp2,T2T132,RRI100.csv') as csvFile:
    csvReader=csv.reader(csvFile,delimiter=',')
    for row in csvReader:
        settingsChoicesRhoUEp2.append([float(x) for x in row[0:]])

with open('settingsTable,rhoUE,rhoUEp4,T2T132,RRI100.csv') as csvFile:
    csvReader=csv.reader(csvFile,delimiter=',')
    for row in csvReader:
        settingsChoicesRhoUEp4.append([float(x) for x in row[0:]])


numUe = 300
numLanes = 2
numUePerLane = int(numUe/numLanes)#this should always be an integer
dV = 10
dL = 4
uePos = []
initialPos = [0,0]
for i in range(numLanes):
    for j in range(numUePerLane):
        uePos.append([initialPos[0]+dV*j, initialPos[1] + dL*i])

print(uePos)

dZ = 5
zoneId = []
zoneCenters = []
zoneStart = [-2.5,-3]
#zones are numbered 1 to n (n depends on dZ). the bounds of the zones start at -2.5,-3 so that when dZ = 5 and dV = 5, dL = 4 the zones cleanly fit one UE per zone. this also makes it so when dZ = 10
#there are 4 UE per zone and so on upwards. you could make this cleaner in the sense that you could make it so when dZ > 5 you move the origin so it always splits the road in two (a zone boundry 
#exactly on the road divider) but I dont feel that this is a fair approximation of a real world scenario.
for i in range(numUe):
    tempX = 1
    tempY = 1
    while uePos[i][0] > zoneStart[0] + dZ*(tempX):
        tempX += 1
    while uePos[i][1] > zoneStart[1] + dZ*(tempY):
        tempY += 1
    zoneId.append(tempX + int((tempY-1)*numUePerLane*(dV/dZ)))

tempX = 1
tempY = 1
for i in range(zoneId[len(zoneId)-1]):    
    zoneCenters.append([zoneStart[0] + (tempX-1)*dZ + dZ/2,zoneStart[1] + (tempY-1)*dZ + dZ/2])
    tempX+=1
    if tempX > numUe/2*(dV/dZ):
        tempX = 1
        tempY+=1
    

print(zoneId)
print(zoneCenters)

alpha = .5
beta = .5
gamma = .1
t1 = 2
t2 = 33

lastNumExclusions = [1000]*numUe
lastNumExclusionsCsv = []
lastRsrpThreshold = [0]*numUe
lastRsrpThresholdCsv = []
lastRecievedPackets = [ [] for _ in range(numUe) ]
currentRhoUeEstimate = [.1]*numUe
currentRhoUeEstimateCsv = []
currentDEdgeEstimate = [75]*numUe
currentDEdgeEstimateCsv = []
currentNSe = [1]*numUe
queryFlag = [0]*numUe
selectionModeSelectionCounter = 0
OReCounter = 0

lastImsi = -1#this needs to be defined because at the very begining of the simulation selectionModeSelection is called before estimatoreUpdate. This isn't and isue because it gets quickly overwritten
#and affects nothing
ns3Settings = {'t1': t1, 't2': t2, 'slMaxTxTransNumPssch': 1, 'interVehicleDist': dV, 'outputDir': '/home/collin/workspace/nr-sidelink/'}
mempool_key = 1234                                          # memory pool key, arbitrary integer large than 1000
mem_size = 4096                                             # memory pool size in bytes
memblock_key = 2333                                         # memory block key, need to keep the same in the ns-3 script
exp = Experiment(mempool_key, mem_size, 'O-Re_experiments', '../../')      # Set up the ns-3 environment
#print("apple")
try:
    for i in range(1):
        exp.reset()                                             # Reset the environment
        rl = Ns3AIRL(memblock_key, Env, Act)                    # Link the shared memory block with ns-3 script
        pro = exp.run(setting=ns3Settings, show_output=True)    # Set and run the ns-3 script (sim.cc)
        while not rl.isFinish():
            with rl as data:
                if data == None:
                    break
                #the functions will be called in the following order per UE:
                #1: estimatorUpdate will be called by NrUeMac::GetNrSlTxOpportunities once
                #2: addRecievedPacket will be called by NrUeMac::GetNrSlTxOpportunities a number of times equal to the number of packets decoded
                    #steps 1/2 serve to load the important data into the python running script from the sensing phase of SPS reselection
                #3: selectionModeSelect will be called by NrSlUeMacSchedulerSimple::DoNrSlAllocation once
                    #step 3 is the main "Logic" of the algorithm. in addition to determining if the UE opperates in O-Re or D-Re mode this selection the UE selects the resources for O-Re and NSe for D-Re
                #4: either NSeQuery will be called by NrSlUeMacSchedulerSimple::DoNrSlAllocation once in the case of D-Re opperation (no appropriate/not enough overwriteable resouces found). If called this is the final call
                #5: or getNumResourcesSelected will be called by NrSlUeMacSchedulerSimple::DoNrSlAllocation once in the case of O-Re opperation. If called the following two function will be called up to four times:
                #6: getChosenSlot will be called by NrSlUeMacSchedulerSimple::DoNrSlAllocation
                #7: getChosenSubChannel will be called by NrSlUeMacSchedulerSimple::DoNrSlAllocation
                    #steps 4-7 serve to pass back the relevant information to ns-3 required to carry out the changes to selection

                if data.env.sensningDataFlag == 1:
                    #print("python data load")
                    #print(data.env.time)
                    lastImsi = data.env.imsi-1-math.floor(data.env.imsi/256)#this is saved because the functions are called in sequence and NrSlUeMacSchedulerSimple does not have access to imsi. any calls made by NrSlUeMacSchedulerSimple will be related to this imsi though
                    lastNumExclusions[lastImsi] = data.env.occupiedResources
                    lastRsrpThreshold[lastImsi] = data.env.rsrpThreshold + 110 - 3
                    
                    #for all 4 encoded values we have to add a junk value at the begining to ensure that the leading zeros (or values that equal 0) 
                    #are not erased by the conversion to double on the c++ side. the last value is an end character for force c++ to finish writing 
                    #the string before continuing and must be discarded. If it isn't there though python can try to read the file before it's finished writing, resulting in errors
                    
                    #while(not os.path.isfile('../../encodedSrcRnti.txt')):
                        #time.sleep(.1)

                    if(os.path.isfile('../../encodedSrcRnti.txt')): 
                        with open('../../encodedSrcRnti.txt', 'r') as file:
                            encodedSrcRntiString = file.read()
                        encodedSrcRntiString = encodedSrcRntiString[1:(len(encodedSrcRntiString)-1)]
                        os.remove('../../encodedSrcRnti.txt')
                        #print(encodedSrcRntiString)

                    #while(not os.path.isfile('../../encodedRc.txt')):
                        #time.sleep(.1)

                    if(os.path.isfile('../../encodedRc.txt')): 
                        with open('../../encodedRc.txt', 'r') as file:
                            encodedRcString = file.read()
                        encodedRcString = encodedRcString[1:(len(encodedRcString)-1)]
                        os.remove('../../encodedRc.txt')
                        #print(encodedRcString)

                    #while(not os.path.isfile('../../encodedSrcSlot.txt')):
                        #time.sleep(.1)

                    if(os.path.isfile('../../encodedSrcSlot.txt')): 
                        with open('../../encodedSrcSlot.txt', 'r') as file:
                            encodedSrcSlotString = file.read()
                        encodedSrcSlotString = encodedSrcSlotString[1:(len(encodedSrcSlotString)-1)]
                        os.remove('../../encodedSrcSlot.txt')
                        #print(encodedSrcSlotString)

                    #while(not os.path.isfile('../../encodedSrcSc.txt')):
                        #time.sleep(.1)

                    if(os.path.isfile('../../encodedSrcSc.txt')): 
                        with open('../../encodedSrcSc.txt', 'r') as file:
                            encodedSrcScString = file.read()
                        encodedSrcScString = encodedSrcScString[1:(len(encodedSrcScString)-1)]
                        os.remove('../../encodedSrcSc.txt')
                        #print(encodedSrcScString)

                    lastRecievedPackets[lastImsi].clear()
                    while len(encodedSrcScString) > 0:
                        #leading zeros here ar just padding to ensure consistant size, they can be erased by the conversion to int with no issue
                        lastRecievedPackets[lastImsi].append([int(encodedSrcRntiString[0:3]) - 1 - math.floor(int(encodedSrcRntiString[0:3])/256),int(encodedRcString[0:2]),int(encodedSrcSlotString[0:2]),int(encodedSrcScString[0])])

                        encodedSrcRntiString = encodedSrcRntiString[3:]
                        encodedRcString = encodedRcString[2:]
                        encodedSrcSlotString = encodedSrcSlotString[2:]
                        encodedSrcScString = encodedSrcScString[1:]

                    #if lastImsi == 234:
                    #   print("python")
                    #    print(data.env.firstCallFlag)
                    #    print(len(lastRecievedPackets[lastImsi]) > 0)
                    #if lastImsi == 234:
                    
                else:
                    if lastImsi > -1:#in the first few milliseconds this can be called before any packets are recieved, it doesnt do anything so we just give it dummy values
                        print("selectionModeSelectionFlag")
                        print(lastRecievedPackets[lastImsi])
                        print(data.env.time)
                        selectionModeSelectionCounter+=1
                        ########################################################
                        #estimating rhoUE
                        if (lastImsi > (150/dV - 1) and lastImsi < (750/dV - 150/dV - 1)) or (lastImsi > (900/dV - 1) and lastImsi < (1500/dV - 150/dV - 1)):
                            #temp = [abs(x - lastRsrpThreshold[lastImsi]) for x in gammaX]
                            #closestGammaX = int(temp.index(min(temp)))
                            if currentNSe[lastImsi] == 1:#we keep currentNSe for rhoUE estimation even if it isn't used because selection modde 1 is selected, it is selected later as the last entry of the settings table
                                currentRhoUeEstimate[lastImsi] = alpha*NExGammaX2NSe1[lastNumExclusions[lastImsi]][int(lastRsrpThreshold[lastImsi]/3)] + (1-alpha)*currentRhoUeEstimate[lastImsi]
                            elif currentNSe[lastImsi] == 2:
                                currentRhoUeEstimate[lastImsi] = alpha*NExGammaX2NSe2[lastNumExclusions[lastImsi]][int(lastRsrpThreshold[lastImsi]/3)] + (1-alpha)*currentRhoUeEstimate[lastImsi]
                            elif currentNSe[lastImsi] == 3:
                                currentRhoUeEstimate[lastImsi] = alpha*NExGammaX2NSe3[lastNumExclusions[lastImsi]][int(lastRsrpThreshold[lastImsi]/3)] + (1-alpha)*currentRhoUeEstimate[lastImsi]
                            elif currentNSe[lastImsi] == 4:
                                currentRhoUeEstimate[lastImsi] = alpha*NExGammaX2NSe4[lastNumExclusions[lastImsi]][int(lastRsrpThreshold[lastImsi]/3)] + (1-alpha)*currentRhoUeEstimate[lastImsi]
                        else:#force edge UE to be correct
                            currentRhoUeEstimate[lastImsi] = numLanes/dV
                        #print('*')
                        
                        #print(len(lastRecievedPackets[lastImsi]))
                        ########################################################
                        #estimating dEdge and viable resource counts
                        distFromRx = []
                        for i in range(len(lastRecievedPackets[lastImsi])):
                            #print('apple')
                            #print(zoneId[lastImsi]-1)
                            #print(zoneCenters[zoneId[lastImsi]-1][0])
                            #print(lastRecievedPackets[lastImsi][i][0])
                            #print(zoneCenters[zoneId[lastRecievedPackets[lastImsi][i][0]]-1][0])
                            #print(zoneCenters[zoneId[lastImsi]-1][1])
                            #print(zoneCenters[zoneId[lastRecievedPackets[lastImsi][i][0]]-1][1])
                            distFromRx.append(math.sqrt((zoneCenters[zoneId[lastImsi]-1][0] - zoneCenters[zoneId[lastRecievedPackets[lastImsi][i][0]]-1][0])**2 + (zoneCenters[zoneId[lastImsi]-1][1] - zoneCenters[zoneId[lastRecievedPackets[lastImsi][i][0]]-1][1])**2))
                        #if lastImsi == 234:
                        #    print('****************************************************************************************')
                        #    print(distFromRx)
                        #print('*')
                        if len(distFromRx) > 0:
                            tempEdge = 1
                            temp = 1
                            while temp > gamma:
                                edgeUe = [int(x >= (tempEdge*dZ)) for x in distFromRx]
                                temp = sum(edgeUe)/len(edgeUe)
                                if temp >= gamma:#this is >= rather than just > because in the last itteration if temp and gamma are exactly equal we dont want to subtract - in the next step, so we cancel it out here
                                    tempEdge += 1
                            #if lastImsi == 234:
                            #    print((tempEdge-1)*dZ)
                            currentDEdgeEstimate[lastImsi] = beta*((tempEdge-1)*dZ) + (1-beta)*currentDEdgeEstimate[lastImsi]
                            #if lastImsi == 234:
                            #    print(currentDEdgeEstimate[lastImsi])
                        else:
                            currentDEdgeEstimate[lastImsi] = currentDEdgeEstimate[lastImsi]
                        
                        if lastNumExclusions[lastImsi] > 0 and lastImsi == 75:
                            currentRhoUeEstimateCsv.append([data.env.time] + currentRhoUeEstimate)
                            currentDEdgeEstimateCsv.append([data.env.time] + currentDEdgeEstimate)
                            lastNumExclusionsCsv.append([data.env.time] + lastNumExclusions)
                            lastRsrpThresholdCsv.append([data.env.time] + lastRsrpThreshold)
                        #    with open('currentDEdgeEstimate.csv', 'a', newline='') as csvFile:
                        #        writer = csv.writer(csvFile,delimiter=',')
                        #        writer.writerow(temp1)
                        #    with open('currentRhoUeEstimate.csv', 'a', newline='') as csvFile:
                        #        writer = csv.writer(csvFile,delimiter=',')
                        #        writer.writerow(temp3)
                        L = []
                        #print('*')
                        R = []
                        for i in range(len(lastRecievedPackets[lastImsi])):
                            if distFromRx[i] >= currentDEdgeEstimate[lastImsi] and (zoneCenters[zoneId[lastImsi]-1][0] - zoneCenters[zoneId[lastRecievedPackets[lastImsi][i][0]]-1][0]) < 0:
                                L.append(lastRecievedPackets[lastImsi][i] + [distFromRx[i]])
                            if distFromRx[i] >= currentDEdgeEstimate[lastImsi] and (zoneCenters[zoneId[lastImsi]-1][0] - zoneCenters[zoneId[lastRecievedPackets[lastImsi][i][0]]-1][0]) > 0:
                                R.append(lastRecievedPackets[lastImsi][i] + [distFromRx[i]])
                        #if lastImsi == 234:
                        #    print(data.env.time)
                        #print(L)
                        #print(R)
                        #print('**')
                        print(currentRhoUeEstimate[lastImsi])
                        ########################################################
                        #getting selection mode
                        if currentRhoUeEstimate[lastImsi] <= .15:
                            if len(L) == 0 or len(R) == 0:
                                selectionMode = 2
                                settingsChoice = len(settingsChoicesRhoUEp1)-1
                            else:
                                for i in range(len(settingsChoicesRhoUEp1)):
                                    if i < len(settingsChoicesRhoUEp1)-2:#last row of the settings table is different
                                        lCounter = 0
                                        rCounter = 0
                                        lChoices = []
                                        rChoices = []
                                        finalChoices = []
                                        settingsChoice = -1
                                        for j in range(len(L)):
                                            if L[j][1] <=  settingsChoicesRhoUEp1[i][1]:
                                                lCounter += 1
                                                lChoices.append(L[j])
                                        for j in range(len(R)):
                                            if R[j][1] <=  settingsChoicesRhoUEp1[i][1]:
                                                rCounter += 1
                                                rChoices.append(R[j])
                                        if (settingsChoicesRhoUEp1[i][0] % 2) == 0:
                                            if lCounter >= settingsChoicesRhoUEp1[i][0]/2 and rCounter >= settingsChoicesRhoUEp1[i][0]/2:
                                                selectionMode = 1#placeholder, needs to be changed to 1 later
                                                settingsChoice = i
                                                sortedLChoices = Sort(lChoices,3)
                                                sortedRChoices = Sort(rChoices,3)
                                                sortedLChoices.reverse()
                                                sortedRChoices.reverse()
                                                OReCounter+=1
                                                #print("O-Re")
                                                break
                                        else:
                                            if lCounter >= (settingsChoicesRhoUEp1[i][0]-1)/2 and rCounter >= (settingsChoicesRhoUEp1[i][0]-1)/2:
                                                selectionMode = 1#placeholder, needs to be changed to 1 later
                                                settingsChoice = i
                                                sortedLChoices = Sort(lChoices,3)
                                                sortedRChoices = Sort(rChoices,3)
                                                sortedLChoices.reverse()
                                                sortedRChoices.reverse()
                                                OReCounter+=1
                                                #print("O-Re")
                                                break
                                    else:   
                                        selectionMode = 2#placeholder
                                        settingsChoice = i
                        elif currentRhoUeEstimate[lastImsi] > .15 and currentRhoUeEstimate[lastImsi] <= .3:
                            if len(L) == 0 or len(R) == 0:
                                selectionMode = 2
                                settingsChoice = len(settingsChoicesRhoUEp2)-1
                            else:
                                for i in range(len(settingsChoicesRhoUEp2)):
                                    #print(i)
                                    if i < len(settingsChoicesRhoUEp2)-2:#last row of the settings table is different
                                        lCounter = 0
                                        rCounter = 0
                                        lChoices = []
                                        rChoices = []
                                        finalChoices = []
                                        settingsChoice = -1
                                        for j in range(len(L)):
                                            if L[j][1] <=  settingsChoicesRhoUEp2[i][1]:
                                                lCounter += 1
                                                lChoices.append(L[j])
                                        for j in range(len(R)):
                                            if R[j][1] <=  settingsChoicesRhoUEp2[i][1]:
                                                rCounter += 1
                                                rChoices.append(R[j])
                                        if (settingsChoicesRhoUEp2[i][0] % 2) == 0:
                                            if lCounter >= settingsChoicesRhoUEp2[i][0]/2 and rCounter >= settingsChoicesRhoUEp2[i][0]/2:
                                                selectionMode = 1#placeholder, needs to be changed to 1 later
                                                settingsChoice = i
                                                sortedLChoices = Sort(lChoices,3)
                                                sortedRChoices = Sort(rChoices,3)
                                                sortedLChoices.reverse()
                                                sortedRChoices.reverse()
                                                OReCounter+=1
                                                #print("O-Re")
                                                break
                                        else:
                                            if lCounter >= (settingsChoicesRhoUEp2[i][0]-1)/2 and rCounter >= (settingsChoicesRhoUEp2[i][0]-1)/2:
                                                selectionMode = 1#placeholder, needs to be changed to 1 later
                                                settingsChoice = i
                                                sortedLChoices = Sort(lChoices,3)
                                                sortedRChoices = Sort(rChoices,3)
                                                sortedLChoices.reverse()
                                                sortedRChoices.reverse()
                                                OReCounter+=1
                                                #print("O-Re")
                                                break
                                    else:   
                                        selectionMode = 2#placeholder
                                        settingsChoice = i
                        elif currentRhoUeEstimate[lastImsi] > .3:
                            if len(L) == 0 or len(R) == 0:
                                selectionMode = 2
                                settingsChoice = len(settingsChoicesRhoUEp4)-1
                            else:
                                for i in range(len(settingsChoicesRhoUEp4)):
                                    if i < len(settingsChoicesRhoUEp4)-2:#last row of the settings table is different
                                        lCounter = 0
                                        rCounter = 0
                                        lChoices = []
                                        rChoices = []
                                        finalChoices = []
                                        settingsChoice = -1
                                        for j in range(len(L)):
                                            if L[j][1] <=  settingsChoicesRhoUEp4[i][1]:
                                                lCounter += 1
                                                lChoices.append(L[j])
                                        for j in range(len(R)):
                                            if R[j][1] <=  settingsChoicesRhoUEp4[i][1]:
                                                rCounter += 1
                                                rChoices.append(R[j])
                                        if (settingsChoicesRhoUEp4[i][0] % 2) == 0:
                                            if lCounter >= settingsChoicesRhoUEp4[i][0]/2 and rCounter >= settingsChoicesRhoUEp4[i][0]/2:
                                                selectionMode = 1#placeholder, needs to be changed to 1 later
                                                settingsChoice = i
                                                sortedLChoices = Sort(lChoices,3)
                                                sortedRChoices = Sort(rChoices,3)
                                                sortedLChoices.reverse()
                                                sortedRChoices.reverse()
                                                OReCounter+=1
                                                #print("O-Re")
                                                break
                                        else:
                                            if lCounter >= (settingsChoicesRhoUEp4[i][0]-1)/2 and rCounter >= (settingsChoicesRhoUEp4[i][0]-1)/2:
                                                selectionMode = 1#placeholder, needs to be changed to 1 later
                                                settingsChoice = i
                                                sortedLChoices = Sort(lChoices,3)
                                                sortedRChoices = Sort(rChoices,3)
                                                sortedLChoices.reverse()
                                                sortedRChoices.reverse()
                                                OReCounter+=1
                                                #print("O-Re")
                                                break
                                    else:   
                                        selectionMode = 2#placeholder
                                        settingsChoice = i
                        ########################################################
                        #print('*')
                        print(selectionMode)
                        
                        #getting parameters to send depending on selection mode
                        if selectionMode == 1:
                            print(sortedLChoices)
                            print(sortedRChoices)
                            if currentRhoUeEstimate[lastImsi] <= .15:
                                temp = str(selectionMode) + str(int(settingsChoicesRhoUEp1[int(settingsChoice)][0]))
                                currentNSe[lastImsi] = int(settingsChoicesRhoUEp1[len(settingsChoicesRhoUEp1)-1][2])
                                #print('*')
                                #print(settingsChoicesRhoUEp1[int(settingsChoice)][0])
                                #print(type(settingsChoicesRhoUEp1[int(settingsChoice)][0]))
                                for i in range(int(settingsChoicesRhoUEp1[int(settingsChoice)][0]) - int(settingsChoicesRhoUEp1[int(settingsChoice)][0]) % 2):
                                    if i % 2 == 0:
                                        #print('**')
                                        if sortedLChoices[int(i/2)][2] > int(int(round(data.env.time))%100):
                                            chosenSlot = int(sortedLChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        else:
                                            chosenSlot = int(100 + sortedLChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots

                                        chosenSubChannel = int(sortedLChoices[int(i/2)][3])

                                        if chosenSlot > 9:
                                            temp = temp + str(chosenSlot) + str(chosenSubChannel)
                                        else:#zeros padding to keep size consisant
                                            temp = temp + str(0) + str(chosenSlot) + str(chosenSubChannel)
                                    else:
                                        #print('***')
                                        if sortedRChoices[int(i/2)][2] > int(int(round(data.env.time))%100):
                                            chosenSlot = int(sortedRChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        else:
                                            chosenSlot = int(100 + sortedRChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        
                                        chosenSubChannel = int(sortedRChoices[int((i-1)/2)][3])
                                        if chosenSlot > 9:
                                            temp = temp + str(chosenSlot) + str(chosenSubChannel)
                                        else:#zeros padding to keep size consisant
                                            temp = temp + str(0) + str(chosenSlot) + str(chosenSubChannel)
                            elif currentRhoUeEstimate[lastImsi] > .15 and currentRhoUeEstimate[lastImsi] <= .3:
                                #print('*')
                                temp = str(selectionMode) + str(int(settingsChoicesRhoUEp2[int(settingsChoice)][0]))
                                currentNSe[lastImsi] = int(settingsChoicesRhoUEp2[len(settingsChoicesRhoUEp2)-1][2])
                                for i in range(int(settingsChoicesRhoUEp2[int(settingsChoice)][0]) - int(settingsChoicesRhoUEp2[int(settingsChoice)][0]) % 2):
                                    if i % 2 == 0:
                                        #print('**')
                                        if sortedLChoices[int(i/2)][2] > int(int(round(data.env.time))%100):
                                            chosenSlot = int(sortedLChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        else:
                                            chosenSlot = int(100 + sortedLChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        chosenSubChannel = int(sortedLChoices[int(i/2)][3])
                                        if chosenSlot > 9:
                                            temp = temp + str(chosenSlot) + str(chosenSubChannel)
                                        else:#zeros padding to keep size consisant
                                            temp = temp + str(0) + str(chosenSlot) + str(chosenSubChannel)
                                    else:
                                        #print('***')
                                        if sortedRChoices[int(i/2)][2] > int(int(round(data.env.time))%100):
                                            chosenSlot = int(sortedRChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        else:
                                            chosenSlot = int(100 + sortedRChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        chosenSubChannel = int(sortedRChoices[int((i-1)/2)][3])
                                        if chosenSlot > 9:
                                            temp = temp + str(chosenSlot) + str(chosenSubChannel)
                                        else:#zeros padding to keep size consisant
                                            temp = temp + str(0) + str(chosenSlot) + str(chosenSubChannel)
                            elif currentRhoUeEstimate[lastImsi] > .3:
                                #print('*')
                                temp = str(selectionMode) + str(int(settingsChoicesRhoUEp4[int(settingsChoice)][0]))
                                currentNSe[lastImsi] = int(settingsChoicesRhoUEp4[len(settingsChoicesRhoUEp4)-1][2])
                                for i in range(int(settingsChoicesRhoUEp4[int(settingsChoice)][0]) - int(settingsChoicesRhoUEp4[int(settingsChoice)][0]) % 2):
                                    if i % 2 == 0:
                                        #print('**')
                                        if sortedLChoices[int(i/2)][2] > int(int(round(data.env.time))%100):
                                            chosenSlot = int(sortedLChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        else:
                                            chosenSlot = int(100 + sortedLChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        chosenSubChannel = int(sortedLChoices[int(i/2)][3])
                                        if chosenSlot > 9:
                                            temp = temp + str(chosenSlot) + str(chosenSubChannel)
                                        else:#zeros padding to keep size consisant
                                            temp = temp + str(0) + str(chosenSlot) + str(chosenSubChannel)
                                    else:
                                        #print('***')
                                        if sortedRChoices[int(i/2)][2] > int(int(round(data.env.time))%100):
                                            chosenSlot = int(sortedRChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        else:
                                            chosenSlot = int(100 + sortedRChoices[int(i/2)][2] - (int(int(round(data.env.time))%100)) - t1)#the selection window begins after t1 slots
                                        chosenSubChannel = int(sortedRChoices[int((i-1)/2)][3])
                                        if chosenSlot > 9:
                                            temp = temp + str(chosenSlot) + str(chosenSubChannel)
                                        else:#zeros padding to keep size consisant
                                            temp = temp + str(0) + str(chosenSlot) + str(chosenSubChannel)
                            print("apple")
                            data.act.encodedSelectionInstructions = float(temp)
                            with open('../../encodedSelectionInstructions.txt', 'w') as file:
                                file.write(temp)

                        elif selectionMode == 2:
                            if currentRhoUeEstimate[lastImsi] <= .15:
                                NSe = int(settingsChoicesRhoUEp1[int(settingsChoice)][2])
                                currentNSe[lastImsi] = NSe
                            elif currentRhoUeEstimate[lastImsi] > .15 and currentRhoUeEstimate[lastImsi] <= .3:
                                NSe = int(settingsChoicesRhoUEp2[int(settingsChoice)][2])
                                currentNSe[lastImsi] = NSe
                            elif currentRhoUeEstimate[lastImsi] > .3:
                                NSe = int(settingsChoicesRhoUEp4[int(settingsChoice)][2])
                                currentNSe[lastImsi] = NSe
                            print("banana")
                            data.act.encodedSelectionInstructions = float(str(selectionMode) + str(NSe))
                            with open('../../encodedSelectionInstructions.txt', 'w') as file:
                                file.write(str(selectionMode) + str(NSe))

                    else:#this condition is only triggered in the first few miliseconds, after the initial selection and before any reselection happen. It will be overwritten by the first reselection.
                        print("pear")
                        #print(float(str(2) + str(1)))
                        data.act.encodedSelectionInstructions = float(str(2) + str(1))
                        with open('../../encodedSelectionInstructions.txt', 'w') as file:
                                file.write(str(2) + str(1))
                
        pro.wait()                                              # Wait the ns-3 to stop
except Exception as e:
    print('Something wrong')
    print(e)
finally:
    print(lastNumExclusions)
    print(lastRsrpThreshold)
    print(currentRhoUeEstimate)
    print(currentNSe)
    print(selectionModeSelectionCounter)
    print(OReCounter)
    with open('currentDEdgeEstimate.csv', 'a', newline='') as csvFile:
        writer = csv.writer(csvFile,delimiter=',')
        writer.writerows(currentDEdgeEstimateCsv)
    with open('currentRhoUeEstimate.csv', 'a', newline='') as csvFile:
        writer = csv.writer(csvFile,delimiter=',')
        writer.writerows(currentRhoUeEstimateCsv)
    with open('lastNumExclusions.csv', 'a', newline='') as csvFile:
        writer = csv.writer(csvFile,delimiter=',')
        writer.writerows(lastNumExclusionsCsv)
    with open('lastRsrpThreshold.csv', 'a', newline='') as csvFile:
        writer = csv.writer(csvFile,delimiter=',')
        writer.writerows(lastRsrpThresholdCsv)
    del exp
