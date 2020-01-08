function extn = buildextn(block)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

extn=[0,0,0];
 
for k=1:12
 switch (k)
   case 1
        z=1;
   case 2
        z=1;      
   case 3
        z=1;
   case 4
        z=1;  
   case 5
     z=2;       
   case 6
     z=2;
   case 7
     z=2;
   case 8
     z=2;
   case 9
        z=3;        
   case 10
        z=3;
   case 11
        z=3;
   case 12
        z=3;       
 end
 
 extn(4-z) = bitshift(extn(4-z), +2);   
 extn(4-z) = bitor(extn(4-z),block(13-k));   
end


end

