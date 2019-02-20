c=0;
for i = 1:1280
if trialseq(i,6)==2 && trialseq(i+1,3)==2
    fprintf(['i=' num2str(i) '\n']) %print NPES trial
    c = 1+c; %number of NPES trials
end
end

error = sum(trialseq(:,6)==2);
miss = sum(trialseq(:,7)==0);
rt = sum(trialseq(:,7))/(1280-miss);
fprintf(['post-error novel=' num2str(c) '\n'])
fprintf(['error=' num2str(error) '\n'])
fprintf(['miss=' num2str(miss) '\n'])
fprintf(['rt=' num2str(rt) 'ms\n'])