x=[0:0.05:1];
y=[0:0.05:1];
[u,v]=meshgrid(x,y);
A=4;
B=1;
S=-1;
m1 = 5+10.*(u-0.5).^2+ cos(A.*u.^B.*pi)./(A.*2.^S);
m2 = 5+10.*(v-0.5).^2+ cos(A.*v.^B.*pi)./(A.*2.^S);
ma=(m1.*m2)./2;
m = log(ma);
%m=m1
f1=m.*u.*v;
f2=m.*u.*(1-v);
f3=m.*(1-u);
mesh(f1,f2,f3);
alpha(0);
hold on;
data = load('C:\Users\lurso\Desktop\PlatEMO\PlatEMO v1.5 (2017-12)\Problems\XPMOP\trueKnee\PMOP1-3.mat');
A = data.Objs;
f1=A(:,1);
f2=A(:,2);
f3=A(:,3);
plot3(f1,f2,f3,'MarkerSize',12, 'Marker','p','LineStyle','none','LineWidth',1, 'Color',[1 0 0]);
hold on;
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\KDMOEA+\PMOP1-3\1.txt');
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\NSGA2+Dis\PMOP1-3\5.txt');
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\NSGA2+EMU\PMOP1-3\2.txt');
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\NSGA2+WD\PMOP1-3\2.txt');
A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\RVEA+Dis\PMOP1-3\17.txt');
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\RVEA+EMU\PMOP1-3\8.txt');
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\RVEA+WD\PMOP1-3\4.txt');

f1=A(:,1);
f2=A(:,2);
f3=A(:,3);
plot3(f1,f2,f3,'MarkerSize',8, 'Marker','o','LineStyle','none','LineWidth',1, 'Color',[0 0 1]);
view(130,18);
legend('PoF','Knee point','Solution','Location','northeast');
xlabel('$\it{f_1}$','Interpreter','latex','FontName','Arial Italic');
ylabel('$\it{f_2}$','Interpreter','latex','FontName','Arial Italic');
zlabel('$\it{f_3}$','Interpreter','latex','FontName','Arial Italic');
set(gca,'FontSize',20);