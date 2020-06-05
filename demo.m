%   LMP returns the local morphological pattern histogram of an image depending on what mapping is used.
%   The original getmapping code of LBP is used and updated to the LMP by Swalpa Kumar Roy, CVPR Unit, ISI Kolkata.
%   This code can be used only for the academic and research purposes and can not be used for any commercial purposes.
%   Cite the paper 'S.K. Roy, B. Chanda, B.B. Chaudhuri, D.K. Ghosh, and S.R. Dubey, 
%   "Local Morphological Pattern: A Scale Space Shape Descriptor for Texture Classification", 
%   Digital Signal Processing, Elsevier, vol. 82, pp. 152-165, 2018',
%   In case you are using this code.

%   Possible values for MODE are
%       'h' or 'hist'  to get a histogram of LZP codes
%       'nh'           to get a normalized histogram

 clc
 clear all
 close all
  
% Path or Directory for the datasets
 dn = '/home/swalpa/Desktop/LBP/Brodatz32/Data/'
 db=dir(strcat(dn,'*.png'));
 k=1;
 tic
 feature = [];
 
 
 % Radius and Neighborhood
 R1 = 1;
 R2 = 2;
 P = 8;
 
 % LBP needed a mapping function
 patternMappingriu2 = getmapping(P,'u2');
 
 
 
 for(i=1:1:length(db))

     fname=db(i).name;
     fname=strcat(dn,fname);
     im=imread(fname);
     
    % Color Conversion
     if length(size(im)) == 3
        im = rgb2gray(im);
     end
     
     
     
    %%Simple Local Binary Pattern on the original Image
     
     Gray = im2double(im); 
     Gray = (Gray-mean(Gray(:)))/std(Gray(:))*20+128; % image normalization, to remove global intensity 
     
     [dilation erosion opened closed] = LMP(im);
     
     LBP_F1 = lbp(dilation, R1, P, patternMappingriu2,'nh');
     
     LBP_F2 = lbp(erosion, R2, P, patternMappingriu2,'nh');
     
     LBP_F3 = lbp(opened, R1, P, patternMappingriu2,'nh');
     
     LBP_F4 = lbp(closed, R2, P, patternMappingriu2,'nh');
    
     % This R = 1 and R = 2 feature is also gives outstanding results
     %feature = [feature; LBP_F1 LBP_F2];
     
     feature = [feature; LBP_F1 LBP_F2 LBP_F3 LBP_F4];
     %feature = [feature; LBP_F3 LBP_F4];
     
     k=k+1   
 end; 
 k-1
 
save('LMPu2','feature');
xlswrite('LMPu2.xlsx',feature);

toc
