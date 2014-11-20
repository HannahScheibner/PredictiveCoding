clear all
cd('C:\Users\scheibha\Dropbox\14_PC\matlab dateien')
% cd('/Volumes/Transcend/14_PC/05_fmriData')

load('Stimuli.mat')
load('filesizes_trn.txt', '-ascii')


[row,col,v] = find(seqTrn(:,1));

filesizes_trn(:,1) = zscore(filesizes_trn(:,1));

for b = 1:25
    
    [row,col,v] = find(seqTrn(:,b));


    AllData_Matrix{b}(:,1) = row;
    AllData_Matrix{b}(:,2) = v;
    AllData_Matrix{b}(:,3) = zeros;

    B(:,1)=filesizes_trn(:,1);
    B(:,2)=filesizes_trn(:,4);


  for a = 1:1750;
      r = B(:,2) ==a;
      t = AllData_Matrix{b}(:,2) ==a;
    
     r= transpose(r)*B(:,1);
     x=r*t;

     AllData_Matrix{b}(:,3) = AllData_Matrix{b}(:,3)+x;

  end

end


% some tests
filesizes_trn(1:10,:)
mean(filesizes_trn(:,1))
std(filesizes_trn(:,1))

AllData_Matrix{10}(1:10,:)

%save data

save('AllData_Matrix')


