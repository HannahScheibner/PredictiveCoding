% CONVERTS ALL TIF FILES IN A FOLDER TO WEBP FORMAT AND SAVES SSMI
% (STRUCTURAL SIMILARITY VALUES
% needs SPM12b installed
% need WEBP converter installed https://developers.google.com/speed/webp/docs/precompiled
% on windows Matlab needs to be started with administrative rights

clear all

[data_directory] = spm_select(1, 'dir' )
[webp_directory] = spm_select(1, 'dir' )

cd(data_directory)

<<<<<<< Updated upstream
[tif_files] = spm_select('FPListRec',data_directory,'.*\.tif$');
[webp_exe] = spm_select('FPListRec',webp_directory,'cwebp.exe');


for i = 1:length(tif_files(:,1));
    
    tif_file = strtrim(tif_files(i,:)
    dos_com = sprintf('%s -lossless -print_ssim  -print_lsim -print_psnr %s -o %s.webp', webp_exe, tif_file, tif_file)
    [status, cmdout] = dos(dos_com)
    k = strfind(cmdout, 'Total:')
    ssim{i,1} = tif_file;
    ssim{i,2} = cmdout(k+6:end);
end
save ssim ssim
=======

[status, cmdout] = dos('C:\webp\bin\cwebp -lossless -print_ssim c:\1_1_16bit.tif -o c:\1_1_16bit.tif_losless.webp', '-echo')


[data_directory] = spm_select(1, 'dir' )



unix('cd data_directory; cwebp -lossless -print_ssim 1_1_16bit.tif -o 1_1_16bit.tif_losless.webp')

unix('cd data_directory; cwebp -lossless -print_ssim 1_1_16bit.tif -o 1_1_16bit.tif_losless.webp')

unix('cwebp -lossless -print_ssim 1_1_16bit.tif -o 1_1_16bit.tif_losless.webp')

unix(cwebp -lossless -print_ssim 1_1_16bit.tif -o 1_1_16bit.tif_losless.webp)



[status, cmdout] = system('alloc')  
system('cd /Users/hannahscheibner/Desktop ; cwebp -lossless -print_ssim 1_1_16bit.tif -o 1_1_16bit.tif_losless.webp')
>>>>>>> Stashed changes
