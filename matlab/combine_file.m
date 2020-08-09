% Call functions from all subfolders
addpath(genpath(pwd));


folder      = '../trace';
fileName    = func_getFileName(folder);

out     = 0;
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
end