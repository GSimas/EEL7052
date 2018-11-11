%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laborat�rio) %%%
%%% Semestre 2015/1                           %%%
%%% Simula��o 6                               %%%
%%% Filtragem de Sinais                       %%%
%%% Resposta em Frequ�ncia                    %%%
%%% Filtros RLC, passa-baixas e passa-altas   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
f=0:10000; % vetor de frequ�ncia em Hz
w=2*pi*f; % vetor de frequ�ncia em rd/s
R=2.2508e3; % valor da resist�ncia em Ohms
L=2.533; % valor da indut�ncia em Henry
C=1e-6; % Valor do Capacitor em Farad
q=0.5*R*sqrt(C/L); % Fator de amortecimento
wn=1/sqrt(L*C); % Frequ�ncia natural n�o-amortecida
H=wn^2./(-w.^2+wn^2+1i*2*q*wn*w); % Express�o da Resposta em Frequ�ncia Filtro Passa-Baixas
%H=-w.^2./(-w.^2+wn^2+1i*2*q*wn*w); % Express�o da Resposta em Frequ�ncia Filtro Passa-Altas
modH=abs(H); % Resposta de Magnitude
angH=angle(H); % Resposta de Fase
subplot(2,1,1), semilogx(f,20*log10(modH))
title('Resposta de Magnitude');
xlabel('frequ�ncia (HZ)');
ylabel ('Magnitude');
grid
subplot(2,1,2), semilogx(f,angH)
title('Resposta de Fase');
xlabel('frequ�ncia (HZ)');
ylabel ('Fase (rd)');
grid