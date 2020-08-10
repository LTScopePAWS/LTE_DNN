function dci_log_rnti = func_extract_dci_wRNTI(dci_log, rnti_v, RNTI_IDX)
index = dci_log(:,RNTI_IDX) == rnti_v;
dci_log_rnti = dci_log(index,:);
end