function deriv = dydt_myogenesis(t,statevar)

global kp3 km5 kmd kmi 
global dgp3 dgm5 dgmd
global Kmi Kp3m5 Km5md

pax3 = statevar(1) ;
myf5 = statevar(2) ;
myod = statevar(3) ;

dpax3 = (kp3./(1+(kmi.*myod./(Kmi+myod)))) - dgp3.*pax3 ;

dmyf5 = (km5.*pax3./(Kp3m5+pax3)) - dgm5.*myf5;

dmyod = (kmd.*(myf5.^5))./(((Km5md.^5)+(myf5.^5))) - dgmd.*myod;

deriv = [dpax3;dmyf5;dmyod] ;

return