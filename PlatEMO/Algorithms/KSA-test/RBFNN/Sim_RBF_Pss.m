function [S_Decs] = Sim_RBF_Pss(Pss,net)
%% use the RBFNN to predict the decision variables (S_Decs) of the solutions (S_Objs)   
    %% Prediction using the RBFNN (net)
    S_Decs = sim(net,Pss');
    %% transpose the predicted Decs
    S_Decs = S_Decs';
end