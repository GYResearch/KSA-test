
function [Output,Boundary] = P_objectives(Operation,Boundary,OldReadObjs,D,Input,theta)
     [Output,Boundary] = P_MNCS(Operation,Boundary,OldReadObjs,D,Input,theta);
end

% Transformation from a SOP to an MOP
function [Output,Boundary] = P_MNCS(Operation,Boundarym,OldReadObjs,Di,Input,theta)
    Boundary = Boundarym; 
    switch Operation
        case 'init'
            N = Input;
            D = Di;
            MaxValue =  Boundarym(1);
            MinValue =  Boundarym(2); 
            % Latin hypercube
            Population = lhsdesign(N,D);
            Population = Population.*(repmat(MaxValue,N,1)-repmat(MinValue,N,1));
            Output   = Population;
            Boundary =  Boundarym;
        case 'value'
            Population    = Input; % Input = pop here
            [N,~] = size(Population);
            FunctionValue = zeros(N,2);
           
            FunctionValue(:,1) = getfitnessValue(Population,OldReadObjs); % the first objective
            FunctionValue(:,2) =  -diversity_indicator(Population, theta); % the second objective
            Output = FunctionValue;
    end
end
