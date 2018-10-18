%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laborat�rio)  %%%
%%% Semestre 2017/2                            %%%
%%% Simula��o 3                                %%%
%%% Resposta em Frequ�ncia e Diagramas de Bode %%%
%%% Filtros RLC, passa-baixas e passa-altas    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
f=10:100000; % vetor de frequ�ncia em Hz
w=2*pi*f; % vetor de frequ�ncia em rd/s
q=1/sqrt(2); % Fator de amortecimento
wn=2*pi*10^3; % Frequ�ncia natural n�o-amortecida
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