function [trialseq,traces] = NPES_backend(settings,data)

% shorthands
OW = settings.screen.outwindow;
white = [255 255 255];
numSet = [1:8];

% columns
id = NPES_columns;

% sequence
if data.training == 0 %testing trials
    load(fullfile(fileparts(which('NPES.m')),'test.mat'));
else %training trials
    load(fullfile(fileparts(which('NPES.m')),'practice.mat'));
end

% prepare audio stim
NPES_audio(settings,trialseq,1);

% response traces
traces = zeros(size(trialseq,1),settings.duration.stimulus*1000,2);

% intro
NPES_intro(settings,trialseq,1);

% trial loop
for it = 1:size(trialseq,1)
    
    % log time
    if it == 1; begintime = GetSecs; end
    trialseq(it,id.latency) = GetSecs - begintime;
    
    % 1st fixation
    Screen('TextSize',OW,settings.layout.size.fixation); % reset font size
    DrawFormattedText(OW, '+', 'center', 'center', white);
    trialstart = Screen('Flip', OW);
    WaitSecs(settings.duration.fixation1);
    
    % visual stimulus
    Screen('TextSize',OW,settings.layout.size.vstim); % reset font size
    DrawFormattedText(OW, num2str(trialseq(it,id.vstim)), 'center', 'center', white);
    vstimonset = Screen('Flip', OW); % update screen
    
    % response window
    DisableKeysForKbCheck('empty'); % enable all keys % set two toggles: has the tone been played?
    fixationshowed = false;
    
    while (GetSecs - vstimonset) <= settings.duration.stimulus
        
        [keytoggle, responset, keycode] = KbCheck; % check for response
        
        % 2n fixation
        if ~fixationshowed && (GetSecs - vstimonset) >= settings.duration.digitdelay
            Screen('TextSize',OW,settings.layout.size.fixation);
            DrawFormattedText(OW, '+', 'center', 'center', white);
            Screen('Flip', OW);
            fixationshowed = true;
        end
        
        % record response and rt
        if keycode(settings.keys.odd)==1
            trialseq(it,id.resp) = 1; %odd
            DisableKeysForKbCheck([settings.keys.even,settings.keys.odd]); % disable odd/even keys- only the first press counts
            trialseq(it,id.rt) = responset - vstimonset;
            break
        elseif keycode(settings.keys.even)==1
            trialseq(it,id.resp) = 2; %even
            DisableKeysForKbCheck([settings.keys.even,settings.keys.odd]); % disable odd/even keys
            trialseq(it,id.rt) = responset - vstimonset;
            break
        end
        WaitSecs(0.001); % prevent overload
        
    end
    
    if trialseq(it,id.resp) > 0 
        WaitSecs(settings.duration.tonedelay);
        PsychPortAudio('Start', settings.sound.audiohandle, 1, 0, 1); % play tone
    else
        endtrial = GetSecs;
    end
    
    % calulate acc
    if trialseq(it,id.resp) == 0;
        trialseq(it,id.acc) = 99;
    elseif trialseq(it,id.resp) == 2 && mod(trialseq(it,id.vstim),2)==0;
        trialseq(it,id.acc) = 1;
    elseif trialseq(it,id.resp) == 1 && mod(trialseq(it,id.vstim),2)==1;
        trialseq(it,id.acc) = 1;
    else
        trialseq(it,id.acc) = 2;
    end
    
    % prep next audio stimulus
    if it < size(trialseq,1); NPES_audio(settings,trialseq,it+1); end
    
    % save
    save(fullfile(settings.files.outfolder,settings.files.outfile),'trialseq','settings','data');
    
    % blockfeedback
    NPES_blockfeedback(settings,trialseq,it);
    
    %Response-Stimulus Interval
    if trialseq(it,id.resp) > 0 
        while (GetSecs - responset) <= settings.duration.rsi
        end
    else
        while (GetSecs - endtrial) <= settings.duration.rsi
        end
    end
          
end

% fullsave
save(fullfile(settings.files.outfolder,settings.files.outfile),'trialseq','settings','traces','data');