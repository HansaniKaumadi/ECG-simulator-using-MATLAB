%date: 14/-8/2024
%coded by: Hansani Kaumadi
%A project to do basic ECG signal processing using MATLAB

clear all; close all; clc;
%fs=400;

%Loading the ECG Data
load ecgdata.dat -ascii; % the data file ecgdata.dat is in plain text (ASCII) format
a = ecgdata;

% For BM signals, better to use 5x or 10x of the original signal for the sampling frequency
T = 1; fs = 1000;
N = length(a); % no of samples per second
ts = 1/fs;
t = (0:N-1) * ts; % time axis definition 0:ts:N-1, ts=step size

% Plot the original ECG signal
figure;
plot(t, a);
title('Original ECG Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Averaging filter which is used to remove the presence of noise
out = zeros(1, N);
out(1) = a(1);
out(N) = a(N);
for i = 2:N-1
    out(i) = (a(i-1) + a(i) + a(i+1)) / 3; % 1 X 3 averaging filter
end

% Plot the filtered ECG signal
figure;
plot(t, out);
title('Filtered ECG Signal using Averaging Filter');
xlabel('Time (s)');
ylabel('Amplitude');

% Creating a noise signal
n = 0.2 * sin(2*pi*50*t); % Noise

outn = out + n; % noise signal is added

% Frequency domain analysis
% This section computes the Fast Fourier Transform (FFT) of both the filtered ECG signal and the noisy signal.

L = 2^nextpow2(N); % 2^n > no of samples
yf = fft(out, L);
xf = fft(outn, L);
f = fs * (0:L-1) / L; % frequency axis definition (0: L-1)/L is normalization

% Plot the original signal and its spectrum
figure;
subplot(321), plot(t, out); % original signal
title('Original Filtered ECG Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(322), plot(f, abs(yf)); % spectrum of original signal
title('Spectrum of Filtered ECG Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
set(gca, 'xlim', [0 0.5*fs], 'ylim', [0 max(abs(yf))]);

% Plot the noisy signal and its spectrum
subplot(323), plot(t, outn); % original signal with 50hz noise
title('Filtered ECG Signal with 50 Hz Noise');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(324), plot(f, abs(xf)); % spectrum with 50Hz noise
title('Spectrum of ECG Signal with 50 Hz Noise');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
set(gca, 'xlim', [0 0.5*fs], 'ylim', [0 max(abs(xf))]);

% Notch Filter to Remove 50 Hz Noise
H = ones(1, L); % defining the filter with all ones
l1 = floor(50*L/fs); % bin number for 50 hz (take min i.e., 26.5 will take 26)
l2 = L - l1 + 1; % complex conjugate
% l2=5000*L/fs;  % high frequency
for i = 1:L
    if ((i == l1) && (i == l1-1) && (i == l2) && (i == l2-1) && (i == l1+1) && (i == l2+1)) % bin no corresponding to f=50 and conjugates are made 1
        H(i) = 0;
    end
end

G = xf .* H;
G1 = real(ifft(G));
N1 = length(G1); % no of samples per second
t1 = (0:N1-1) * ts;

% Plot the recovered signal and its spectrum
subplot(325), plot(t1, G1); % recovered signal
title('Recovered ECG Signal after 50 Hz Noise Removal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(326), plot(f, abs(G1)); % recovered signal spectrum
title('Spectrum of Recovered ECG Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
set(gca, 'xlim', [0 0.5*fs], 'ylim', [0 max(abs(G1))]); % spectrum after removing 50 hz noise