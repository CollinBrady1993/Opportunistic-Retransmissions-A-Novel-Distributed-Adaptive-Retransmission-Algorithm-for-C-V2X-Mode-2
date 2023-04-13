# Opportunistic-Retransmissions-A-Novel-Distributed-Adaptive-Retransmission-Algorithm-for-C-V2X-Mode-2
This repository contains code, both ns-3 code used to generate data and matlab code to process it, used in, "Opportunistic Retransmissions: A Novel Distributed Adaptive Retransmission Algorithm for C-V2X Mode 2" by Collin Brady and Sumit Roy


The code is split into two parts; the ns-3 code used to generate simulation data, and the matlab code which processes the data and generates theoretical curves.

**NS-3 Code**

To generate simulation data first follow the instalation instructions for ns-3 in the readme in ns3Code. Additionally ns3-ai must be installed by following the instruction at https://github.com/hust-diangroup/ns3-ai.

Once ns-3 is installed the scripts used to generate data are found in three places:

  1) The script to genereate PRR/Throughput curves of standards complient NR C-V2X is found in ns3Code/src/nr/examples/nr-v2x-examples/nr-v2x-west-to-east-highway-Standards.cc. This script can be run from /ns3Code/ with the command ./waf --run nr-v2x-west-to-east-highway-Standards after building with examples. 

This same basic script is used (with slight alterations) for all types of data (standards, D-Re and O-Re) so I will provide a brief summary of the variables in ns-3 which control certain parameters used in the paper:

\rho_{UE} = 1/interVehicleDist
N_{Se} = slMaxTxTransNumPssch
T_1 = t1
T_2 = t2
T_{RRI} = reservationPeriod
P_t = txPower
\gamma_{FTR} = slThresPsschRsrp

Running this script produces the following output files (these will be created in /ns3Code/): 
    1) default-nr-v2x-west-to-east-highway.db, This file contains all transmitted and recieved packets, both PSCCH and PSSCH, and all information regarding them. There is a large amount of data stored in this file and the primary job of the matlab data processing is to handle this.
    2) eliminatedResources.csv, This file contains a record how many resources were eliminated during each reselection event.
    3) rsrpThreshold.csv, this file contains a record of the RSRP threshold for each UE during each reselection event. Note: this value is equal to slThresPsschRsrp is no threshold increase occurs. To compute the threshold increase you must take these values and subtract slThresPsschRsrp.

  2) The scripts to generate PRR/Throughput curves for the D-Re algorithm are found in ns3Code/scratch/D-Re_experiments/. this script can be run using the command python run.py from ns3Code/scratch/D-Re_experiments/.

The parameter \alpha is controlled from the run.py script found in ns3Code/scratch/D-Re_experiments/

Running this script produces the following output files (these will be created in /ns3Code/): 
    1) default-nr-v2x-west-to-east-highway.db, This file contains all transmitted and recieved packets, both PSCCH and PSSCH, and all information regarding them. There is a large amount of data stored in this file and the primary job of the matlab data processing is to handle this.
    2) eliminatedResources.csv, This file contains a record how many resources were eliminated during each reselection event.
    3) rsrpThreshold.csv, this file contains a record of the RSRP threshold for each UE during each reselection event. Note: this value is equal to slThresPsschRsrp is no threshold increase occurs. To compute the threshold increase you must take these values and subtract slThresPsschRsrp.
    4) currentRhoUeEstimate.csv, This file contains a time-stamped record of the current \rho_{UE} estimate. the leftmost column of each row is the time in ms, while the subsequent columns are the \rho_{UE} estimates at that time.

  3) The scripts to generate PRR/Throughput curves for the O-Re algorithm are found in ns3Code/scratch/O-Re_experiments/. this script can be run using the command python run.py from ns3Code/scratch/O-Re_experiments/.

The parameters \alpha, \beta, and \gamma are controlled from the run.py script found in ns3Code/scratch/O-Re_experiments/

Running this script produces the following output files (these will be created in /ns3Code/): 
    1) default-nr-v2x-west-to-east-highway.db, This file contains all transmitted and recieved packets, both PSCCH and PSSCH, and all information regarding them. There is a large amount of data stored in this file and the primary job of the matlab data processing is to handle this.
    2) eliminatedResources.csv, This file contains a record how many resources were eliminated during each reselection event.
    3) rsrpThreshold.csv, this file contains a record of the RSRP threshold for each UE during each reselection event. Note: this value is equal to slThresPsschRsrp is no threshold increase occurs. To compute the threshold increase you must take these values and subtract slThresPsschRsrp.
    4) currentRhoUeEstimate.csv, This file contains a time-stamped record of the current \rho_{UE} estimate. The leftmost column of each row is the time in ms, while columns i is the \rho_{UE} estimate for UE i-1.
    5) currentDEdgeEstimate.csv, This file contains a time-stamped record of the current \d_{edge} estimate. The leftmost column of each row is the time in ms, while columns i is the \d_{edge} estimate for UE i-1.


**Matlab Code**

The results folder contained in /MatlabCode/ contains the curves nescesary to create the figures contained in the paper. Unfortunately sharing the raw data files is imposible as they get up to GBs.

/MatlabCode/ contains the following key scripts (along with others which support these):

  1) ns3DataAnalysis.m, This file is used to process the default-nr-v2x-west-to-east-highway.db files generated by ns-3. The conn variable must be set to the path of the .db file you wish to process and the variables above, (numLanes; laneSeparation, numUe, speed, RRI, rho) must be set identically to the ns-3 simulation under analysis. 
  2) computeOReCurves.m, This file computes both the standards based PRR curves along with the theoretical ORe curves for a specified T_{RRI}, T_1, T_2, \rho_{UE}, and N_{Rc}. If you wish to compute a specific one off PRR use prrBlindCalcFunc.m or prrBlindCalcFunc_NoComposition.m. prrBlindCalcFunc_NoComposition.m is identical to prrBlindCalcFunc.m except at the very end the PRR does not include gains from N_{Se}.
  3) threshElimProcessing.m, This file is used to generate the NEx+gammaX2rhoUE,NSe(1,2,3,4),T2T132,RRI100.csv files in ns3Code/scratch/D-Re_experiments/ and ns3Code/scratch/O-Re_experiments/. The locations of the curves is defaulted to the results folder. If you wish to generate your own curves to replace these you must replace the file locations accordingly.
  4) DRE_figs.m/ORE_figs.m/SectionVFigs.m, These scripts are used to generate the figures in Opportunistic-Retransmissions-A-Novel-Distributed-Adaptive-Retransmission-Algorithm-for-C-V2X-Mode-2. The locations of the curves is defaulted to the results folder. If you wish to generate your own curves to replace these you must replace the file locations accordingly.









