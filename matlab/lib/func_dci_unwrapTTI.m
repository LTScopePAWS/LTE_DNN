function dciLog = func_dci_unwrapTTI(dciLog, TTI_IDX)
% Unwarp the TTI so that the tti index increases monotonically
% The tti index is also forced to start with 1 

tti     = dciLog(:,TTI_IDX);
tti_dif = diff(tti);
idx = find(abs(tti_dif) > 9000);
for i=1:1:length(idx)
    dciLog(idx(i,1)+1:end,TTI_IDX) = dciLog(idx(i,1)+1:end,TTI_IDX) + 10240;
end

%let the tti start from 1
dciLog(:,TTI_IDX) = dciLog(:,TTI_IDX) - dciLog(1,TTI_IDX) + 1;
tti     = dciLog(:,TTI_IDX);
if(min(tti) <= 0)
    error('unwrapTTI: TTI index smaller than or equal to zero!');
end


end