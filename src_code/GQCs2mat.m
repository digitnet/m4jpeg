function mat=GQCs2mat(GQCBuff,MatSize)

Rw=MatSize(1); % rows    : Height.
Cl=MatSize(2); % columms : Width.
Mmat=zeros(Rw,Cl);

indx=1;
for xx=1:Rw 
   for yy=1:Cl
        if((mod(xx,2)==1) && (mod(yy,2)==1))
            Mmat(xx,yy)=GQCBuff{1,indx}(1,1);
            Mmat(xx,yy+1)=GQCBuff{1,indx}(1,2);
            Mmat(xx+1,yy)=GQCBuff{1,indx}(2,1);
            Mmat(xx+1,yy+1)=GQCBuff{1,indx}(2,2);
            indx=indx+1;
        end
   end
end
% In this point indx=((Rw*Cl)/4)+1.

mat=Mmat;