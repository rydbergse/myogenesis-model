function dy = noncanonical_wnt_model(t,y,p)
    
    C1nc = y(1);
    Ga = y(2);
    PIP2 = y(3);
    DAG = y(4);
    IP3 = y(5);
    Ca2 = y(6);
    Pax3 = y(7);
    MyoD = y(8);
    
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
    k13 = p(13);
    k14 = p(14);
    K1 = p(15);
    K2 = p(16);
    K3 = p(17);
    K4 = p(18);
    K5 = p(19);
    K6 = p(20);
    n = p(21);
    Wnt7a = p(22);
    Fzd7 = p(23);
    Gt = p(24);
    PIP2ref = p(25);
    Ca2ref = p(26);
    
    if t < 5
        Wnt7a = 0;
    end
    

    dy = zeros(8,1);
   
    dy(1) = k1*Wnt7a*(Fzd7 - C1nc) - k2*C1nc;
    dy(2) = k3*C1nc*(Gt - Ga)./(K1 + (Gt - Ga)) - k4*Ga;
    dy(3) = k5*(PIP2ref - PIP2) - k6*(Ga./(K2+Ga))*PIP2./(K3 + PIP2);
    dy(4) = k6*(Ga./(K2+Ga))*PIP2./(K3 + PIP2) - k7*DAG ;
    dy(5) = k6*(Ga./(K2+Ga))*PIP2./(K3 + PIP2) - k8*IP3;
    dy(6) = k9*IP3./(K4+IP3) - k10*(Ca2-Ca2ref);
    dy(7) = k11*DAG*Ca2./(K5 + DAG*Ca2) - k12*Pax3;
    dy(8) = k13*(Pax3.^n)./((K6.^n) + (Pax3.^n)) - k14*MyoD;
    
end