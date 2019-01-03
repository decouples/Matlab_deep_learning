function fileList = getAllFiles(foldername)
folderData = dir(foldername);      
folderIndex = [folderData.isdir];  
fileList = {folderData(~folderIndex).name}'; 
if ~isempty(fileList)
    fileList = cellfun(@(x) fullfile(foldername,x),...  
        fileList,'UniformOutput',false);
end
subfolders = {folderData(folderIndex).name};  
errIndex = ~ismember(subfolders,{'.','..'});  
for iDir = find(errIndex)                 
    nextDir = fullfile(foldername,subfolders{iDir});   
    fileList = [fileList; getAllFiles(nextDir)];  
end