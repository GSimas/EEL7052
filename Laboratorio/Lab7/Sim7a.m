%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laborat�rio)         %%%
%%% Semestre 2014/1                                   %%%
%%% Simula��o 7                                       %%%
%%% Amostragem de Sinais                              %%%
%%% Espectro de Frequ�ncia do Sinal de Tempo Cont�nuo %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc

% Sinal de Tempo Cont�nuo
delta_t = 0.00005;
t = -0.005:delta_t:0.005;
xa = exp(-1000*abs(t));

% Transformada de Fourier
Wmax = 2*pi*2000; % Frequ�ncia m�xima utilizada no calculo da TF.
K = 500;
k = 0:1:K;
W = k*Wmax/K; % Cria��o do vetor de frequ�ncias, de 0 a Wmax, com K amostras.
              
Xa = xa*exp(-1i*t'*W)*delta_t; % Calculo da integral da TF, implementada como somat�rio.

Xa = real(Xa); % Utiliza somente a parte real pois a TF deste sinal � somente real.
               
% Cria vetor de freq. e da TF com a parte negativa:
W = [-fliplr(W), W(2:501)]; % Omega de -Wmax a Wmax
Xa = [fliplr(Xa), Xa(2:501)];

%Graficos
figure(1)
subplot(2,1,1);plot(t*1000,xa);
grid on
xlabel('tempo (ms)'); ylabel('x(t)')
title('Sinal de Tempo Cont�nuo')
subplot(2,1,2);plot(W/(2*pi*1000),Xa);
grid on
xlabel('frequ�ncia (KHz)'); ylabel('X(jW)');
title('Espectro de Frequ�ncia')
%%%%%%%%%%%%%%%%%%%%

