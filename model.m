% Model myogenesis 
function deriv=myogenesis(t,statevar)
global p
kp3 = p(1);
km5 = p(2);
kmd = p(3);
kmi = p(4);

dgp3 = p(5);
dgm5 = p(6);
dgmd = p(7);

Kmi = p(8);
Kp3m5 = p(9);
Km5md = p(10);

n = 5;

pax3 = statevar(1) ;
myf5 = statevar(2) ;
myod = statevar(3) ;


dpax3 = (kp3./(1+(kmi.*myod./(Kmi+myod)))) - dgp3.*pax3 ;

dmyf5 = (km5.*pax3./(Kp3m5+pax3)) - dgm5.*myf5;

dmyod = (kmd.*(myf5.^n)./((Km5md.^n)+(myf5.^n))) - dgmd.*myod;


deriv = [dpax3;dmyf5;dmyod];

end
