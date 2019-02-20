function NPES_outro(settings)

white = [255 255 255];

% Thanks
Screen('TextSize',settings.screen.outwindow,settings.layout.size.intro);
DrawFormattedText(settings.screen.outwindow, 'Thank you very much for your participation!', 'center', 'center', white); 
Screen('Flip', settings.screen.outwindow); % update screen
WaitSecs(.2); KbWait(-1);

% Clean up
Screen('CloseAll');
PsychPortAudio('Close');
ShowCursor;
Priority(0);
ListenChar(0);

end