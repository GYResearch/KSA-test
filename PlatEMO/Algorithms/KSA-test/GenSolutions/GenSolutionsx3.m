function [KneeSpring] =  GenSolutionsx3(Objs,Trans_obj,model)
        [N,M] = size(Objs);
        F = 0.8;
        CR = 0.8;
        K = N;
        [~,NI] = pdist2(Objs,Objs,'euclidean','Smallest',K);
        KneeSpring = [];
        D = M;
        
        %% peak detection on Trans_obj
        eta = 1./(max(Trans_obj) - min(Trans_obj));
        [slice_x, slice_f] = landscape_cutting(Objs, Trans_obj, eta);  
        MarkSolutionset = false(N,1); % track the index of the population
        ppeaks = [];
        while(~isempty(slice_f))
            [~, temp_peaks, ~] = peak_detection(slice_x);
            ppeaks = [ppeaks, temp_peaks];
            [slice_x, slice_f] = landscape_cutting(slice_x, slice_f, 0.5);  
        end;
        KK = length(ppeaks)
        centers_x = zeros(KK,D); 
        for k=1:KK
            peak_x = ppeaks(k); 
            px = cell2mat(peak_x);
            temp = MOP2MMD_ind(px,Objs);
            peak_f = temp(:,1);
            [~, I] = min(peak_f);
            centers_x(k,:) =  px(I,:);
        end  
        peakspring = zeros(KK,M);
        peakspring = centers_x; %% saves the peaks.objs
       
        %% use DE to generate solutions
        for ps = 1:KK
            offSpring = zeros(N,M);
            LCB = zeros(N,1);
            for i=1:N
                v = peakspring(ps,:) + F.*(Objs(NI(randi(K),i),:)-Objs(NI(randi(K),i),:)); %% middle solution
                jrand = randi([1 M]);
                offSpring(i,:) = Objs(i,:);
                for j=1:M
                    if rand<=CR |jrand ==j
                        offSpring(i,j) = v(:,j);
                    end
                end
                [y,~,mse] = predictor(offSpring(i,:),model);
                s         = sqrt(mse);
                LCB(i)    = y-2*s;
            end
             [~,index] = sort(LCB,'ascend'); %% ascend, minimize LCB
             KneeSpring = [KneeSpring; offSpring(index(1),:)];
        end     
end