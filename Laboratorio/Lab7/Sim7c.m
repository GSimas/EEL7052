%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laborat�rio) %%%
%%% Semestre 2014/1                           %%%
%%% Simula��o 7                               %%%
%%% Amostragem de Sinais                      %%%
%%% Reconstru��o do Sinal                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%close all
%clear all
clc

% Vetor de tempo do sinal de tempo cont�nuo
t_final = 0.005; % O sinal vai de -t_final at� t_final.

% Sinal de tempo discreto x1(n)
%Fs = 5000; % Freq. de amostragem.
Ts = 1/Fs;
n = -t_final/Ts:1:t_final/Ts;
nTs = n*Ts;
x = exp(-1000*abs(nTs));

% Reconstru��o do sinal analogico
delta_t = 0.0005;
t = -t_final:delta_t:t_final;

xr = x * sinc(Fs*(ones(length(nTs),1)*t-nTs'*ones(1,length(t))));

% Verifica��o
erro = max(abs(xr - exp(-1000*abs(t))));
figure(3)
clf
% Plots
plot(t*1000,xr);
xlabel('tempo (ms)'); ylabel('xr(t)')
title('Reconstru��o do Sinal');
grid on
hold on
% Sinal de Tempo Cont�nuo
delta_t = 0.00005;
t = -0.005:delta_t:0.005;
xa = exp(-1000*abs(t));
plot(t*1000,xa,'k-.');
%hold on
%stem(n*Ts*1000,x); hold off