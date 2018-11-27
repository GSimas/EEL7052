%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laborat�rio) %%%
%%% Semestre 2014/1                           %%%
%%% Simula��o 7                               %%%
%%% Amostragem de Sinais                      %%%
%%% Sinal Amostrado e Espectro de Frequ�ncia  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%close all
clear all
clc
%
Fs = 4000; % Freq. de amostragem.
% Sinal de Tempo Cont�nuo 
t_final = 0.005; % O sinal vai de -t_final at� t_final.
delta_t = 0.00005;
t = -t_final:delta_t:t_final;
xa = exp(-1000*abs(t));

% Sinal de Tempo discreto
Ts = 1/Fs;
n = -t_final/Ts:1:t_final/Ts; % Vetor do n�mero de amostras.
x = exp(-1000*abs(n*Ts)); % sinal discreto.

% Transformada de Fourier:
K = 500; k = 0:1:K;
c = 3; % N�mero de vezes que o espectro ser� repetido.
w = (c*pi*k)/K;
X = x * exp(-1i*n'*w);
X = real(X);
w = [-fliplr(w), w(2:K+1)];
X = [fliplr(X), X(2:K+1)];

% Gr�ficos:
figure(2)
clf
subplot(1,1,1)
subplot(2,1,1);plot(t*1000,xa,'k-.');
grid on
xlabel('tempo (ms)'); ylabel('xr(n)')
title('Sinal Discreto'); hold on
stem(n*Ts*1000,x); hold off
subplot(2,1,2);plot(Fs*w/(2*pi),X);
grid on
xlabel('frequ�ncia (Hz)'); ylabel('Xr(f)')
title('Transformada de Fourier')
Sim7c