%Make sure to add path to methods folder in matlab!

cd('D:/Grad School/GitHub/dscr-smash/data');
load('ml_in.txt');
est=recTI(ml_in);
csvwrite('ml_out.csv',est);
exit