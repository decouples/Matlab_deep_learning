function Construct_PCA_DataBase()
if exist(fullfile(pwd, '人脸库/model.mat'), 'file')
    return;
end
classNum = 40;
sampleNum = 10;
hw = waitbar(0, '构建PCA数据库进度：', 'Name', 'PCA人脸识别');
rt = 0.1;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt*100)));
allsamples = Get_Samples(classNum, sampleNum);
rt = 0.3;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt*100)));
samplemean = mean(allsamples);
xmean = Get_StandSample(allsamples, samplemean);
rt = 0.5;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt*100)));
sigma = xmean*xmean'; 
[v, d] = eig(sigma);
d1 = diag(d);
rt = 0.7;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt*100)));
dsort = flipud(d1);
vsort = fliplr(v);
p = classNum*sampleNum;
base = xmean' * vsort(:,1:p) * diag(dsort(1:p).^(-1/2));
rt = 0.9;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt*100)));
save(fullfile(pwd, '人脸库/model.mat'), 'base', 'samplemean');
rt = 1;
waitbar(rt, hw, sprintf('构建PCA数据库进度：%i%%', round(rt*100)));
delete(hw);
msgbox('构建PCA数据库完成！', '提示信息', 'Modal');