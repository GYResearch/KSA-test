clc;
clear all;

%% PoF
x=[0:0.01:1];
k= 4;
m1 = 5+10.*(x-0.5).^2+cos(2.*k.*pi.*x)./k;
f1=m1.*sin(pi.*x./2);
f2=m1.*cos(pi.*x./2);
plot(f1,f2,'r-','MarkerSize',10,'LineWidth',1);
xlabel('f1');
ylabel('f2');
hold on;
%% the true knees on the PoF.
data = load('DEB2DK-4.mat');
pof = data.Objs;
plot(pof(:,1),pof(:,2),'rp','MarkerSize',2);
hold on;
% %% obtained PoF
data = load('C:\Users\lurso\Desktop\KSA-test\KSA-test\PlatEMO\test\310.mat');
A = data.pop2.objs;
[nA1,~] = size(A);
plot(A(:,1),A(:,2),'bo', 'MarkerSize',12);

