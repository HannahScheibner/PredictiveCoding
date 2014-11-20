

for k=1:14
cd('/Volumes/Transcend/14_PC/04_Image Data')    
file = ['Stimuli_Trn_FullRes_' int2str(k) '.mat']    
load(file)
cd('/Volumes/Transcend/14_PC/01_Pictures')

    for j=1:120,
        picture = stimTrn(j,:,:);
        picture = squeeze(picture);
        x=-min(picture(:));
        addthis = ones (500,500)*x;
        rescaledpic = picture  + addthis;

        %rescaledpic = uint16(rescaledpic);
        rescaledpic = uint16(rescaledpic*65535);

        tif = [int2str(k) '_' int2str(j) '_16bit.tif' ];
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

cd('/Volumes/Transcend/14_PC/04_Image Data')    
file = ['Stimuli_Trn_FullRes_15.mat']    
load(file)
cd('/Volumes/Transcend/14_PC/01_Pictures')

for j=1:70,
        picture = stimTrn(j,:,:);
        picture = squeeze(picture);
        x=-min(picture(:));
        addthis = ones (500,500)*x;
        rescaledpic = picture  + addthis;

        %rescaledpic = uint16(rescaledpic);
        rescaledpic = uint16(rescaledpic*65535);

        tif = ['15_' int2str(j) '_16bit.tif' ];
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
