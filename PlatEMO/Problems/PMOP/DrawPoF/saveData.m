function saveData(nameofProblem,Objs,M)
    name1 = 'C:\Users\lurso\Desktop\PlatEMO\PlatEMO v1.5 (2017-12)\Problems\XPMOP\POF\';
    name = strcat(name1,nameofProblem);
    name2 = num2str(M); 
    name = strcat(name,name2);
    filename = strcat(name,'.mat');
    save(filename,'Objs'); 
end