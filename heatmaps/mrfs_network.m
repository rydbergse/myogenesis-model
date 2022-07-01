function dydt = mrfs_network(t,y,p)
    
    % Parameters
    P = num2cell(p);
    [kp3, km5, kmd, kmi, kmg, dp3, dm5, dmd, dmg, Kmi, Kp3m5, ...
        Km5md, Kp3md, Kmdmg, Kmg, kp7, Kmgp7, dp7, tp7md, ...
        N, W, S, B] = deal(P{:});
    n = 5;
    m = 2;
    
    % State variables
    Pax3 = y(1);
    Pax7 = y(2);
    Myf5 = y(3);
    MyoD = y(4);
    MyoG = y(5);
    
    % ODEs
    dydt = zeros(5,1);
    dydt(1) = kp3./(1+kmi*((MyoD)/(Kmi+MyoD))) - dp3*Pax3;
    dydt(2) = kp7*N/(1 + N + (MyoG/Kmgp7) ) - dp7*Pax7;
    dydt(3) = km5*((Pax3/Kp3m5) + (W*S))/(1 + (Pax3/Kp3m5) + (W*S)) ...
        - dm5*Myf5;
    dydt(4) = kmd*((Myf5/Km5md).^n + (Pax3/Kp3md).^n)/(1 + (Myf5/Km5md).^n + (Pax3/Kp3md).^n) ...
        -(tp7md*Pax7 + B)*MyoD - dmd*MyoD;
    dydt(5) = kmg*((MyoD/Kmdmg).^m + (MyoG/Kmg).^m)/(1 + (MyoD/Kmdmg).^m + (MyoG/Kmg).^m) - dmg*MyoG;

    
    
end