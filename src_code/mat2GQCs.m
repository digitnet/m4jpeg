function  GQCBuff=mat2GQCs(mat)

% Calculating Size of 
%    input matrix.
siz=size(mat);
Rw=siz(1); % rows    : Height.
Cl=siz(2); % columms : Width.

GQC=zeros(2,2);
indx=0;
for xx=1:Rw 
   for yy=1:Cl
        if((mod(xx,2)==1) && (mod(yy,2)==1))
            GQC(1,1)=mat(xx,yy);
            GQC(1,2)=mat(xx,yy+1);
            GQC(2,1)=mat(xx+1,yy);
            GQC(2,2)=mat(xx+1,yy+1);
            indx=indx+1;
            GQCBuff{1,indx}=GQC;
            GQC=zeros(2,2);
        end
   end
end
% in this point indx=(Rw*Cl)/4.