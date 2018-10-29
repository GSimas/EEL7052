%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laboratório) %%%
%%% Semestre 2017/1                           %%%
%%% Simulação 5                               %%%
%%% Propriedades da Transformada de Fourier   %%%
%%% Propriedade de Escalonamento no Tempo     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

fs = 8000; % Frequencia de amostragem em Hz.
a = 4; % Fator de escalonamento (-4<=a=<4)

fprintf('\n');
fprintf('Função Pulso Triangular (1)\n');
fprintf('Função Pulso Retangular (2)\n');
fprintf('Função Rampa            (3)\n'); %Inserir a função Rampa do roteiro
selfun = input('Informe a função a ser utilizada (1, 2 ou 3): ');

switch selfun
    case 1
        % Sinal: Função Triangular
        % Sinal original
        t11 = -2:1/fs:0; % Vetor de tempo (ate 4 ms)
        x11 = 0.5*t11+1; % Sinal de entrada.
        t12 = 0:1/fs:2; % Vetor de tempo (ate 4 ms)
        x12 = -0.5*t12+1; % Sinal de entrada.
        x=[x11 x12(2:length(x12))];
        t=[t11 t12(2:length(t12))];
        % Sinal escalonado
        t11 = -2/a:a/fs:0; % Vetor de tempo (ate 4 ms)
        x11 = 0.5*a*t11+1; % Sinal de entrada.
        t12 = 0:a/fs:2/a; % Vetor de tempo (ate 4 ms)
        x12 = -0.5*a*t12+1; % Sinal de entrada.
        x_scale=[x11 x12(2:length(x12))];
        t_scale=[t11 t12(2:length(t12))];
    case 2
        % Sinal: Pulso retangular
        t = -.01:1/fs:.01;
        x = ones(1,size(t,2));
        t_scale = -.01/a:a/fs:.01/a;
        x_scale = ones(1,size(t_scale,2));
    case 3
        % Rampa
        t = 0:1/fs:0.004; % Vetor de tempo (ate 4 ms)
        x = 2000*t;
        t_scale = 0:a/fs:0.004/a; % Vetor de tempo (ate 4 ms)
        x_scale = 2000*a*t_scale; %
end

%% Grafico dos sinais no tempo
figure(1);
xmin=min(min(t),min(t_scale))-1e-3;xmax=max(max(t),max(t_scale))+1e-3;
ymin=min(0,min(x));ymax=1.5*max(x);
subplot(2,1,1),plot(t,x,'LineWidth',2);
axis([xmin,xmax,ymin,ymax]);
title('Sinal x(t) original');
ylabel('Amplitude');
grid on;

subplot(2,1,2),plot(t_scale,x_scale,'LineWidth',2);
axis([xmin,xmax,ymin,ymax]);
title('Sinal x(t) escalonado no tempo');
ylabel('Amplitude');
xlabel('Tempo [segundos]');
grid on;
disp('Pressione uma tecla para continuar...');
pause

%% Gráfico da Resposta em Frequência do Sinal
fig = figure(2);
set(fig,'Units','normalized','position',[0.1 0.1 0.8 0.8]);

% Calculo da Transformada Rapida de Fourier 
N = 2^16; % Numero de pontos usado no calculo da TF.
fx=fft(x,N); % Transformada de Fourier do sinal original
fx=fftshift(fx); % Transformada de Fourier centrada na origem
f=(-(N/2-1):N/2)*fs/N; % vetor de freqüências
fx_scale=fft(x_scale,N); % Transformada de Fourier do sinal escalonado no tempo
fx_scale=fftshift(fx_scale); % Transformada de Fourier centrada na origem

if(selfun == 1)
    subplot(2,1,1), plot(f,abs(fx)); % Gráfico da magnitude da Transformada de Fourier de x(t)
    title('Módulo da TF do sinal original');
    ylabel('Magnitude'); xlabel('Frequencia [Hz]');
    axis([-50,50,min(abs(fx)),max(abs(fx))]);
    grid on;

    subplot(2,1,2), plot(f,abs(fx_scale)/abs(a)); % Gráfico da magnitude da Transformada de Fourier de x(t) escalonado no tempo
    title('Módulo da TF do sinal escalonado no tempo');
    ylabel('Magnitude'); xlabel('Frequencia [Hz]');
    axis([-50,50,min(abs(fx_scale)/abs(a)),max(abs(fx_scale)/abs(a))]);
    grid on;
else
    subplot(2,1,1), plot(f,abs(fx)); % Gráfico da magnitude da Transformada de Fourier de x(t)
    title('Módulo da TF do sinal original');
    ylabel('Magnitude'); xlabel('Frequencia [Hz]');
    axis([-3000,3000,min(abs(fx)),max(abs(fx))]);
    grid on;

    subplot(2,1,2), plot(f,abs(fx_scale)/abs(a)); % Gráfico da magnitude da Transformada de Fourier de x(t) escalonado no tempo
    title('Módulo da TF do sinal escalonado no tempo');
    ylabel('Magnitude'); xlabel('Frequencia [Hz]');
    axis([-3000,3000,min(abs(fx_scale)/abs(a)),max(abs(fx_scale)/abs(a))]);
    grid on;
end