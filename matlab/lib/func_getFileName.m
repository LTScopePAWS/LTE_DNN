function fileName = func_getFileName(folder)
    dirOutput   = dir(fullfile(folder,'*.dciLog'));
    fileName    = {dirOutput.name};    
end