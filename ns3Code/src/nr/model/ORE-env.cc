#include "ORE-env.h"
#include <string>

namespace ns3 {

OREENV::OREENV (uint16_t id) : Ns3AIRL<OREInput, OREOutput> (id)
{
  SetCond (2, 0);
}

void 
OREENV::estimatorUpdate(int imsi, double time, int rsrpThreshold, int occupiedResources, int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag)
{
  auto OREInput = EnvSetterCond();
  OREInput->imsi = imsi;
  OREInput->time = time;
  OREInput->rsrpThreshold = rsrpThreshold;
  OREInput->occupiedResources = occupiedResources;

  OREInput->estimatorUpdateFlag = estimatorUpdateFlag;
  OREInput->addRecievedPacketFlag = addRecievedPacketFlag;
  OREInput->selectionModeSelectionFlag = selectionModeSelectionFlag;
  OREInput->NSeQueryFlag = NSeQueryFlag;
  OREInput->getNumResourcesSelectedFlag = getNumResourcesSelectedFlag;
  OREInput->getChosenSlotFlag = getChosenSlotFlag;
  OREInput->getChosenSubChannelFlag = getChosenSubChannelFlag;
  SetCompleted();
  
}

void 
OREENV::addRecievedPacket(int srcRnti,int Rc,int srcSlotNum,int srcScNum, int firstCallFlag, int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag)
{
  auto OREInput = EnvSetterCond();
  OREInput->srcRnti = srcRnti;
  OREInput->Rc = Rc;
  OREInput->srcSlotNum = srcSlotNum;
  OREInput->srcScNum = srcScNum;
  OREInput->firstCallFlag = firstCallFlag;
  OREInput->estimatorUpdateFlag = estimatorUpdateFlag;
  OREInput->addRecievedPacketFlag = addRecievedPacketFlag;
  OREInput->selectionModeSelectionFlag = selectionModeSelectionFlag;
  OREInput->NSeQueryFlag = NSeQueryFlag;
  OREInput->getNumResourcesSelectedFlag = getNumResourcesSelectedFlag;
  OREInput->getChosenSlotFlag = getChosenSlotFlag;
  OREInput->getChosenSubChannelFlag = getChosenSubChannelFlag;

  SetCompleted();
}

int 
OREENV::selectionModeSelection(int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag)
{
  auto OREInput = EnvSetterCond();
  OREInput->estimatorUpdateFlag = estimatorUpdateFlag;
  OREInput->addRecievedPacketFlag = addRecievedPacketFlag;
  OREInput->selectionModeSelectionFlag = selectionModeSelectionFlag;
  OREInput->NSeQueryFlag = NSeQueryFlag;
  OREInput->getNumResourcesSelectedFlag = getNumResourcesSelectedFlag;
  OREInput->getChosenSlotFlag = getChosenSlotFlag;
  OREInput->getChosenSubChannelFlag = getChosenSubChannelFlag;
  SetCompleted();

  auto OREOutput = ActionGetterCond();
  int ret = OREOutput->selectionMode;
  GetCompleted();

  return ret;
}

int 
OREENV::NSeQuery(int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag)
{
  auto OREInput = EnvSetterCond();
  OREInput->estimatorUpdateFlag = estimatorUpdateFlag;
  OREInput->addRecievedPacketFlag = addRecievedPacketFlag;
  OREInput->selectionModeSelectionFlag = selectionModeSelectionFlag;
  OREInput->NSeQueryFlag = NSeQueryFlag;
  OREInput->getNumResourcesSelectedFlag = getNumResourcesSelectedFlag;
  OREInput->getChosenSlotFlag = getChosenSlotFlag;
  OREInput->getChosenSubChannelFlag = getChosenSubChannelFlag;
  SetCompleted();

  auto OREOutput = ActionGetterCond();
  int ret = OREOutput->NSe;
  GetCompleted();

  return ret;
}

int 
OREENV::getNumResourcesSelected(int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag)
{
  auto OREInput = EnvSetterCond();
  OREInput->estimatorUpdateFlag = estimatorUpdateFlag;
  OREInput->addRecievedPacketFlag = addRecievedPacketFlag;
  OREInput->selectionModeSelectionFlag = selectionModeSelectionFlag;
  OREInput->NSeQueryFlag = NSeQueryFlag;
  OREInput->getNumResourcesSelectedFlag = getNumResourcesSelectedFlag;
  OREInput->getChosenSlotFlag = getChosenSlotFlag;
  OREInput->getChosenSubChannelFlag = getChosenSubChannelFlag;
  SetCompleted();

  auto OREOutput = ActionGetterCond();
  int ret = OREOutput->numResourcesSelected;
  GetCompleted();

  return ret;
}

int 
OREENV::getChosenSlot(int index, int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag)
{
  auto OREInput = EnvSetterCond();
  OREInput->index = index;
  OREInput->estimatorUpdateFlag = estimatorUpdateFlag;
  OREInput->addRecievedPacketFlag = addRecievedPacketFlag;
  OREInput->selectionModeSelectionFlag = selectionModeSelectionFlag;
  OREInput->NSeQueryFlag = NSeQueryFlag;
  OREInput->getNumResourcesSelectedFlag = getNumResourcesSelectedFlag;
  OREInput->getChosenSlotFlag = getChosenSlotFlag;
  OREInput->getChosenSubChannelFlag = getChosenSubChannelFlag;
  SetCompleted();

  auto OREOutput = ActionGetterCond();
  int ret = OREOutput->chosenSlot;
  GetCompleted();

  return ret;
}

int 
OREENV::getChosenSubChannel(int index, int estimatorUpdateFlag, int addRecievedPacketFlag, int selectionModeSelectionFlag, int NSeQueryFlag, int getNumResourcesSelectedFlag, int getChosenSlotFlag, int getChosenSubChannelFlag)
{
  auto OREInput = EnvSetterCond();
  OREInput->index = index;
  OREInput->estimatorUpdateFlag = estimatorUpdateFlag;
  OREInput->addRecievedPacketFlag = addRecievedPacketFlag;
  OREInput->selectionModeSelectionFlag = selectionModeSelectionFlag;
  OREInput->NSeQueryFlag = NSeQueryFlag;
  OREInput->getNumResourcesSelectedFlag = getNumResourcesSelectedFlag;
  OREInput->getChosenSlotFlag = getChosenSlotFlag;
  OREInput->getChosenSubChannelFlag = getChosenSubChannelFlag;
  SetCompleted();

  auto OREOutput = ActionGetterCond();
  int ret = OREOutput->chosenSubChannel;
  GetCompleted();

  return ret;
}

void
OREENV::passSensingData(int imsi, double time, int rsrpThreshold, int occupiedResources, double encodedSrcRnti, double encodedRc, double encodedSrcSlot, double encodedSrcSc, int sensningDataFlag)
{
  auto OREInput = EnvSetterCond();
  OREInput->imsi = imsi;
  OREInput->time = time;
  OREInput->rsrpThreshold = rsrpThreshold;
  OREInput->occupiedResources = occupiedResources;
  OREInput->encodedSrcRnti = encodedSrcRnti;
  OREInput->encodedRc = encodedRc;
  OREInput->encodedSrcSlot = encodedSrcSlot;
  OREInput->encodedSrcSc = encodedSrcSc;
  OREInput->sensningDataFlag = sensningDataFlag;
  SetCompleted();
}

double
OREENV::getResourceSelections(int sensningDataFlag)
{
  auto OREInput = EnvSetterCond();
  OREInput->sensningDataFlag = sensningDataFlag;
  SetCompleted();

  auto OREOutput = ActionGetterCond();
  int ret = OREOutput->encodedSelectionInstructions;
  GetCompleted();

  return ret;
}





}// namespace ns3



















