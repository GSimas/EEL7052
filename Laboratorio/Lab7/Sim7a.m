%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laboratório)         %%%
%%% Semestre 2014/1                                   %%%
%%% Simulação 7                                       %%%
%%% Amostragem de Sinais                              %%%
%%% Espectro de Frequência do Sinal de Tempo Contínuo %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc

% Sinal de Tempo Contínuo
delta_t = 0.00005;
t = -0.005:delta_t:0.005;
xa = exp(-1000*abs(t));

% Transformada de Fourier
Wmax = 2*pi*2000; % Frequência máxima utilizada no calculo da TF.
K = 500;
k = 0:1:K;
W = k*Wmax/K; % Criação do vetor de frequências, de 0 a Wmax, com K amostras.
              
Xa = xa*exp(-1i*t'*W)*delta_t; % Calculo da integral da TF, implementada como somatório.

Xa = real(Xa); % Utiliza somente a parte real pois a TF deste sinal é somente real.
               
% Cria vetor de freq. e da TF com a parte negativa:
W = [-fliplr(W), W(2:501)]; % Omega de -Wmax a Wmax
Xa = [fliplr(Xa), Xa(2:501)];

%Graficos
figure(1)
subplot(2,1,1);plot(t*1000,xa);
grid on
xlabel('tempo (ms)'); ylabel('x(t)')
title('Sinal de Tempo Contínuo')
subplot(2,1,2);plot(W/(2*pi*1000),Xa);
grid on
xlabel('frequência (KHz)'); ylabel('X(jW)');
title('Espectro de Frequência')
%%%%%%%%%%%%%%%%%%%%

