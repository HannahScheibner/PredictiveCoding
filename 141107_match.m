clear all
cd('C:\Users\scheibha\Dropbox\14_PC\matlab dateien')
% cd('/Volumes/Transcend/14_PC/05_fmriData')

load('Stimuli.mat')
load('filesizes_trn.txt', '-ascii')


[row,col,v] = find(seqTrn);


 p_Matrix(:,1) = row;
 p_Matrix(:,2) = v;
 p_Matrix(:,3) = col;
 p_Matrix(:,4) = zeros;

 B(:,1)=filesizes_trn(:,1);
 B(:,2)=filesizes_trn(:,4);


  for a = 1:1750;
      r = B(:,2) ==a;
      t = p_Matrix(:,2) ==a;
    
     r= transpose(r)*B(:,1);
     x=r*t;

     p_Matrix(:,4) = p_Matrix(:,4)+x;

    end

save('p_Matrix')
