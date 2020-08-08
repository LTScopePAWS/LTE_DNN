function fileName = func_getFileName(folder)
    dirOutput   = dir(fullfile(folder,'*.csiLog'));
    fileName    = {dirOutput.name};    
end