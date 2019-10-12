function Y = YPiTopology(Y1, Y2, Y3)
%PITOPOLOGY Generates the admitance matrix of three admitances set in a PI
%topology
Y = [ Y1+Y2 -Y2     ;
     -Y2     Y2+Y3 ];
end

