clc;
clear;
 
 
PowerOut2=849;
RPM_Shaft1=750;
EfficiencyHelical=0.98;
helix=15;
modulus=2;                  %ASSUMED !!mm!!
modulusTransverse=modulus/cosd(helix);
NGear=80;                   %ASSUMED
NPinion=NGear/5;            %4 may change
DiameterGear=modulusTransverse*NGear;
DiameterPinion=modulusTransverse*NPinion;
Vgear=pi*DiameterPinion*RPM_Shaft1/60/1000;
Wt=PowerOut2*EfficiencyHelical/Vgear;
FaceWidth=28;               %ASSUMED !!mm!!
PhiTransverse=atand((tand(20))/(cosd(helix)));
 
 
 
%ModifyingFactors
mg=DiameterGear/DiameterPinion;
rp=DiameterPinion/2;
rg=DiameterGear/2;
rbp=rp*cosd(PhiTransverse);
rbg=rg*cosd(PhiTransverse);
a=modulus;
Z=((rp+a)^2-rbp^2)^0.5+((rg+a)^2-rbg^2)^0.5-(rp+rg)*sind(PhiTransverse); %Bu equationa boydan
mn=pi*modulus*cosd(20)/(0.95*Z);
I=cosd(20)*sind(20)/(2*mn)*(mg/(mg+1));
 
JprimeP=0.48; %FIND FROM FÝGURE 14.7
JprimeG=0.63; %FIND FROM FÝGURE 14.7
Jp=0.29; %FIND FROM FIGURE 14.6
Jg=0.40; %FIND FROM FIGURE 14.6
YjGear=Jg*JprimeG;
YjPinion=Jp*JprimeP;
 
Ze=191; %ASSUMED, MPa
 
K0=1; %ASSUMED
 
Qv=7;
Bkv=0.25*(12-Qv)^(2/3);
Akv=50+56*(1-Bkv);
Kv=((Akv+(200*Vgear)^0.5)/Akv)^Bkv;
 
Zr=1; %ASSUMED NO Detrimental Surface Effect
 
Ks=1; %ASSUMED
 
Kb=1; %ASSUMING tr/ht>1.2 (Check 14.16)
 
Cmc=1; %1for uncrowned, 0.8 for crowned teeth


Cpm=1.1; %ASSUMED
Cma=0.15; %FIND FROM FÝGURE 14.11

Ce=1; %ASSUMED
F=FaceWidth;
Cpf=0.05; %F/(10*dGear)<0.025 durumdunda
if(F/(10*DiameterGear)>0.025)
    if(F<=25.4)
        Cpf = F/(10*DiameterGear)-0.025;
    elseif(F<431.8)
        Cpf = F/(10*DiameterGear)-0.0375+0.0125*F;
    end
end

KhGear=1+Cmc*(Cpf*Cpm+Cma*Ce);

if(F/(10*DiameterPinion)>0.025)
    if(F<=25.4)
        Cpf = F/(10*DiameterPinion)-0.025;
    elseif(F<431.8)
        Cpf = F/(10*DiameterPinion)-0.0375+0.0125*F/25.4;
    end
end


KhPinion=1+Cmc*(Cpf*Cpm+Cma*Ce);

 
Kt=1; %No Temperature Effect
Kr=0.85; %Find From Table 14.10
Yn=1.30; %Find from figure 14.14
 
 
 
%Endurance Strength and Safety Factors
HBHelical=220; %Given
St=0.533*HBHelical+88.3; %MPA From figure 14.2
Sc=2.22*HBHelical+200; %MPa

Zn=1.05;

SigmaBendingGear=Wt*K0*Kv*Ks*KhPinion*Kb/YjGear/(modulusTransverse*FaceWidth*10^-6)/10^6; %MPa
FOS_SFGearBending=(St)*Yn/Kt/Kr/SigmaBendingGear;
 
SigmaBendingPinion=Wt*K0*Kv*Ks*KhPinion*Kb/YjPinion/(modulusTransverse*FaceWidth*10^-6)/10^6; %MPa
FOS_SFPinionBending=(St)*Yn/Kt/Kr/SigmaBendingPinion;
 
SigmaWearGear=Ze*(Wt*K0*Kv*Ks*Zr/I*KhPinion/DiameterPinion/FaceWidth)^0.5; %MPa
FOS_SHGearWear=Sc*Zn*1/(Kt*Kr)/SigmaWearGear;
 
SigmaWearPinion=Ze*(Wt*K0*Kv*Ks*Zr/I*KhPinion/DiameterPinion/FaceWidth)^0.5; %MPa
FOS_SHPinionWear=Sc*Zn*1/(Kt*Kr)/SigmaWearPinion;




