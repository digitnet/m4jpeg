function  ValBuff=ValidTest(GQCBuff,M4)

% M4(Ph1,Ph2,t1,t2).

siz=size(GQCBuff);
Cl=siz(2); % columms.

for yy=1:Cl
   ValBuff(1,yy)=GQCTest(GQCBuff{1,yy},M4);  
end