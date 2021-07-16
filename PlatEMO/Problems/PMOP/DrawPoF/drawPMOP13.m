x=[0:0.01:1];
y=[0:0.01:1];
[u,v]=meshgrid(x,y);
A=2;
B=1;
S=-2;
m1 = 5+10.*(u-0.5)*(u-0.5) + cos(A.*pi.*power(u,B))./(A.*power(2,S)); 
m=sqrt(m1);
f1=m.*u.*v;
f2=m.*u.*(1-v);
f3=m.*(1-u);
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