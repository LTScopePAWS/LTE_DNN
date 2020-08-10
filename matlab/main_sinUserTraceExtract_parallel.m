clear;close all
% Call functions from all subfolders
addpath(genpath(pwd));

%%
TTI_IDX     = 1;        %Global parameter: index of the tti in the dci log
RNTI_IDX    = 2;        %Global parameter: index of the RNTI in the dci log
CELL_PRB_IDX= 4;
UE_PRB_IDX  = 5;
TBS_IDX     = 6;
dciLogCfg.TTI_IDX          = TTI_IDX;
dciLogCfg.RNTI_IDX         = RNTI_IDX;
dciLogCfg.CELL_PRB_IDX     = CELL_PRB_IDX;
dciLogCfg.UE_PRB_IDX       = UE_PRB_IDX;
dciLogCfg.TBS_IDX          = TBS_IDX;

%%
TIME_LEN_S  = 600;                  %Global parameter: length of the logging period
TIME_LEN_MS = TIME_LEN_S * 1000;    %Global parameter: period in ms (subframes)
%Global parameter: we only keep the UE that has delivered raw data 
%with size larger than ueFilterDataKb within TIME_LEN_S seconds
ueFilterRawDataKb     = 2*10^3;     
cleanControlTrafficFlag     = 0;    % Do we perform control traffic clean?
extractDciFlag              = 1;    % Do we extract DCI and save it into matrix?                                    
                                    
folder          = '../trace/cell_1940';

extCfg.TIME_LEN_S       = TIME_LEN_S;
extCfg.TIME_LEN_MS      = TIME_LEN_MS;
extCfg.folder           = folder;
extCfg.ueFilterRawDataKb    = ueFilterRawDataKb;
extCfg.cleanControlTrafficFlag  = cleanControlTrafficFlag;
extCfg.extractDciFlag   = extractDciFlag;
%%

fileName_all    = func_getFileName(folder);
nof_ue_all      = 0;
% parfor i = 1:1:length(fileName_all)
parfor i = 1:1:10
    fileName                        = fullfile(folder,fileName_all{1,i});
    [dl_prb_m, dl_tbs_m, nof_ue]    = func_module_groupUeDci(fileName, dciLogCfg, extCfg);
    nof_ue_all  = nof_ue_all + nof_ue;
    saveFile    = ['../extractTrace/trace_idx_',num2str(i),'.mat'];
    func_parforSave(saveFile,dl_prb_m, dl_tbs_m, nof_ue);
end
% for i=1:1:4
%     plot(dl_prb_m(i,:));hold on
%     plot(dl_prb_m(i,:));hold on
% end



