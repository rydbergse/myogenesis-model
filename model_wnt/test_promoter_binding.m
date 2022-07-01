function dy = test_promoter_binding(t, y, P)
    
    [KD, k2] = deal(P{:}); 
    
    O = y(1);
    R = y(2);
    OR = y(3);
    
    dy = zeros(3,1);
    dy(1) = KD*k2*OR - k2*O*R;
    dy(2) = KD*k2*OR - k2*O*R;
    dy(3) = k2*O*R - KD*k2*OR;
end