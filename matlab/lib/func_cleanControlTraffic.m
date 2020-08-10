function dciLog = func_cleanControlTraffic(dciLog, UE_PRB_IDX)
% clean the control traffic of this UE

ue_dl_prb   = dciLog(:,UE_PRB_IDX);
idx     = ue_dl_prb == 4;
dciLog(idx,:) = [];

end