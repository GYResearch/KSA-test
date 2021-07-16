x=[0:0.01:1];
y=[0:0.01:1];
[u,v]=meshgrid(x,y);
A=4;
B=1;
S=2;
m1 = 1 + exp(cos(A.*power(u, B).*pi+pi./2))./(power(2, S).* A);
m2 = 1 + exp(cos(A.*power(v, B).*pi+pi./2))./(power(2, S).* A);
ma=(m1.*m2)./2;
m=3.^(ma)
f1=m.*u.*v;
f2=m.*u.*(1-v);
f3=m.*(1-u);
plot3(f1,f2,f3,'k');
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

% hold on
% A = load('C:\Users\lurso\Desktop\exp\NSGAII\1.txt');
% f1=A(:,1);
% f2=A(:,2);
% f3=A(:,3);
% plot3(f1,f2,f3,'bo');
% 
% xlabel('f1');
% ylabel('f2');
% zlabel('f3');
% view([132 22]);