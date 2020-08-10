function tbl_dl = func_countRntiFreq(dciLog, RNTI_IDX)
% Count the frequency of every appearing RNTI

RNTI_dl_all     = dciLog(:,RNTI_IDX);  % Extract all UE RNTI
tbl_dl          = tabulate(RNTI_dl_all);    
index           = tbl_dl(:,2) == 0;         
tbl_dl(index,:) = [];
tbl_dl          = sortrows(tbl_dl,2,'descend'); 

end