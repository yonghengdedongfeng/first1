clear;
clc;
a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
b = a*sqrt(1-e^2);
t = linspace(0,2*pi);
X = a*cos(t);
Y = b*sin(t);
w = atan2(y2-y1,x2-x1);
x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
y = (y1+y2)/2 + X*sin(w) + Y*cos(w);
plot(x,y,'y-')
axis equal
contour
%% 
a=4.96-0.00j; % horizontal radius
b=-3.00+0.0j; % vertical radius
z=-0.0-4.0j;
x0=0; % x0,y0 ellipse centre coordinates
y0=0;
z0=0;
t=-pi:0.01:pi;
x=x0+real(a*exp(1j*t));
y=y0+real(b*exp(1j*t));
z=z0+real(z*exp(1j*t));
t = x.*x+y.*y+z.*z;
long = max(t);
duan = min(t);
longd = find(t== long);
duand = find(t== duan);
%ellipse1
A = [x(1) y(1) z(1)];
B = [x(300) y(300) z(300)];
D = cross(A,B);
plot(x,y)
plot3(x,y,z)
hold on 
quiver3(0,0,0,D(1),D(2),D(3),0,'LineWidth',3)
quiver3(0,0,0,x(longd),y(longd),z(longd),0,'LineWidth',3)
quiver3(0,0,0,x(duand),y(duand),z(duand),0,'LineWidth',3)
axis equal
%%

X=0;
Y=0;
Z=0;
for t = linspace(0,2*pi,20)
    U=real(1*exp(1j*t));
    V=real(1j*exp(1j*t));
    W=real(1j*exp(1j*t));
    figure(1);
    quiver3(X,Y,Z,U,V,W,0,'LineWidth',1)
    quiver3(X,Y,-sqrt(3),U,V,0,0,'LineWidth',1)
    hold on 
    [X1,Y1,Z1] = sphere;
    r = sqrt(3);
    X1 = X1 * r;
    Y1 = Y1 * r;
    Z1 = Z1 * r;
    s = surf(X1,Y1,Z1,'FaceColor','r','FaceAlpha',0.1,'EdgeAlpha',0);
    xlabel('x')
    ylabel('y')
    zlabel('z')
    axis equal
    pause(1)
end

%%
t = linspace(0,2*pi,50);
U=real(1*exp(1j*t));
V=real(1j*exp(1j*t));
W=real(1j*exp(1j*t));
figure(1);
plot(t,U,t,V,t,W)
xlabel('t')
ylabel('A')
legend('px','py,pz')

%%
%最小二乘法拟合数据
xdata = ...
 [0.9 1.5 13.8 19.8 24.1 28.2 35.2 60.3 74.6 81.3];
ydata = ...
 [455.2 428.6 124.1 67.3 43.2 28.1 13.1 -0.4 -1.3 -1.5];
fun = @(x,xdata)x(1)*exp(x(2)*xdata);
x0 = [100,-1];
x = lsqcurvefit(fun,x0,xdata,ydata);
times = linspace(xdata(1),xdata(end));
plot(xdata,ydata,'ko',times,fun(x,times),'b-')
legend('Data','Fitted exponential')
title('Data and Fitted Curve')

%%
%一个不成熟的天线发射叫分布图
fc = 1.5e9;
antenna = phased.CrossedDipoleAntennaElement('FrequencyRange',[1,2]*1e9);
az = -180:180;
el = zeros(size(az));
resp = antenna(fc,[az;el]);
cfv = pol2circpol([resp.H.';resp.V.']);
clhp = cfv(1,:);
crhp = cfv(2,:);
polarplot(az*pi/180.0,abs(clhp))
hold on
polarplot(az*pi/180.0,abs(crhp))
title('LHCP and RHCP vs Azimuth Angle')
legend('LHCP','RHCP')
hold off



