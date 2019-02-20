function data = NPES_data

disp('Welcome to our experiment');
data.Nr = input('Subject Number: ');
clc; data.training = input('Training? (0/1) ');
if data.training == 0
    %data.irb = input('IRB? ');
    data.age = input('Age? ');
    data.gender = input('Gender? (m/f) ','s');
    data.hand = input('Handedness? (l/r) ','s');
end

end