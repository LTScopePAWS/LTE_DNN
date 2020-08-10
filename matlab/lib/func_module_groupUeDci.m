function [dl_prb_m, dl_tbs_m, nof_ue] = func_module_groupUeDci(fileName, dciLogCfg, extCfg)
dl_prb_m    = [];
dl_tbs_m    = [];
dci_log         = load(fileName);
if(isempty(dci_log))
   return; 
end
% Unwrap TTI so that the tti increase linearly
dci_log         = func_dci_unwrapTTI(dci_log, dciLogCfg.TTI_IDX);

% Cut the dci log so that all the dci is within the range 
dci_log = func_cutDciLog2Time(dci_log, dciLogCfg.TTI_IDX, extCfg.TIME_LEN_MS);

% Counting the frequency of appearing RNTI 
tbl_dl = func_countRntiFreq(dci_log, dciLogCfg.RNTI_IDX);

%% looking at each rnti
[len1, ~] = size(tbl_dl);
nof_ue  = 0;
for rnti_index = 1:1:len1
    
    rnti_v          = tbl_dl(rnti_index,1);      % the rnti value
    rnti_freq_raw   = tbl_dl(rnti_index,2);      % the raw appearing frequency of rnti 

    % Extract the dci log of this specific UE
    dci_rnti        = func_extract_dci_wRNTI(dci_log, rnti_v, dciLogCfg.RNTI_IDX);
    data_kb_raw     = sum(dci_rnti(:,dciLogCfg.TBS_IDX)) ./ 10^3;
    if(length(data_kb_raw) > 1)
        error('The data sum of one UE cannot be a vector!');
    end
    if(data_kb_raw < extCfg.ueFilterRawDataKb)
        break
    end
    nof_ue  = nof_ue + 1;
    
    if(extCfg.extractDciFlag == 1)
        dl_prb_vec      = zeros(1, extCfg.TIME_LEN_MS);
        dl_tbs_vec      = zeros(1, extCfg.TIME_LEN_MS);

        if(extCfg.cleanControlTrafficFlag == 1)
            % Clean the control traffic 
            dci_rnti_clean  = func_cleanControlTraffic(dci_rnti, dciLogCfg.UE_PRB_IDX);
            rnti_freq_clean = length(dci_rnti_clean(:,dciLogCfg.TBS_IDX));
            data_kb_clean   = sum(dci_rnti_clean(:,dciLogCfg.TBS_IDX)) ./ 10^3;

            % Extract the trace         
            dl_prb_vec(1, dci_rnti_clean(:,dciLogCfg.TTI_IDX))  = dci_rnti_clean(:, dciLogCfg.UE_PRB_IDX);
            dl_tbs_vec(1, dci_rnti_clean(:,dciLogCfg.TTI_IDX))  = dci_rnti_clean(:, dciLogCfg.TBS_IDX);
        else
            dl_prb_vec(1, dci_rnti(:,dciLogCfg.TTI_IDX))  = dci_rnti(:, dciLogCfg.UE_PRB_IDX);
            dl_tbs_vec(1, dci_rnti(:,dciLogCfg.TTI_IDX))        = dci_rnti(:, dciLogCfg.TBS_IDX);
        end            
        dl_prb_m        = cat(1, dl_prb_m, dl_prb_vec);               
        dl_tbs_m        = cat(1, dl_tbs_m, dl_tbs_vec);        
    end
end

end