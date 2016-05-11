addpath('~/WavDen/codes');
addpath(genpath('~/Wavelab850'))
cd('~/dscr-smash/input');

%add path to WavDen and Wavelab to matlab
%cd('D:/Grad School/GitHub/dscr-smash/input');
load('ml_in.txt');
est = recneighblock(ml_in);
csvwrite('ml_out.csv', est);
exit

