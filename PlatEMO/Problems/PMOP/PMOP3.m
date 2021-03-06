classdef PMOP3 < PROBLEM
% <problem> <PMOP>
% G. Yu, Y. Jin, and M. Olhofer, ˇ°Benchmark problems and performance
% indicators for search of knee points in multi-objective optimization,ˇ±
% IEEE Transactions on Cybernetics, 2019.
methods
    %% Initialization    
        function obj = PMOP3()
            obj.Global.A = 4; % control the number of knees, and width of knee region.
            obj.Global.B = 1; % control the bias
            obj.Global.S = 2; % control the depth of knee S = 1,-1
            obj.Global.p = 1; % bias in shape function
            obj.Global.Linkage = 0; % control the linkage function. 
            if isempty(obj.Global.M)
                obj.Global.M = 3;
            end
            if isempty(obj.Global.D)
                obj.Global.D = obj.Global.M + 9;
            end
            X1 = obj.Global.M-1;
            X2 = obj.Global.D - obj.Global.M + 1;
            obj.Global.lower    = zeros(1,obj.Global.D);
            obj.Global.upper    =  [ones(1,X1),10.*ones(1,X2)]; 
            obj.Global.encoding = 'real';
        end
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            % construct g function:
            [N,D] =  size(PopDec);
             M      = obj.Global.M;
             A      = obj.Global.A;  
             B      = obj.Global.B;  
             S      = obj.Global.S;  
             p      = obj.Global.p;  
             Linkage = obj.Global.Linkage;  
             % construct g function:
             g = zeros(N,1);
            if Linkage == 0   
                g = PopDec(:,M:end).^2 - 10.*cos(4.*pi.*PopDec(:,M:end)); %% g3...
                g = 1+10.*(D-M+1)+sum(g,2);
            end
           if  Linkage ~= 0   %% l1 linkage function in g3
                temp = zeros(N,D-M+1);
                for i=1:D-M+1
                   temp(:,i) =  (1+ i./(D-M+1)).*(PopDec(:,M-1+i) - Global.lower(M-1+i)) - PopDec(:,1).*(Global.upper(M-1+i) - Global.lower(M-1+i));   
                end 
                g = temp(:,1:end).^2 - 10.*cos(4.*pi.*temp(:,1:end)); %% g3...
                g = 1+10.*(D-M+1)+sum(g,2);
            end
             % construct the knee functions:
            r = zeros(N,M-1);
            k = zeros(N,1);
            for i=1:M-1
                r(:,i) = 1 + exp(sin(A.*power(PopDec(:,i), B).*pi+pi./2))./(power(2, S).* A);
            end
             Tr = r'; %% transposition
             if M>2
              k = prod(Tr(:,1:N))./(M-1); %% multiplicative
             end
             if M==2
              k = Tr(:,1:N)./(M-1); %% multiplicative
             end
             k = 2.^(k'); %% transposition
            
           %% construct the shape functions:           
            PopObj = ones(N,M);    
            for i=1:M
                 PopObj(:,i) = PopObj(:,i).*(1.0 + g).* k;
            end
            for i=1:M
               for j=1:M-i
                  PopObj(:,i) =  PopObj(:,i).*(1-cos(power(PopDec(:,j), p).*pi./2));
               end
               if i~=1
                   aux = M - i +1;
                   PopObj(:,i)= PopObj(:,i).*(1-sin(power(PopDec(:,aux), p).*pi./2));
               end
            end
        end
        function P = PF(obj,N) 
             M      = obj.Global.M;
             A      = obj.Global.A;  
             B      = obj.Global.B;  
             S      = obj.Global.S;  
             p      = obj.Global.p;  
             Linkage = obj.Global.Linkage;          
             X1 = M-1;
            lower    = zeros(1,X1);
            upper    = ones(1,X1);  
            PopDec   = rand(N,X1).*repmat(upper-lower,N,1) + repmat(lower,N,1);
            r = zeros(N,M-1);
            k = zeros(N,1);
            for i=1:M-1
                r(:,i) = 1 + exp(sin(A.*power(PopDec(:,i), B).*pi+pi./2))./(power(2, S).* A);
            end
           Tr = r'; %% transposition
             if M>2
              k = prod(Tr(:,1:N))./(M-1); %% multiplicative
             end
             if M==2
              k = Tr(:,1:N)./(M-1); %% multiplicative
             end
             k = 2.^(k'); %% transposition
            
           %% construct the shape functions:           
            PopObj = ones(N,M);    
            for i=1:M
                 PopObj(:,i) = PopObj(:,i).*(1.0+1.0).* k; %% min g3 = 1
            end
            for i=1:M
               for j=1:M-i
                  PopObj(:,i) =  PopObj(:,i).*(1-cos(power(PopDec(:,j), p).*pi./2));
               end
               if i~=1
                   aux = M - i +1;
                   PopObj(:,i)= PopObj(:,i).*(1-sin(power(PopDec(:,aux), p).*pi./2));
               end
            end
            [FrontNo,MaxFNo] = NDSort(PopObj,N);
            t=1;
            for i=1:N   
                if FrontNo(i) ==1
                  P(t,:) = PopObj(i,:);
                  t = t+1;
                end
            end
        end
    end
end