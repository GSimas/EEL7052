%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laboratório)     %%%
%%% Semestre 2017/2                               %%%
%%% Simulações:                                   %%%
%%% 3- Resposta em Frequência e Diagramas de Bode %%%
%%% 6 -Filtragem de Sinais                        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%% Parâmetros do Sinal Senoidal de Entrada
A = 1.0; % Amplitude
f = 9122; % Frequência (Hz)
w = 2*pi*f; % Frequência (rad/s)
To=1/f; % Período (s)
%% Executa a Simulação
if f > 500
   T = round(20*To/5.0000e-007)*5.0000e-007; % Tempo de Simulação (segundos)- usar a partir de 500 Hz
else
   T = round(10*To/5.0000e-007)*5.0000e-007; % Tempo de Simulação (segundos) - usar ate a 500 Hz
end
sim('FPB',T);
%% Plota os Gráficos das Respostas
plot(entrada.time,entrada.signals.values,'r',saida.time,saida.signals.values,'b');
grid on
xlabel('Tempo [s]');
ylabel('Amplitude');
titulo = strcat('Resposta do Sistema (freq.= ',num2str(f),' Hz)');
title(titulo);