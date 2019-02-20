%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NPES task by Yao Guan
% Psychtoolbox 3.0.12 / Matlab 2017a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initiate
addpath(genpath(fileparts(which('NPES.m')))); clc; clear;
%Screen('Preference', 'SkipSyncTests', 1);
commandwindow;

% Subject info
data = NPES_data;

% Initializesca
settings = NPES_initialize(data);

% Experiment
NPES_backend(settings,data);

% Outro
NPES_outro(settings);

