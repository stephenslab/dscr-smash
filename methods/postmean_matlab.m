%addpath('~/WavDen/codes');
%addpath(genpath('~/Wavelab850'))
%cd('~/dscr-smash/data');

%add path to WavDen and Wavelab to matlab
cd('D:/Grad School/GitHub/dscr-smash/data');
load('ml_in.txt');
est=recsinglemean(ml_in,[0.1,1]);
csvwrite('ml_out.csv',est);
exit
