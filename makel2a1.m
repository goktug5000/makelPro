clc;
clear;

dGear=180;      %ASSUME
F=40;       %ASSUME
Cpm=1.1;    %ASSUME
Ce=1;       %ASSUME
dPinion=60;     %dolayl?


%For Commercial, enclosed units
A=0.127;
B=0.0158;
C=-0.930*(10^-4);
Cma=A+B*F+C*F*F;



Cpf=0.05; %F/(10*dGear)<0.025 durumdunda
if(F/(10*dGear)>0.025)
    if(F<=25.4)
        Cpf = F/(10*dGear)-0.025;
    elseif(F<431.8)
        Cpf = F/(10*dGear)-0.0375+0.0125*F;
    end
end

Cmc=1;
KhGear=1+Cmc*(Cpf*Cpm+Cma*Ce);

if(F/(10*dPinion)>0.025)
    if(F<=25.4)
        Cpf = F/(10*dPinion)-0.025;
    elseif(F<431.8)
        Cpf = F/(10*dPinion)-0.0375+0.0125*F;
    end
end
Cpf=0.9;
KhPinion=1+Cmc*(Cpf*Cpm+Cma*Ce);







b=F;
mt=3;   %mm

V=2.356;        %hesapland?
eFspur=0.92;
Pout=1274;

Wt=Pout*eFspur/V;
K0=1;
Kv=1.23;    %14-28 den hesapland? Qv7 varsayd?m
Ks=1;


Kt=1;           %tr/hr>1.2 dedim ASSUME
YjPinion=0.33;         %figure 14.6
YjGear=0.41;           %figure 14.6


SigmaBendingPinion=Wt*K0*Kv*Ks*(1/(b*mt))*KhPinion*Kt/YjPinion; %MPa
SigmaBendingGear=Wt*K0*Kv*Ks*(1/(b*mt))*KhPinion*Kt/YjGear; %MPa

Kr=0.85;    %tablo
Yn=1.25;     %tablo

St=189.6;
FOSbendPin=St*Yn/(Kt*Kr)/SigmaBendingPinion;
FOSbendGear=St*Yn/(Kt*Kr)/SigmaBendingGear;
dw=dPinion;


Ze=191;
Zr=1;
mN=1;       %spur ise 1
mg=3;
Zi=cosd(20)*sind(20)*mg/(2*mN*(mg+1));
SigmaWPinion=Ze*(Wt*K0*Kv*Ks*KhPinion*Zr*(1/(dw*b))*(1/Zi))^(1/2);
SigmaWGear=Ze*(Wt*K0*Kv*Ks*KhPinion*Zr*(1/(dw*b))*(1/Zi))^(1/2);

Zn=1.05;
Sc=621.8;
Ch=1;
FOSwPinion=Sc*Zn*Ch/(Kt*Kr)/SigmaWPinion;
FOSwGear=Sc*Zn*Ch/(Kt*Kr)/SigmaWPinion;
