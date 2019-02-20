function id = NPES_columns

% data columns
id.num = 1; %trialnum
id.blo = 2; %blocknum
id.astim = 3; %auditory stimulus 1=standard 2=deviation
id.vstim = 4; %visual digit 1-8
id.resp = 5; %behav response 1=odd or 2=even
id.acc = 6; %accuracy, 1=cor go,2=err,99=miss
id.rt = 7;
id.latency = 8;

end