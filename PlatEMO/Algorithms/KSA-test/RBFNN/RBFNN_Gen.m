function [net,Pe,Ps] = RBFNN_Gen(Population)
%% refer to  Giagkiozis I, Fleming P J. Increasing the density of available pareto optimal solutions[J]. 2012.
    %% get the Decs and Objs 
    PopDecs =  Population.decs;  
    PopObjs =  Population.objs; 
    %% Mapping the objectives into a hyperplane
    %% 1. normalization
    [N,M] = size(PopObjs);
    PopObjs = (PopObjs-repmat(min(PopObjs,[],1),N,1))./repmat((max(PopObjs,[],1)-min(PopObjs,[],1)),N,1); 
    %% 2. construct hyperplane
    K = -ones(1,M-1)/M;
    H = [eye(M-1)-1./M;K];
    Pe = H*inv(H'*H)*H';
    Ps = PopObjs*Pe';
    %% normalize
    Pss = (Ps-repmat(min(Ps,[],1),N,1))./repmat((max(Ps,[],1)-min(Ps,[],1)),N,1);
%      Pss = (Ps-repmat(min(Ps,[],1),N,1));
    %% 3. construct the RBFNN
    %% the format of the input needs to be transposed
%     figure('visible','off');
    hold on;
    net = Newrb2(Pss',PopDecs'); %% RBFNN  Pss' is the input, and PopDec' is the target
end