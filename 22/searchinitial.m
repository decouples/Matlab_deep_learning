function C = searchinitial(X,method,varargin)
%搜索样本空间初始据类中心
%X 样本空间； method: 搜索方法；varargin: 其他参数
switch lower(method(1))
    case 's' %sample
        K = varargin{1};
        C = X(randsample(size(X,1),K),:);
    case 'u' %uinform
        Xmins=min(X,[],1);
        Xmaxs=max(X,[],1);
        K=varargin{1};
        C = unifrnd(Xmins(ones(K,1),:),Xmaxs(ones(K,1),:));
end
