#pragma once
#include "ns3/ns3-ai-rl.h"


namespace ns3 {

struct OREInput
{
	int imsi;
	double time;
	int occupiedResources;
	int rsrpThreshold;
	int srcRnti;
	int Rc;
	int srcSlotNum;
	int srcScNum;
	int index;
	int estimatorUpdateFlag;
	int addRecievedPacketFlag;
	int selectionModeSelectionFlag;
	int getNumResourcesSelectedFlag;
	int getChosenSlotFlag;
	int getChosenSubChannelFlag;
	int NSeQueryFlag;
	int firstCallFlag;
	double encodedSrcRnti;
	double encodedRc;
	double encodedSrcSlot;
	double encodedSrcSc;
	int sensningDataFlag;
}Packed;

struct OREOutput
{
	int selectionMode;
	int NSe;
	int numResourcesSelected;
	int chosenSlot;
	int chosenSubChannel;
	double encodedSelectionInstructions;
}Packed;

class OREENV : public Ns3AIRL<OREInput, OREOutput>
{
	public:
		OREENV (void) = delete;
		OREENV (uint16_t id);
		void estimatorUpdate(int imsi, double time, int rsrpThreshold, int occupiedResources, int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag);//called during sensing to update \hat{\rho}_{UE} and d_{edge}
		void addRecievedPacket(int srcRnti,int Rc,int srcSlotNum,int srcScNum, int firstCallFlag, int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag);
		int selectionModeSelection(int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag);
		int NSeQuery(int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag);
		int getNumResourcesSelected(int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag);
		int getChosenSlot(int index, int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag);
		int getChosenSubChannel(int index, int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag);
		void passSensingData(int imsi, double time, int rsrpThreshold, int occupiedResources, double encodedSrcRnti, double encodedRc, double encodedSrcSlot, double encodedSrcSc, int sensningDataFlag);
		double getResourceSelections(int sensningDataFlag);
};
}// namespace ns3

