function dy = canonical_wnt_model(t,y,p)
    
    k1 = p(1);
    k2 = p(2);
    k3 = p(3);
    k4 = p(4);
    k5 = p(5);
    k6 = p(6);
    k7 = p(7);
    k8 = p(8);
    k9 = p(9);
    k10 = p(10);
    k11 = p(11);
    k12 = p(12);
    K1 = p(13);
    K2 = p(14);
    n = p(15);
    Wnt1 = p(16);
    Fzd1 = p(17);
    Dsh = p(18);
    GSK3B = p(19);
    
    if t < 20
        Wnt1 = 0;
    end
    
    C1 = y(1);
    C2 = y(2);
    C3 = y(3);
    bc = y(4);
    bcn = y(5);
    myf5 = y(6);
    
    dy = zeros(6,1);
   
    dy(1) = k1*Wnt1*(Fzd1 - C1) - k2*C1;
    dy(2) = k3*C1*(Dsh - C2) - k4*C2;
    dy(3) = k5*C2*(GSK3B - C3) - k6*C3;
    dy(4) = k7 + k8*bcn - k9*bc - (k10*(GSK3B - C3)*bc./(K1 + bc));
    dy(5) = k9*bc - k8*bcn;
    dy(6) = k11*(bcn.^n)./((K2.^n) + (bcn.^n)) - k12*myf5;
    
end