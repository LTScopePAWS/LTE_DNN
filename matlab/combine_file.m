% Call functions from all subfolders
addpath(genpath(pwd));


folder      = '../trace/cell_739';
fileName    = func_getFileName(folder);

out     = 0;
count   = 0;
for i=1:1:floor(length(fileName)/10)
    dci_all = [];
    for j = 1:1:10
        if((i-1)*10 + j > length(fileName))
            out = 1;
            break;
        end
        dci     = load(fileName{1,(i-1)*10 + j});
        dci_all = cat(1, dci_all, dci);
    end
    
    if(out == 1)
        break;
    end
    count   = count + 1;
    saveFile = [foadi lder,'dciLog_',num2str(count),'dciLog'];
    save(saveFile,'dci_all');
end