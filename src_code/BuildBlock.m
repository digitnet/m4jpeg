function blockout = BuildBlock(extn)
% 
% 

  block=[0,0,0,0,0,0,0,0,0,0,0,0];

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
       block(k) = bitand(extn(z), 3);
       extn(z) = bitshift(extn(z), -2);
  end

  blockout=block;

end

