function dciLog = func_cutDciLog2Time(dciLog, TTI_IDX, TIME_LEN_MS)
% we cut the dci to log within a period

tti = dciLog(:,TTI_IDX);
idx = tti > TIME_LEN_MS;
dciLog(idx,:) = [];
end