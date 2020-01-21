function NGQCBuff=Embed_mat(GQCBuff,ValidBuff,msgfile,block,NeedGQCs,fileflag,M4)

MGQCBuff=GQCBuff; % Locates the modified GQC Buffer.
if(fileflag==1) % File to be Hidden.    
     fid=fopen(msgfile,'r');
end    
indx=1;
inx=1;
while (inx <= NeedGQCs)
     if(ValidBuff(indx)==1)
         if(fileflag==1) % File to be Hidden.    
                  Val=fread(fid,1,'ubit2');
         else            % Blocks to be Hidden.
                  Val=block(inx);
         end 
         switch (Val)
             case 0 
                MGQCBuff{1,indx}=ModTo00(GQCBuff{1,indx},M4);
             case 1
                MGQCBuff{1,indx}=ModTo01(GQCBuff{1,indx},M4);
             case 2
                MGQCBuff{1,indx}=ModTo10(GQCBuff{1,indx},M4);
             case 3
                MGQCBuff{1,indx}=ModTo11(GQCBuff{1,indx},M4);
          end
          inx=inx+1;     
     end 
     indx=indx+1;
end
if(fileflag==1) % Case of File to be Hidden.
     fclose(fid);
end 
% In this point the buffer of 
% GQCs has been modified.
NGQCBuff=MGQCBuff;
