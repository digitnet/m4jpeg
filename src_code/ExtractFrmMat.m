function BLK = ExtractFrmMat(UsedGQCs,GQCBuff,ValidBuff,Extrfile,Outfile)
% Summary of this function goes here
%   
  if(Extrfile == 1)
     fid=fopen(Outfile,'w');
  else
    %B = zeros(m,n) or B = zeros([m n]) returns an m-by-n matrix of zeros.
    block = zeros(1,UsedGQCs);
  end
    
  ValidCnt=0;
  indx=1;
  while(ValidCnt < UsedGQCs)
       if(ValidBuff(1,indx)==1)
            ValidCnt=ValidCnt+1;
            GQC=GQCBuff{1,indx};
            % Calculating the Modulu:
            %   the Embeded Value.
            Sum=0;
            for xx=1:2 
               for yy=1:2
                   Sum=Sum+GQC(xx,yy);
               end
            end
            Mod=mod(Sum,4);
            
            if(Extrfile == 1)
                count=fwrite(fid,Mod,'ubit2');
            else
                block(ValidCnt)=Mod;    
            end
            
       end 
       indx=indx+1;
  end
  
  if(Extrfile == 1)
      fclose(fid);
      BLK=0;
  else
      BLK=block;
  end
end


   
  