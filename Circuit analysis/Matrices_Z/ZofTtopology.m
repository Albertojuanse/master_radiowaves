function Z = ZofTtopology(Z1, Z2, Z3)
%ZOFTTOPOLOGY Generates the impedance matrix of three impedances set in a T
%topology
Z = [ Z1+Z2 -Z2     ;
     -Z2     Z2+Z3 ];
end

