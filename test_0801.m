clc;close all;clear;
tic;

%% pick the input will be analyzed
% [filename, path] = uigetfile('.csv');
% cd(path);
filename = 'demo_2021_12_01_05_37.csv';
% filename = 'llkevin_2021_06_29_12_34.csv';
% filename = 'chun_0825.csv';
% filename = 'Frank Gu_2022_07_21_12_54.csv';

T = readtable(filename,'HeaderLines',4); % for non_numeric array
eeg1 = T{:,2};
eeg2 = T{:,3};

% delete Nan values if any
eeg1(isnan(eeg1)) = [];
eeg2(isnan(eeg2)) = [];
% two channels dimension equivalence check
if ~isequal(length(eeg1),length(eeg2))
    eeg1 = eeg1(1:min(length(eeg1),length(eeg2)));
    eeg2 = eeg2(1:min(length(eeg1),length(eeg2)));
end
%% filtering the raw data for further process
fs = 250; % sampling frequency
T = 1/fs;  
data_len = length(eeg1); % length of selected signal
time_vector = (0:data_len-1)/fs; % time vector
data_dur = data_len/fs; % recording duration, in seconds

%% preprocess
% band pass  ´øÍ¨ÂË²¨[2]
[b,a] = butter(4,[13 37]/(fs/2)); 
g1 = eeg1(30001:32500,end);
g2 = eeg2(30001:32500,end);
figure(1)
subplot(211);plot(g1)
subplot(212);plot(g2)

eeg1_filtered = filter(b,a,eeg1);
eeg2_filtered = filter(b,a,eeg2);
EEG1 = eeg1_filtered(30001:32500,end);
EEG2 = eeg2_filtered(30001:32500,end);

figure(2)
subplot(211);plot(EEG1)
subplot(212);plot(EEG2)

result_eeg1 = EEG1';
result_eeg2 = EEG2';
