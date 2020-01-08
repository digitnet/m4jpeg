function Key32b = HashKeyStr(strgkey)

% Detailed explanation goes here
% Input argument StrgKey is The string Key entered by user.
% this function is going to hash the enterd string key in order to give
% a 32-bit integer.

dim = size(strgkey);  % Gives size matrix.
keyleng=dim(1,2);     % keyleng is the length of key.

DFT= mod(keyleng,4);  % DFT is 0,1,2 or 3.

intkey=double(strgkey);

switch (DFT)
   case 1
   intkey(1)=bitxor(intkey(1),intkey(keyleng));
   case 2
   intkey(1)=bitxor(intkey(1),intkey(keyleng));
   intkey(5)=bitxor(intkey(5),intkey(keyleng-1));
   case 3
   intkey(1)=bitxor(intkey(1),intkey(keyleng));
   intkey(5)=bitxor(intkey(5),intkey(keyleng-1));
   intkey(9)=bitxor(intkey(9),intkey(keyleng-2));
end
    
keyleng= keyleng-DFT; % New Key Length.
kloop=(keyleng/4)-1;

for ko=1:kloop
  intkey(1)= bitxor(intkey(1),intkey((4*ko)+1));  
  intkey(2)= bitxor(intkey(2),intkey((4*ko)+2));
  intkey(3)= bitxor(intkey(3),intkey((4*ko)+3));
  intkey(4)= bitxor(intkey(4),intkey((4*ko)+4));
end

Key32b=intkey(1)+(256*intkey(2))+(65536*intkey(3))+(16777216*intkey(4));
% It is a 32-bits key so it will be assigned to seed.
end

