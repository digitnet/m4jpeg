function  Valid=GQCTest(GQC,M4)

% M4(?1,?2,?1,?2).
Pcnt=0;
Ncnt=0;
for xx=1:2 
   for yy=1:2
        if(GQC(xx,yy)> M4(1))
           Pcnt= Pcnt+1;
        end
        if(GQC(xx,yy)< -M4(2))
           Ncnt= Ncnt+1;
        end
   end
end

%%%
% M4(?1,?2,?1,?2).
if(Pcnt >= M4(3) && Ncnt >= M4(4))
    Valid=1;
else
    Valid=0;
end