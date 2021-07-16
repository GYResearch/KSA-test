clc;
clear all;
x=[0 1 2 3 4 5 6 7];
data = load('C:\Users\lurso\Desktop\PlatEMO\PlatEMO v1.5 (2017-12)\Problems\XPMOP\trueKnee\PMOP9-8.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\KDMOEA+\PMOP9-8\13.txt');%% 
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\NSGA2+Dis\PMOP9-8\17.txt');
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\NSGA2+EMU\PMOP9-8\2.txt');
A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\NSGA2+WD\PMOP9-8\2.txt');
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\RVEA+Dis\PMOP9-8\19.txt');
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\RVEA+EMU\PMOP9-8\1.txt');
% A = load('C:\Users\lurso\Desktop\Angle-dominance\exp\with_linkage\ExpKnee\RVEA+WD\PMOP9-8\2.txt');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ad = data.Objs;
legendd = [];
legendd = [legendd;Ad(1,:)];
legendd = [legendd;A(1,:)];
plot(x,legendd(1,:),'rp-','LineWidth',1,'MarkerSize',12);
hold on;
plot(x,legendd(2,:),'k*-','LineWidth',1,'MarkerSize',12);
legend('Knee point','Solution');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on;
[nr,nc] = size(Ad);
  for i= 2:nr
    plot(x,Ad(i,:),'rp-','LineWidth',1,'MarkerSize',12);
    hold on 
  end
hold on;
[nr,nc] = size(A);
 for i= 2:nr
    plot(x,A(i,:),'k*-','LineWidth',1,'MarkerSize',12);
    hold on 
 end
hold on;
% legend('PoF','Knee point','Solution','Location','northeast');
xlabel('{Objective No.}');
ylabel('{Objective Value}');
% zlabel('$\it{f_3}$','Interpreter','latex','FontName','Arial Italic');
set(gca,'FontSize',20);