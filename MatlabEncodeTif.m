[data_directory] = spm_select(1, 'dir' )

pic_directory = sprintf('%s\\Pictures', data_directory)
mkdir(pic_directory)

for k=1:15
    
    cd(data_directory)
    kk = num2str(k(:),'%02d')
    
    file = sprintf('Stimuli_Trn_FullRes_%s.mat', kk)
    
    load(file)
    
    
    cd(pic_directory)
    
    if k < 15
        
        for j=1:120,
            picture = stimTrn(j,:,:);
            picture = squeeze(picture);
            x=-min(picture(:));
            addthis = ones (500,500)*x;
            rescaledpic = picture  + addthis;
            
            %rescaledpic = uint16(rescaledpic);
            rescaledpic = uint16(rescaledpic*65535);
            
            tif = [sprintf('%04d',k) '_' sprintf('%04d',j) '_16bit.tif' ];
            t = Tiff(tif,'w');
            tagstruct.ImageLength = size(rescaledpic, 1);
            tagstruct.ImageWidth = size (rescaledpic, 2);
            tagstruct.Compression = Tiff.Compression.None;
            tagstruct.SampleFormat = 1;
            tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel = 1;
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
            t.setTag(tagstruct);
            t.write(rescaledpic);
            t.close();
        end
        
    else
        
        for j=1:70,
            picture = stimTrn(j,:,:);
            picture = squeeze(picture);
            x=-min(picture(:));
            addthis = ones (500,500)*x;
            rescaledpic = picture  + addthis;
            
            %rescaledpic = uint16(rescaledpic);
            rescaledpic = uint16(rescaledpic*65535);
            
            tif = [sprintf('%04d',k) '_' sprintf('%04d',j) '_16bit.tif' ];
            t = Tiff(tif,'w');
            tagstruct.ImageLength = size(rescaledpic, 1);
            tagstruct.ImageWidth = size (rescaledpic, 2);
            tagstruct.Compression = Tiff.Compression.None;
            tagstruct.SampleFormat = 1;
            tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
            tagstruct.BitsPerSample = 16;
            tagstruct.SamplesPerPixel = 1;
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
            t.setTag(tagstruct);
            t.write(rescaledpic);
            t.close();
        end
        
    end
    
end
