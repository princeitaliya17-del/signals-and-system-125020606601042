clc;
clear all;
close all;

syms n z;

x = sin(n);

f = ztrans(x,n,z);
disp('Z-transform of sin(n):');
pretty(f);

inversex = iztrans(f,z,n);
disp('Inverse Z-transform:');
pretty(inversex);

figure;
pz = tf([1],[1,2,1]);
pzmap(pz);
grid on;
title('Pole-Zero Plot');

