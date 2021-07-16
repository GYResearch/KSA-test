function KSA_TEST(Global)
% <algorithm> <K>
% alpha ---   2 --- The parameter controlling the rate of change of penalty
% fr    --- 0.1 --- The frequency of employing reference vector adaptation
% PreRuns --- 200 --- Max-generations for PreRuns of NSGA-II
% Max_ReEvas --- 25 --- the maximum real re-evaluation in the modeling  training. //100
% runs --- 20 --- 20 independent runs
%--------------------------------------------------------------------------
    %% Parameter setting
    [alpha,fr,PreRuns,Max_ReEvas,runs] = Global.ParameterSet(2,0.1,200,100,20);
    Population    = Global.Initialization();

    %% Optimization
    while Global.NotTermination(Population)
       fprintf('PreRuns of MOEA = %d generations\n',PreRuns);  
       for run =1:runs
       index = -1;
       %%%%%%%%%%%%%%%%%%%%%% Preparations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [V0,Global.N] = UniformPoint(Global.N,Global.M);
        Population    = Global.Initialization();
        V             = V0;
        ReEva_count   = 0;
        ReEva_count2  = 0;
        count         = 0;
        eta           = 0.2; %% initialize eta in peak detection
        %% parameters in kriging model
        theta         = 10.*ones(1,Global.M);       
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       while count<PreRuns % run PreRuns to get pop
            MatingPool = randi(length(Population),1,Global.N);
            Offspring  = GA(Population(MatingPool));
            Population = EnvironmentalSelection([Population,Offspring],V,(Global.gen/Global.maxgen)^alpha);
            if ~mod(Global.gen,ceil(fr*Global.maxgen))
                V(1:Global.N,:) = ReferenceVectorAdaptation(Population.objs,V0);
            end
             count = count+1;fprintf('Count = %d\n',count);
       end
        if run<=10
           index = 110 + (run-1)
        end
        if run>10 && run<= runs
           index = 210 + (run-11)
        end
        [Ns,~]   = size(Population.decs);[FrontNo,MaxFNo] = NDSort(Population.objs,Ns);
        Population = Population(FrontNo ==1);
       %% exexp
        address1 = ['C:\Users\lurso\Desktop\KSA-test\KSA-test\PlatEMO\data\',num2str(index),'.mat'];   
        save(address1,'Population');
        %% The rest evaluations are used in the modeling and identification of the knee regions  
        pop1 = Population;
        pop2 = Population;   
        %% Following the original optimizer
        while ReEva_count2 < Max_ReEvas
            MatingPool = randi(length(pop1),1,Global.N);
            Offspring  = GA(pop1(MatingPool));
            pop1 = EnvironmentalSelection([pop1,Offspring],V,(Global.gen/Global.maxgen)^alpha);
            if ~mod(Global.gen,ceil(fr*Global.maxgen))
                V(1:Global.N,:) = ReferenceVectorAdaptation(pop1.objs,V0);
            end
            [n,~] = size(Offspring.decs);
            ReEva_count2 = ReEva_count2+n;
        end
        address2 = ['C:\Users\lurso\Desktop\KSA-test\KSA-test\PlatEMO\EXP\',num2str(index),'.mat']; 
        save(address2,'pop1');
            
        while ReEva_count < Max_ReEvas
            % get first layer of solutions
            PopDecs =  pop2.decs;  
            PopObjs  = pop2.objs;
            [N,~]   = size(pop2.decs);
            [FrontNo,MaxFNo] = NDSort(PopObjs,N);
            pop2 = pop2(FrontNo ==1);  
            % training RBFNN
            Population0 = pop2;
            display('Train RBFNN');
            [net,Pe,Ps] = RBFNN_Gen(Population0); 
            display('Finish RBFNN')
            % normalization
            PopObjs = pop2.objs; %the first front now;
            [N,D]  = size(PopObjs);  
            % multimodal transformation 
            display('Model transform');
            Multimodal_obj = MOP2MMD(PopObjs); 
            % get a certain amount of solutions to train the model. 
            if N > 11*Global.D-1+25
                [~,index] = sort(Multimodal_obj); 
                Next      = index(1:11*D-1+25);
            else
                Next = true(N,1);
            end
            PopDecs =   pop2(Next).decs;  PopObjs =   pop2(Next).objs; 
            Multimodal_obj = Multimodal_obj(Next);
           % Eliminate the solutions having duplicate objectives
            [~,distinct] = unique(PopObjs,'rows');
            PopObjs = PopObjs(distinct,:);  
            Multimodal_obj = Multimodal_obj(distinct,:);          
           % Surrogate-Building£º model( PopObjs -> Trans_obj )
            [N,D]  = size(PopObjs); 
            % Pss: objs in the mapping space
            display('Kringing model training');
            [Pss,~,~] = getPss(PopObjs); 
            dmodel     = dacefit(PopObjs,Multimodal_obj,'regpoly1','corrgauss',theta,1e-5.*ones(1,D),20.*ones(1,D));
            theta      = dmodel.theta;
            display('Finish Kringing model training');
           % After the training, select solution for re-evaluation.
            display('Find candidate solutions');
            kneecandidatePss =  GenSolutionsx3(PopObjs,Multimodal_obj,dmodel);     
            %% control the solutions to be evaluated
%             [needeva,~] = size(kneecandidatePss);
%             if Max_ReEvas - ReEva_count < needeva
%                 kneecandidatePss = kneecandidatePss(randperm(needeva, Max_ReEvas - ReEva_count),:);
%             end
%             %% to find the decs for the knee candidates
%             PopDec      = Sim_RBF_Pss(kneecandidatePss,net); % new
            PopDec      = Sim_RBF(kneecandidatePss,net,Pe,Ps,Population0);
            pop2 = [pop2,INDIVIDUAL(PopDec)];
            [n,~] = size(PopDec);
            ReEva_count = ReEva_count+n;
            fprintf('ReEva_count = %d\n',ReEva_count);
         end
         fprintf('Count = %d\n',count);
         fprintf('Max_ReEva = %d\n',Max_ReEvas);
         fprintf('ReEva_count = %d\n',ReEva_count);
        %% result after the model prediction
         [Ns,~]   = size(pop2.decs);
         [FrontNo,MaxFNo] = NDSort(pop2.objs,Ns);
         pop2 = pop2(FrontNo ==1);
         % The achieved Population  after training
         if run<=10
             index = 310 + (run-1)
         end
         if run>10 && run<= runs
             index = 410 + (run-11)
         end
         fprintf('Independent Runs = %d\n',run);      
        %% exexp
        address3 = ['C:\Users\lurso\Desktop\KSA-test\KSA-test\PlatEMO\test\',num2str(index),'.mat'];      
        save(address3,'pop2');
         if run==runs
             break;
         end 
       end
       break;
    end
end