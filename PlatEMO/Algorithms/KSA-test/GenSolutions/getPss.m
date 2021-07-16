function [pss,rePe,Ps] = getPss(offSpring)
%% 1. normalization
PopObjs = offSpring;
[N,M] = size(PopObjs);
PopObjs = (PopObjs-repmat(min(PopObjs,[],1),N,1))./repmat((max(PopObjs,[],1)-min(PopObjs,[],1)),N,1); 
%% 2. construct hyperplane
K = -ones(1,M-1)/M;
H = [eye(M-1)-1./M;K];
Pe = H*inv(H'*H)*H';
Ps = PopObjs*Pe';

%% 3. normalize
pss = (Ps-repmat(min(Ps,[],1),N,1))./repmat((max(Ps,[],1)-min(Ps,[],1)),N,1);
rePe = Pe';
end