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
dV = 5
dL = 4
uePos = []
initialPos = [0,0]
for i in range(numLanes):
    for j in range(numUePerLane):
        uePos.append([initialPos[0]+dV*j, initialPos[1] + dL*i])

print(uePos)

alpha = 1
t1 = 2
t2 = 33

lastNumExclusions = [1000]*numUe
lastNumExclusionsCsv = []
lastRsrpThreshold = [0]*numUe
lastRsrpThresholdCsv = []
currentRhoUeEstimate = [.1]*numUe
currentRhoUeEstimateCsv = []
currentNSe = [1]*numUe

lastImsi = -1#this needs to be defined because at the very begining of the simulation selectionModeSelection is called before estimatoreUpdate. This isn't and isue because it gets quickly overwritten
#and affects nothing
ns3Settings = {'t1': t1, 't2': t2, 'slMaxTxTransNumPssch': 1, 'interVehicleDist': dV, 'outputDir': '/home/collin/workspace/nr-sidelink/'}
mempool_key = 1234                                          # memory pool key, arbitrary integer large than 1000
mem_size = 4096                                             # memory pool size in bytes
memblock_key = 2333                                         # memory block key, need to keep the same in the ns-3 script
exp = Experiment(mempool_key, mem_size, 'D-Re_experiments', '../../')      # Set up the ns-3 environment
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
                if data.env.sensningDataFlag == 1:
                    lastImsi = data.env.imsi-1-math.floor(data.env.imsi/256)#this is saved because the functions are called in sequence and NrSlUeMacSchedulerSimple does not have access to imsi. any calls made by NrSlUeMacSchedulerSimple will be related to this imsi though
                    lastNumExclusions[lastImsi] = data.env.occupiedResources
                    lastRsrpThreshold[lastImsi] = data.env.rsrpThreshold + 110 - 3
                else:
                    if lastImsi > -1:#in the first few milliseconds this can be called before any packets are recieved, it doesnt do anything so we just give it dummy values
                        print("selectionModeSelectionFlag")
                        print(data.env.time)

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

                        ########################################################
                        #recording data
                        if lastNumExclusions[lastImsi] > 0 and lastImsi == 75:
                            currentRhoUeEstimateCsv.append([data.env.time] + currentRhoUeEstimate)
                            lastNumExclusionsCsv.append([data.env.time] + lastNumExclusions)
                            lastRsrpThresholdCsv.append([data.env.time] + lastRsrpThreshold)
                        print(currentRhoUeEstimate[lastImsi])
                        
                        ########################################################
                        #setting new NSe
                        if currentRhoUeEstimate[lastImsi] <= .15:
                            NSe = int(settingsChoicesRhoUEp1[int(len(settingsChoicesRhoUEp1)-1)][2])
                            currentNSe[lastImsi] = NSe
                        elif currentRhoUeEstimate[lastImsi] > .15 and currentRhoUeEstimate[lastImsi] <= .3:
                            NSe = int(settingsChoicesRhoUEp2[int(len(settingsChoicesRhoUEp2)-1)][2])
                            currentNSe[lastImsi] = NSe
                        elif currentRhoUeEstimate[lastImsi] > .3:
                            NSe = int(settingsChoicesRhoUEp4[int(len(settingsChoicesRhoUEp4)-1)][2])
                            currentNSe[lastImsi] = NSe
                        data.act.encodedSelectionInstructions = float(str(2) + str(NSe))
                        with open('../../encodedSelectionInstructions.txt', 'w') as file:
                            file.write(str(2) + str(NSe))

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
    #print(selectionModeSelectionCounter)
    #print(OReCounter)
    #with open('currentDEdgeEstimate.csv', 'a', newline='') as csvFile:
    #    writer = csv.writer(csvFile,delimiter=',')
    #    writer.writerows(currentDEdgeEstimateCsv)
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
