function fileList = GetAllFiles(dirName)

dirData = dir(dirName);    
dirIndex = [dirData.isdir]; 
fileList = {dirData(~dirIndex).name}'; 
if ~isempty(fileList)
    fileList = cellfun(@(x) fullfile(dirName,x),... 
        fileList,'UniformOutput',false);
end
subDirs = {dirData(dirIndex).name}; 
validIndex = ~ismember(subDirs,{'.','..'}); 
for iDir = find(validIndex)              
    nextDir = fullfile(dirName,subDirs{iDir});   
    fileList = [fileList; GetAllFiles(nextDir)];
end

end