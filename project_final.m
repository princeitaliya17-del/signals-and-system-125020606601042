 
clc;
clear;
close all;

%% PART 1: SETUP AND SQUARE-WAVE GENERATION

T0 = 2*pi;
w0 = 2*pi/T0;

% Fine grid for numerical integration
t = linspace(0,T0,5001);

% Square wave: +1 during first half, -1 during second half
x = ones(size(t));
x(t >= T0/2) = -1;

%% PART 2: VERIFY ORTHOGONALITY NUMERICALLY

fprintf('\n--- ORTHOGONALITY TEST ---\n');

% Different cosine harmonics
Icc = trapz(t,cos(1*w0*t).*cos(2*w0*t));

% Different sine harmonics
Iss = trapz(t,sin(1*w0*t).*sin(2*w0*t));

% Cosine and sine
Ics = trapz(t,cos(1*w0*t).*sin(1*w0*t));

% Same cosine harmonic
I_same = trapz(t,cos(1*w0*t).*cos(1*w0*t));

% Constant and cosine
I_const = trapz(t,ones(size(t)).*cos(1*w0*t));

fprintf('<cos(w0t),cos(2w0t)> = %.6f\n',Icc);
fprintf('<sin(w0t),sin(2w0t)> = %.6f\n',Iss);
fprintf('<cos(w0t),sin(w0t)> = %.6f\n',Ics);
fprintf('<cos(w0t),cos(w0t)> = %.6f\n',I_same);
fprintf('<1,cos(w0t)> = %.6f\n',I_const);
fprintf('Expected same-harmonic value T0/2 = %.6f\n',T0/2);

%% PART 3: STANDARD FOURIER SERIES COEFFICIENTS

N = 20;

a0 = (2/T0)*trapz(t,x);
a = zeros(1,N);
b = zeros(1,N);

for n = 1:N
    a(n) = (2/T0)*trapz(t,x.*cos(n*w0*t));
    b(n) = (2/T0)*trapz(t,x.*sin(n*w0*t));
end

fprintf('\n--- FOURIER COEFFICIENTS ---\n');
fprintf('a0 = %.6f\n',a0);

fprintf('First five cosine coefficients:\n');
disp(a(1:5));

fprintf('First five sine coefficients:\n');
disp(b(1:5));

% Reconstruct using N harmonics
xFS = (a0/2)*ones(size(t));

for n = 1:N
    xFS = xFS + a(n)*cos(n*w0*t) ...
                + b(n)*sin(n*w0*t);
end

%% PART 4: BUILD A WALSH / HADAMARD RECTANGULAR BASIS

% Use a power-of-two number of samples, excluding the repeated endpoint
M = 1024;
tw = (0:M-1)*(T0/M);

xw = ones(1,M);
xw(tw >= T0/2) = -1;

% Build the Hadamard matrix recursively
H = 1;

while size(H,1) < M
    H = [H H; H -H];
end

% Reorder rows by number of sign changes (sequency order)
sequency = sum(diff(H,1,2) ~= 0,2);
[~,order] = sort(sequency);
W = H(order,:);

% Walsh-Fourier coefficients: normalized discrete inner products
c = (W*xw')/M;

fprintf('\n--- WALSH COEFFICIENTS ---\n');
fprintf('First ten Walsh coefficients:\n');
disp(c(1:10)');

%% PART 5: RECONSTRUCT USING WALSH FUNCTIONS

K = 20;

xWalsh = c(1:K)'*W(1:K,:);

%% PART 6: PLOT SIGNAL RECONSTRUCTIONS

figure;

subplot(2,1,1);
plot(t,x,'k','LineWidth',2);
hold on;
plot(t,xFS,'r','LineWidth',1.3);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Standard Fourier Series Reconstruction');
legend('Original square wave','Fourier approximation');

subplot(2,1,2);
stairs(tw,xw,'k','LineWidth',2);
hold on;
stairs(tw,xWalsh,'b','LineWidth',1.3);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Walsh Series Reconstruction');
legend('Original square wave','Walsh approximation');

%% PART 7: COMPARE CONVERGENCE SPEED

% Standard Fourier series: 0 to 50 harmonics
Nmax = 50;
a0c = (2/T0)*trapz(t,x);
ac = zeros(1,Nmax);
bc = zeros(1,Nmax);

for n = 1:Nmax
    ac(n) = (2/T0)*trapz(t,x.*cos(n*w0*t));
    bc(n) = (2/T0)*trapz(t,x.*sin(n*w0*t));
end

% Evaluate the Fourier reconstruction on the Walsh sample grid
xFine = ones(size(tw))*a0c/2;
fourierCount = 1;
fourierError = mean((xw-xFine).^2);

for n = 1:Nmax
    xFine = xFine + ac(n)*cos(n*w0*tw) ...
                    + bc(n)*sin(n*w0*tw);

    fourierCount(end+1) = 1 + 2*n;
    fourierError(end+1) = mean((xw-xFine).^2);
end

% Walsh reconstruction errors for the first K basis functions
walshCount = 1:101;
walshError = zeros(size(walshCount));

for k = walshCount
    xApprox = c(1:k)'*W(1:k,:);
    walshError(k) = mean((xw-xApprox).^2);
end

figure;
semilogy(fourierCount,max(fourierError,1e-14), ...
    'r-o','LineWidth',1.3);
hold on;
semilogy(walshCount,max(walshError,1e-14), ...
    'b-','LineWidth',1.5);
grid on;
xlabel('Number of basis functions');
ylabel('Mean squared reconstruction error');
title('Fourier vs Walsh Convergence');
legend('Standard Fourier Series','Walsh Series');

%% PART 8: PLOT COEFFICIENTS

figure;

subplot(2,1,1);
stem(1:N,a,'filled');
grid on;
xlabel('Harmonic number');
ylabel('a_n');
title('Cosine Fourier Coefficients');

subplot(2,1,2);
stem(1:N,b,'filled');
grid on;
xlabel('Harmonic number');
ylabel('b_n');
title('Sine Fourier Coefficients');

