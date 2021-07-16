function fitness = getfitnessValue(Population,OldReadObjs)
    [N,~] = size(Population);
    fv = zeros(N,1);
    for i=1:N
       fv(i,1) = MOP2MMD_ind(Population(i,:),OldReadObjs); 
    end
    fitness = fv;
end