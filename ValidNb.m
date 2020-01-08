function  VldNb=ValidNb(ValidBuff)

% Size of ValidBuff.
siz=size(ValidBuff);
Cl=siz(2); % columms.

% Calculates the number
%       of Ones.
cout=0;
for yy=1:Cl
   if (ValidBuff(1,yy)==1)
       cout=cout+1;
   end  
end

% Number of Ones.
VldNb=cout;