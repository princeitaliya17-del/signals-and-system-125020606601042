clc;
clear;
close;
%basic signal
t=-10:0.05:10;
impulse=zeros(1,length(t));
[m,idx]=min(abs(t));
impulse(idx)=1;
%unit step
ustep=zeros(1,length(t));
ustep((t>=0))=1;
%unit ramp
r=t.*ustep;
%signum
s=sign(t);
%plotting of graph
figure();
subplot(2,2,1);
plot(t,impulse);
title("unit impulse");
subplot(2,2,2);
plot(t,ustep);
title("unitstep");
subplot(2,2,3);
plot(t,r);
title("unitramp");
subplot(2,2,4);
plot(t,s);
title("signum");
% part 2 shifting of signal
%time shifting shifted unit step(t-2))
ushift=zeros(1,length(t));
ushift((t-2>=0))=1;
%time shifting shifted unit step(t+2))
ushift1=zeros(1,length(t));
ushift1((t+2>=0))=1;
%unit ramp
r=(t-2).*ushift;
p=(t+2).*ushift1;
figure();
subplot(2,3,1);
plot(t,ustep);
title("unitstep");
subplot(2,3,4);
plot(t,r);
title("unitramp");
subplot(2,3,2);
plot(t,ushift);
title("shift unit step by (t-2)")
subplot(2,3,3);
plot(t,ushift1);
title("shift unit step by (t+2)")
subplot(2,3,5);
plot(t,r);
title("shifted ramp signal by (t-2) ")
subplot(2,3,6);
plot(t,p);
title("shifted ramp signal by (t+2)")

