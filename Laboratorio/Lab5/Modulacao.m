%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EEL7052 - Sistemas Lineares (Laborat�rio)           %%%
%%% Semestre 2017/1                                     %%%
%%% Simula��o 5                                         %%%
%%% Propriedades da Transformada de Fourier             %%%
%%% Propriedade de Transla��o em Frequ�ncia (Modula��o) %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

%% 
fs = 100000;     % Frequencia de amostragem em Hz.
fc = 10000;      % Frequencia da portadora em Hz (fc=<fs/4).

fprintf('\n');
fprintf('Fun��o Pulso Retangular          (1)\n');
fprintf('Fun��o Rampa Limitada no Tempo   (2)\n');
fprintf('Fun��o Cosseno Limitado no Tempo (3)\n');
fprintf('Fun��o Cosseno Amortecido        (4)\n');
fprintf('Fun��o Pulso Triangular          (5)\n');
selfun = input('Informe a fun��o a ser utilizada (n�mero): ');

switch selfun
    case 1  % Sinal: Pulso retangular
        tmin = -1.5e-3;
        tmax =  1.5e-3;
        t = tmin:1/fs:tmax;
        
        NZ = floor(numel(t)/4);
        NO = numel(t) - 2*NZ;
        
        x = [zeros(1,NZ), ones(1,NO), zeros(1,NZ)];
        
    case 2	% Sinal: Rampa
        tmin = 0;
        tmax = 4e-3;
        t = tmin:1/fs:tmax;
        
        NZ = floor(numel(t)/4);
        NO = numel(t) - NZ;
        
        x = [2000*t(1:NO), zeros(1,NZ)];
        
    case 3	% Sinal: Cosseno limitado no tempo
        tmin = -2e-3;
        tmax = 2e-3;
        t = tmin:1/fs:tmax;
        
        NZ = floor(numel(t)/4);
        NO = numel(t) - 2*NZ;
        
        x = [zeros(1,NZ), ones(1,NO).* cos(2*pi*1000*t(NZ:NO+NZ-1)), zeros(1,NZ)];

    case 4	% Sinal: Cosseno amortecido
        tmin = -0.2;
        tmax = 0.5;
        t = tmin:1/fs:tmax;
        
        NZ = floor(numel(t)/4);
        NO = numel(t) - NZ;
        
        x = [exp(-10*t(1:NO)) .* cos(20*pi*t(1:NO)), zeros(1,NZ)];

    case 5  % Sinal Fun��o Triangular:
        tmin = -1e-2;
        tmax = 1e-2;
        t11 = (tmin):1/fs:(0);          
        t12 = (1/fs):1/fs:(tmax);
        
        NO = numel(t11);
        
        % Rampa1
        x11 = 10*100*t11(1:NO)+10;              % Sinal de entrada.
        
        % Rampa2
        x12 = -10*100*t12(1:NO-1)+10;            % Sinal de entrada.
        
        % Fun��o Triangular
        x = [x11 x12];
        t = [t11 t12];
end
%% Grafico do sinal no tempo
%
figure(1);
plot(t,x,'LineWidth',2);                % Gr�fico do sinal de entrada.

% axis([xmin,xmax,ymin,ymax]);
ymin=min(0,min(x));ymax=1.2*max(x);
axis([tmin,tmax,ymin,ymax]);

title('Sinal x(t)');
ylabel('Amplitude');
xlabel('Tempo [segundos]');
grid on;

pause

%% Gr�fico da Resposta em Frequ�ncia do Sinal
fig = figure(2);
set(fig,'Units','normalized','position',[0.1 0.1 0.8 0.8]);

% C�lculo da Transformada Rapida de Fourier 
N = 50000;                          % Numero de pontos usado no calculo da TF.

fx=fft(x,N);                        % Transformada de Fourier do pulso
fx=fftshift(fx);                    % Transformada de Fourier centrada na origem
f=(-(N/2-1):N/2)*fs/N;              % vetor de freq��ncias

% Graficos dos Espectros de Frequencia
subplot(2,1,1), plot(f,abs(fx));    % Gr�fico da magnitude da Transformada de Fourier de x(t)
title('M�dulo da TF do sinal');
ylabel('Magnitude'); xlabel('Frequencia [Hz]');
grid on;

%% Modulacao do sinal:
n = 1:size(x,2);                    % Vetor com o n�mero de pontos do sinal x;
p=cos(2*pi*fc*n/fs);                % cria�ao da portadora com o mesmo tamanho de x.
y=x.*p;                             % sinal modulado
fy=fft(y,N);                        % Transformada de Fourier do sinal modulado
fy=fftshift(fy);                    % Transformada de Fourier centrada na origem
subplot(2,1,2), plot(f,abs(fy));    % Gr�fico da magnitude da Transformada de Fourier de y(t)
title('M�dulo da TF do sinal modulado');
ylabel('Magnitude'); xlabel('Frequencia [Hz]');
grid on;

pause

%% Demodulacao:
fig = figure(3);
set(fig,'Units','normalized','position',[0.1 0.1 0.8 0.8]);

z = 2*(y .* p);                         % funcao * cos^2
fz = fft(z,N);
fz = fftshift(fz);

subplot(4,1,1), plot(f,abs(fx));    % Grafico do espectro do sinal de entrada
title('Modulo da TF do sinal de entrada');
grid on;
subplot(4,1,2), plot (f,abs(fy));   % Grafico do espectro sinal modulado
title('Modulo da TF do sinal modulado');
grid on;
subplot(4,1,3), plot (f,abs(fz));   % Grafico do espectro do sinal demodulado, antes do filtro
title('Modulo da TF do sinal demodulado, antes do filtro');
xlabel('Frequencia [Hz]');
grid on;
%fzf(1:20000) = zeros(1,20000);      % filtragem passa-baixas ideal
%fzf(30001:50000) = zeros (1,20000);
%fzf(20001:30000) = fz(20001:30000);
Kcorte=N*fc/fs;
fzf(1:20000) = zeros(1,20000);      % filtragem passa-baixas ideal
fzf(30001:50000) = zeros (1,20000);
fzf(20001:30000) = fz(20001:30000);

subplot(4,1,4), plot (f,abs(fzf));  % Grafico do espectro do sinal demodulado, depois do filtro
title('Modulo da TF do sinal demodulado, depois do filtro');
xlabel('Frequencia [Hz]');
grid on;

pause

%% Grafico dos sinais no tempo
%
fig = figure(4);
set(fig,'Units','normalized','position',[0.1 0.1 0.8 0.8]);

ymin=min(0,min(x));ymax=1.5*max(x);
subplot(4,1,1), plot(t,x,'LineWidth',2);    % Gr�fico do sinal de entrada.
axis([tmin,tmax,ymin,ymax]);
title('Sinal x(t)');
ylabel('Amplitude');
xlabel('Tempo [segundos]');
grid on;

ymin=min(0,min(y));ymax=1.5*max(y);
subplot(4,1,2), plot(t,y,'LineWidth',2);    % Gr�fico do sinal modulado.
axis([tmin,tmax,ymin,ymax]);
title('Sinal modulado y(t)');
ylabel('Amplitude');
xlabel('Tempo [segundos]');
grid on;

ymin=min(0,min(z));ymax=1.5*max(z);
subplot(4,1,3), plot(t,z,'LineWidth',2);    % Gr�fico do sinal demodulado, antes do filtro.
axis([tmin,tmax,ymin,ymax]);
title('Sinal demodulado z(t), antes do filtro');
ylabel('Amplitude');
xlabel('Tempo [segundos]');
grid on;

zf = 2*ifft(fzf(end/2:end),N);
ymin=min(0,min(real(zf)));ymax=1.5*max(real(zf));
subplot(4,1,4), plot(t,real(zf(1:numel(t))),'LineWidth',2);    % Gr�fico do sinal demodulado, depois do filtro.
axis([tmin,tmax,ymin,ymax]);
title('Sinal demodulado z(t), depois do filtro');
ylabel('Amplitude');
xlabel('Tempo [segundos]');
grid on;
