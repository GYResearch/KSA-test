function PopObj = EvolALG(Trans_obj,Objs,model,IFEs)
% Solution update in ParEGO, where a solution with the best expected
% improvement is re-evaluated

    Off   = [GA(Objs(TournamentSelection(2,size(Objs,1),Trans_obj),:));GA(Objs,{1,10,1,10})];
    N     = size(Off,1);
    EI    = zeros(N,1);
    Gbest = min(Trans_obj);
    E0    = inf;
    while IFEs > 0
        drawnow();
        for i = 1 : N
            [y,~,mse] = predictor(Off(i,:),model);
            s         = sqrt(mse);
%             EI(i)     = (Gbest-y)*normcdf((Gbest-y)/s)+s*normpdf((Gbest-y)/s); %% ExI
            EI(i)     = y-2*s;%% LCB
        end
        [~,index] = sort(EI,'descend'); %% descend / ascend
        if EI(index(1)) < E0
            Best = Off(index(1),:); 
            E0   = EI(index(1));
        end
        Parent = Off(index(1:ceil(N/2)),:);
        Off    = [GA(Parent(TournamentSelection(2,size(Parent,1),EI(index(1:ceil(N/2)))),:));GA(Parent,{0,0,1,20})];
        IFEs   = IFEs - size(Off,1);
    end
    PopObj = Best;
end