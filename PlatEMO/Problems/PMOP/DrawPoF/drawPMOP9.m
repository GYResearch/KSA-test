x=[0:0.01:1];
y=[0:0.01:1];
[u,v]=meshgrid(x,y);
A=2;
B=1;
S=2;
m1 = 2 - exp(cos(A.*power(u, B).*pi)+0.5.*(cos(A.*power(u, B).*pi)-0.5).^4)./(power(2, S).* A);
m2 = 2 - exp(cos(A.*power(v, B).*pi)+0.5.*(cos(A.*power(v, B).*pi)-0.5).^4)./(power(2, S).* A);
ma=(m1.*m2)./2;
m= ma;
f1=m.*(1-cos(u.*pi./2)).*(1-cos(v.*pi./2));
f2=m.*(1-cos(u.*pi./2)).*(1-sin(v.*pi./2));
f3=m.*(1-sin(u.*pi./2));
plot3(f1,f2,f3,'k');
hold on
hold on
A = load('C:\Users\lurso\Desktop\exp\ExpPoF\0.txt');
f1=A(:,1);
f2=A(:,2);
f3=A(:,3);
plot3(f1,f2,f3,'bo');
hold on;
A = load('C:\Users\lurso\Desktop\exp\ExpKnee\0.txt');
f1=A(:,1);
f2=A(:,2);
f3=A(:,3);
plot3(f1,f2,f3,'r*');
hold on;
xlabel('f1');
ylabel('f2');
zlabel('f3');
view([132 22]);

% 
% hold on
% A = load('C:\Users\lurso\Desktop\exp\NSGAII\1.txt');
% f1=A(:,1);
% f2=A(:,2);
% f3=A(:,3);
% plot3(f1,f2,f3,'bo');
% 

% 
% % %begin
% popObj = load( 'C:\Users\lurso\Desktop\PlatEMO\PlatEMO v1.5 (2017-12)\ALL_Data\KRVEA\KRVEA_PMOP2_M3_1_78.mat');
% 
% popPF = popObj.Population.objs;
% [row,column] = size(popPF);
% %%% ∑«÷ß≈‰≈≈–Ú %%%%
% [FrontNo,MaxFNo] = NDSort(popPF,row);
% %% »˝Œ¨
% if column == 3
%     for i=1:row   
%         if FrontNo(i) ==1
%           plot3(popPF(i,1),popPF(i,2),popPF(i,3),'k-o');
%           hold on;
%         end
%     end
% title('KRVEA on PMOP2');
% % title('KneeEGO on PMOP1');
% xlabel('f1');
% ylabel('f2');
% zlabel('f3');
% view(129,31);
% end
% %%% end

% A = load('C:\Users\lurso\Desktop\PlatEMO\PlatEMO v1.5 (2017-12)\ALL_Data\KneeEGO_PMOP2_3_10\KneeEGO_PMOP2_M3_1_79.mat');


view([132 22]);