%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laborat�rio)     %%%
%%% Semestre 2017/2                               %%%
%%% Simula��es:                                   %%%
%%% 3- Resposta em Frequ�ncia e Diagramas de Bode %%%
%%% 6 -Filtragem de Sinais                        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%% Par�metros do Sinal Senoidal de Entrada
A = 1.0; % Amplitude
f = 9122; % Frequ�ncia (Hz)
w = 2*pi*f; % Frequ�ncia (rad/s)
To=1/f; % Per�odo (s)
%% Executa a Simula��o
if f > 500
   T = round(20*To/5.0000e-007)*5.0000e-007; % Tempo de Simula��o (segundos)- usar a partir de 500 Hz
else
   T = round(10*To/5.0000e-007)*5.0000e-007; % Tempo de Simula��o (segundos) - usar ate a 500 Hz
end
sim('FPB',T);
%% Plota os Gr�ficos das Respostas
plot(entrada.time,entrada.signals.values,'r',saida.time,saida.signals.values,'b');
grid on
xlabel('Tempo [s]');
ylabel('Amplitude');
titulo = strcat('Resposta do Sistema (freq.= ',num2str(f),' Hz)');
title(titulo);