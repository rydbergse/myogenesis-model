function dy = bmp_model(t,y,p,t_signal)  
    
    % Initial conditions
    BMPR1 = y(1); 
    BMPR2 = y(2); 
    C1 = y(3); 
    C2 = y(4);
    C2P = y(5);
    C3 = y(6);
    SMAD = y(7);
    SMADP = y(8);
    SMAD4 = y(9);
    C4_c = y(10);
    C4_n = y(11);
    Id = y(12);
    MyoD = y(13);
    C5 = y(14);
    
    % Parameters
    parameters = num2cell(p);
    [k1, k2, BMP4, k3, k4, Vmax_K, Km_K, Vmax_P, Km_P, Vmax_P2, Km_P2, k5, k6, k7, k8, k9,...
        k10, k11, k12, k13, d, Trs_max, Kd]= deal(parameters{:});
    

    if t > max(t_signal) || t < min(t_signal)
        BMP4 = 0;
    end
    
    % Differential equations
    dy = zeros(14,1);
    dy(1) = k1.*C1 - k2.*BMP4.*BMPR1 ;
    dy(2) = k3.*C2 - k4.*C1.*BMPR2;
    dy(3) = k2.*BMP4.*BMPR1 - k1.*C1 + k3.*C2 - k4.*C1.*BMPR2;
    dy(4) = k4.*C1.*BMPR2 - k3.*C2 - Vmax_K.*C2./(Km_K + C2) + Vmax_P.*C2P./(Km_P + C2P);
    dy(5) = Vmax_K.*C2./(Km_K + C2) - Vmax_P.*C2P./(Km_P + C2P) - k5.*SMAD*C2P + (k6+k7).*C3;
    dy(6) = k5.*SMAD.*C2P - k6.*C3 - k7.*C3;
    dy(7) = k6.*C3 - k5.*SMAD.*C2P + Vmax_P2.*SMADP./(Km_P2 + SMADP);
    dy(8) = k7.*C3 - Vmax_P2.*SMADP./(Km_P2 + SMADP) + k8.*C4_c - k9.*SMADP.*SMAD4;
    dy(9) = k8.*C4_c - k9.*SMADP.*SMAD4;
    dy(10) = k9.*SMADP.*SMAD4 - k8.*C4_c - k10.*C4_c + k11.*C4_n;
    dy(11) = k10.*C4_c - k11.*C4_n;
    dy(12) = Trs_max.*C4_n./(Kd + C4_n) - k12.*MyoD.*Id + k13.*C5 - d.*Id;
    dy(13) = k13.*C5 - k12.*MyoD.*Id;
    dy(14) = k12.*MyoD.*Id - k13.*C5;
    
    variables = {'BMPR1', 'BMPR2', 'BMP4-BMPR1', 'BMP4-BMPR1-BMPR2', 'BMP4-BMPR1P-BMPR2',...
    'SMAD1/5/8', 'BMP4-BMPR1P-BMPR2-SMAD1/5/8', 'SMAD1/5/8-P', 'SMAD4', 'SMAD1/5/8-P-SMAD4',...
    'SMAD1/5/8-P-SMAD4_{nuclear}', 'Id', 'MyoD', 'Id-MyoD'};
    
end