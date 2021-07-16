x=[0:0.01:1];
y=[0:0.01:1];
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
plot3(f1,f2,f3,'k');
hold on
A = load('C:\Users\lurso\Desktop\exp\ExpPoF\RVEA+WD\PMOP1-3\0.txt');
f1=A(:,1);
f2=A(:,2);
f3=A(:,3);
plot3(f1,f2,f3,'bo');
hold on;
xlabel('f1');
ylabel('f2');
zlabel('f3');
view([132 22]);