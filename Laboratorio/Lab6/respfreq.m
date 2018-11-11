%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laboratório) %%%
%%% Semestre 2015/1                           %%%
%%% Simulação 6                               %%%
%%% Filtragem de Sinais                       %%%
%%% Resposta em Frequência                    %%%
%%% Filtros RLC, passa-baixas e passa-altas   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
f=0:10000; % vetor de frequência em Hz
w=2*pi*f; % vetor de frequência em rd/s
R=2.2508e3; % valor da resistência em Ohms
L=2.533; % valor da indutância em Henry
C=1e-6; % Valor do Capacitor em Farad
q=0.5*R*sqrt(C/L); % Fator de amortecimento
wn=1/sqrt(L*C); % Frequência natural não-amortecida
H=wn^2./(-w.^2+wn^2+1i*2*q*wn*w); % Expressão da Resposta em Frequência Filtro Passa-Baixas
%H=-w.^2./(-w.^2+wn^2+1i*2*q*wn*w); % Expressão da Resposta em Frequência Filtro Passa-Altas
modH=abs(H); % Resposta de Magnitude
angH=angle(H); % Resposta de Fase
subplot(2,1,1), semilogx(f,20*log10(modH))
title('Resposta de Magnitude');
xlabel('frequência (HZ)');
ylabel ('Magnitude');
grid
subplot(2,1,2), semilogx(f,angH)
title('Resposta de Fase');
xlabel('frequência (HZ)');
ylabel ('Fase (rd)');
grid