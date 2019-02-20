function NPES_audio(settings,trialseq,it)

id = NPES_columns;

% audio
if trialseq(it,id.astim) == 2
    wavdata = settings.sound.novelsound(sum(trialseq(1:it,id.astim)==2),:);
else wavdata = settings.sound.standardsound;
end

wavdata = wavdata./rms(wavdata); %make sure the audios have the same volumn (signal amplitude envelope)

PsychPortAudio('FillBuffer', settings.sound.audiohandle, wavdata);

end

