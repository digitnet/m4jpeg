function [Error Cap]= CoverJpegTest(OrignIm,M4)
% UNTITLED3 Summary of this function goes here
% Detailed explanation goes here
%%%%%%%
BuffMax=1500000;
ChroMin=128;
%%%%%%%
JPG=jpeg_read(OrignIm);      %OK
BuffLine=(JPG.image_width * JPG.image_height)/4;

if(BuffLine < BuffMax )
   jp_compn=JPG.jpeg_components;
   im_compn=JPG.image_components;
   if(jp_compn==3 && im_compn==3) 
       % We have Three components.
       %%%%%%%%
       mat1=JPG.coef_arrays{1};     %OK
       GQCBuff1=mat2GQCs(mat1);     %OK
       ValidBuff1=ValidTest(GQCBuff1,M4);  %OK
       VldNb1=ValidNb(ValidBuff1);    %OK
       Cap=VldNb1*2;            % Real Capacity in Bits.
       Cap=(Cap-mod(Cap,8))/8;  % Real Capacity in Bytes.
       clear mat1 GQCBuff1 ValidBuff1;
       %%%%%%%%
       mat2=JPG.coef_arrays{2};           %OK
       GQCBuff2=mat2GQCs(mat2);           %OK
       ValidBuff2=ValidTest(GQCBuff2,M4); %OK
       VldNb2=ValidNb(ValidBuff2);    %OK    
       clear mat2 GQCBuff2 ValidBuff2;
       %%%%%%%%
       mat3=JPG.coef_arrays{3};           %OK
       GQCBuff3=mat2GQCs(mat3);           %OK
       ValidBuff3=ValidTest(GQCBuff3,M4); %OK
       VldNb3=ValidNb(ValidBuff3);    %OK     
       clear mat3 GQCBuff3 ValidBuff3;
       %%%%%%%%
       if (VldNb2 >= ChroMin) && (VldNb3 >= ChroMin)
           Error=0; %   There are NO errors.           
       elseif (VldNb2 < ChroMin) && (VldNb3 >= ChroMin)
           Cap=0;Error=1;
       elseif (VldNb2 >= ChroMin) && (VldNb3 < ChroMin)
           Cap=0;Error=2;
       elseif (VldNb2 < ChroMin) && (VldNb3 < ChroMin)
           Cap=0;Error=3;
       end
       %%%%%%%%
   else
       % We have less than three components.
       Cap=0;
       Error=4;       
   end
elseif(BuffLine >= BuffMax)
    Cap=0;
    Error=5; % Image is too large.   
end
end

