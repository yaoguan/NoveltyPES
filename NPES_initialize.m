function settings = NPES_initialize(data)

% reset rng
rng(sum(100*clock),'twister');

% visual digit
numSet = [1:8];

% audio
settings.sound.srate = 44100;
settings.sound.duration = .15;
settings.sound.standardfreq = 600;
InitializePsychSound(1);
settings.sound.audiohandle = PsychPortAudio('Open', [], [], 0, settings.sound.srate, 1);
PsychPortAudio('Volume', settings.sound.audiohandle, 0.5);
load(fullfile(fileparts(which('NPES.m')),'novelsound.mat'));
settings.sound.novelsound = novel';
load(fullfile(fileparts(which('NPES.m')),'standardsound.mat'));
settings.sound.standardsound = standard'; %1 row is 1 channel

% stimuli
white = [255 255 255];
settings.layout.size.intro = 40;
settings.layout.size.fixation = 80;
settings.layout.size.vstim = 150;

% durations
settings.duration.stimulus = .95; %response window: 950ms
settings.duration.fixation1 = .3; %1st fixation: 300ms
settings.duration.tonedelay = .1; %difference between visual digit ONSET and the tone ONSET: 100ms
settings.duration.digitdelay = .15; %difference between visual digit ONSET and next fixation ONSET: 150ms
settings.duration.rsi = .3; % response-stimulus interval 300ms


% screen
screens = Screen('Screens');
settings.screen.Number = max(screens);
[settings.screen.outwindow, settings.screen.outwindowdims] = Screen('Openwindow',settings.screen.Number, 0); % make screen, black bg
Priority(MaxPriority(settings.screen.outwindow)); % prioritize

% folders and files
settings.files.outfolder = fullfile(fileparts(which('NPES.m')),'out',filesep);
clocktime = clock; hrs = num2str(clocktime(4)); mins = num2str(clocktime(5));
settings.files.outfile = ['Subject_' num2str(data.Nr) '_' date '_' hrs '.' mins 'h.mat'];

% psychtoolbox initialize
HideCursor; ListenChar(2); % hide cursor
KbName('UnifyKeyNames'); % unify keyboard
KbCheck; WaitSecs(0.1); GetSecs; % dummy calls

% testmode responses
settings.keys.even = KbName('e');
settings.keys.odd = KbName('o');

% prepare fonts
Screen('TextFont',settings.screen.outwindow,'Helvetica'); % arial
Screen('TextStyle', settings.screen.outwindow, 0); % make normal

end


