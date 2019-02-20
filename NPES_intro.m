function NPES_intro(settings,trialseq,it)

white = [255 255 255];

% set font size
Screen('TextSize',settings.screen.outwindow,settings.layout.size.intro);

% Block 1
if it == 1
    DrawFormattedText(settings.screen.outwindow, 'Press any key to start experiment!', 'center', 'center', white); % set text
    Screen('Flip', settings.screen.outwindow); % update screen
    WaitSecs(.1); KbWait(-1);
end

% Everything else (except last block)
if it < size(trialseq,1)
    DrawFormattedText(settings.screen.outwindow, 'Ready in 3...', 'center', 'center', white); % set text
    Screen('Flip', settings.screen.outwindow); % update screen
    WaitSecs(1);
    DrawFormattedText(settings.screen.outwindow, 'Ready in 2...', 'center', 'center', white); % set text
    Screen('Flip', settings.screen.outwindow); % update screen
    WaitSecs(1);
    DrawFormattedText(settings.screen.outwindow, 'Ready in 1...', 'center', 'center', white); % set text
    Screen('Flip', settings.screen.outwindow); % update screen
    WaitSecs(1);
end


end