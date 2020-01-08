function  OutGQC=ModTo11(InGQC,M4)


MdGQC=InGQC;
P=zeros(4,3);
N=zeros(4,3);

Pcn=0;
Ncn=0;  

for xx=1:2 
   for yy=1:2
        if(InGQC(xx,yy)> M4(1))
           Pcn= Pcn+1;
           P(Pcn,1)=InGQC(xx,yy);
           P(Pcn,2)=xx;
           P(Pcn,3)=yy;
        end
        if(InGQC(xx,yy)< -M4(2))
           Ncn= Ncn+1;
           N(Ncn,1)=InGQC(xx,yy);
           N(Ncn,2)=xx;
           N(Ncn,3)=yy;
        end
   end
end  

P = flipud(sortrows(P));
N = sortrows(N);
%%%
% Calculating the actual Modulu
%      of the input GQC.
Sum=0;
for xx=1:2 
   for yy=1:2
      Sum=Sum+InGQC(xx,yy);
   end
end
OldMod=mod(Sum,4);

%%%
% Modifing the qDCTCs in P and N
%    sets to achieve Modulu=3.

switch (OldMod)
   case 0
      N(1,1)=N(1,1)-1; 
   case 1
       if(Pcn==1 && Ncn==1)
           if(P(1,1)>=abs(N(1,1)))
               P(1,1)=P(1,1)+2;
           else
               N(1,1)=N(1,1)-2;
           end
       end
       if(Pcn==2 && Ncn==1)
           P(1,1)=P(1,1)+1;
           P(2,1)=P(2,1)+1;
       end
       if(Pcn==2 && Ncn==2)
           if(P(1,1)>=abs(N(1,1)))
              P(1,1)=P(1,1)+1;
              P(2,1)=P(2,1)+1;
           else
              N(1,1)=N(1,1)-1;
              N(2,1)=N(2,1)-1;
           end
       end
       if(Pcn==3 && Ncn==1)
          P(1,1)=P(1,1)+1;
          P(2,1)=P(2,1)+1;
       end
       if(Pcn==1 && Ncn==2)
          N(1,1)=N(1,1)-1;
          N(2,1)=N(2,1)-1; 
       end
       if(Pcn==1 && Ncn==3)
          N(1,1)=N(1,1)-1;
          N(2,1)=N(2,1)-1; 
       end
   case 2
      P(1,1)=P(1,1)+1;
end

for i=1:4
  if(P(i,2)~=0 && P(i,3)~=0)  
    MdGQC(P(i,2),P(i,3))=P(i,1);
  end
  if(N(i,2)~=0 && N(i,3)~=0)  
    MdGQC(N(i,2),N(i,3))=N(i,1);
  end   
end

Sum=0;
for xx=1:2 
   for yy=1:2
      Sum=Sum+MdGQC(xx,yy);
   end
end

NewMod=mod(Sum,4);

if(NewMod==3)
  OutGQC=MdGQC;
else
  disp('Changement is not correct...!!');
end





