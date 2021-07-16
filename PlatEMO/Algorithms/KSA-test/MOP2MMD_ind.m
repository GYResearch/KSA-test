function [f_mmd] = MOP2MMD_ind(ind_obj,all_objs)
    % normalization
    [N,~]  = size(all_objs);
    all_objs = (all_objs-repmat(min(all_objs,[],1),N,1))./repmat((max(all_objs,[],1)-min(all_objs,[],1)),N,1); 
    % normalize the individual
    ind_obj = (ind_obj - min(all_objs,[],1))./(max(all_objs,[],1)-min(all_objs,[],1));
    
    [N,M] = size(all_objs);
    PopObj =all_objs;
    Distance   = zeros(1,N);
    Current    = [1:N];
     % Find the extreme points
    [~,Rank]   = sort(PopObj,'descend');
    Extreme    = zeros(1,M);
    Extreme(1) = Rank(1,1);
    for j = 2 : length(Extreme)
        k = 1;
        Extreme(j) = Rank(k,j);
        while ismember(Extreme(j),Extreme(1:j-1))
              k = k+1;
              Extreme(j) = Rank(k,j);
        end
     end
      % Calculate the hyperplane
       Hyperplane = PopObj(Current(Extreme),:)\ones(length(Extreme),1);
      % Calculate the distance of each solution to the hyperplane
       Distance = -(ind_obj*Hyperplane-1)./sqrt(sum(Hyperplane.^2));
       f_mmd =  -Distance; %% using the distance as the multimodal function,becasue the maximum is the knee. 
end