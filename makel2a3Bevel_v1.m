clc;
clear;

 
 
Power3=832.02;
RpmShaft3=150;
EfficiencyBevel=0.98;
modulus=3;                  %ASSUMED !!mm!!
NGear=80;                   %ASSUMED
NPinion=NGear/2;            %2 may change
DiameterGear=modulus*NGear;
DiameterPinion=modulus*NPinion;
Vgear=DiameterPinion/1000*RpmShaft3*pi/60;
Wt=Power3*EfficiencyBevel/Vgear;
FaceWidth=30;               %ASSUMED !!mm!!
Cycle=10^6;                 %GIVEN
GearRatio=2; %ASSUMED
 
%ModifyingFactors
Ka=1;
 
Qv=7;
Bkv=0.25*(12-Qv)^(2/3);
Akv=50+56*(1-Bkv);
Kv=((Akv+(200*Vgear)^0.5)/Akv)^Bkv;
 
Zx=0.00492*FaceWidth+0.4375; %CHECK 15.9
 
Yx=0.4867+0.008339*modulus;
 
Kmb=1.1; %CHeck 15.11
Khb=Kmb+5.6*FaceWidth^2*10^-6;
 
Zxc=2; %ASSUMED 15.12
 
Yb=1;
 
I=0.098; %Find From fig15.6;
 
Yj=0.31; %Find From fig15.7;
 
Zntpinion=3.4822*Cycle^(-0.0602); %Check 15.14
Zntgear=3.4822*(Cycle/GearRatio)^(-0.0602); %Check 15.14
 
Yntpinion=6.1514*Cycle^(-0.1182); %Check 15.15
Yntgear=6.1514*(Cycle/GearRatio)^(-0.1182); %Check 15.15
 
Zw=1;
 
Kt=1;
 
Zz=0.92; %Check Table 15.3
Yz=0.85; %Check Table 15.3
 
Ze=191; %ASSUMED, MPa
 
 

 
SigmaHPinion=Ze*(Wt*Ka*Kv*Khb*Zx*Zxc/(FaceWidth*DiameterPinion*I))^0.5; %15.1 CHECK THE FORMULA
SigmaHGear=Ze*(Wt*Ka*Kv*Khb*Zx*Zxc/(FaceWidth*DiameterGear*I))^0.5;
 

 
SigmaF=Wt*Ka*Kv*Yx*Khb/(FaceWidth*modulus*Yb*Yj);


%Endurance Strength and Safety Factors
Hb=200; %Given
SigmaHLimit=2.35*Hb+162.89; %Figure15.12 !!MPA!!
SigmaFLimit=0.3*Hb+14.48; %Figure15.13 !!MPA!!

SigmaHPermissibleContactGear=SigmaHLimit*Zntgear*Zw/(Kt*Zz);
SigmaHPermissibleContactPinion=SigmaHLimit*Zntpinion*Zw/(Kt*Zz);

SigmaFPermissibleBendingGear=SigmaFLimit*Yntgear/(Kt*Yz);
SigmaFPermissibleBendingPinion=SigmaFLimit*Yntpinion/(Kt*Yz);
 
FOS_SHPinion=SigmaHPermissibleContactGear/SigmaHPinion;
FOS_SHGear=SigmaHPermissibleContactPinion/SigmaHGear;
 
FOS_SFGear=SigmaFPermissibleBendingGear/SigmaF;
FOS_SFPinion=SigmaFPermissibleBendingPinion/SigmaF;


