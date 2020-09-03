clear all;clc;close all;

syms th1 th2 th3
syms AL1 AL2 AL3
syms A1 A2 A3
syms D1 D2 D3
syms dth1 dth2 dth3 t


A1 = 0.5;   D1 = 0;  AL1 = 0;  %th_1 = pi/12;
A2 = 0.5;  D2 = 0;    AL2 = 0;     %th_2 = pi/6;
A3 = 0.5;   D3 = 0;    AL3 = 0;  %th_3 = 0;
m1 = 1; m2 = 0.1; m3 = 0.1; g = 9.8;

Eular_Rot_Mat_1 = [cos(th1)     -sin(th1)*cos(AL1)     sin(th1)*sin(AL1)     A1*cos(th1);
                   sin(th1)      cos(th1)*cos(AL1)    -cos(th1)*sin(AL1)     A1*sin(th1);
                   0             sin(AL1)              cos(AL1)              D1;
                   0             0                     0                     1];

Eular_Rot_Mat_2 = [cos(th2)     -sin(th2)*cos(AL2)     sin(th2)*sin(AL2)     A2*cos(th2);
                   sin(th2)      cos(th2)*cos(AL2)    -cos(th2)*sin(AL2)     A2*sin(th2);
                   0             sin(AL2)              cos(AL2)              D2;
                   0             0                     0                     1];
Eular_Rot_Mat_3 = [cos(th3)     -sin(th3)*cos(AL3)     sin(th3)*sin(AL3)     A3*cos(th3);
                   sin(th3)      cos(th3)*cos(AL3)    -cos(th3)*sin(AL3)     A3*sin(th3);
                   0             sin(AL3)              cos(AL3)              D3;
                   0             0                     0                     1];

Eul_0_1 = simplify(Eular_Rot_Mat_1);
Eul_0_2 = simplify(Eular_Rot_Mat_1 * Eular_Rot_Mat_2);
Eul_0_3 = simplify(Eular_Rot_Mat_1 * Eular_Rot_Mat_2 * Eular_Rot_Mat_3);

V_1 = [diff(Eul_0_1(1,4),th1);diff(Eul_0_1(2,4),th1)];

V_2 = [diff(Eul_0_2(1,4),th1) diff(Eul_0_2(1,4),th2);
       diff(Eul_0_2(2,4),th1) diff(Eul_0_2(2,4),th2)];
   
V_3 = [diff(Eul_0_3(1,4),th1) diff(Eul_0_3(1,4),th2) diff(Eul_0_3(1,4),th3);
       diff(Eul_0_3(2,4),th1) diff(Eul_0_3(2,4),th2) diff(Eul_0_3(2,4),th3)];
   
KE_1 = 0.5*m1*(V_1(1)^2 + V_1(2)^2)*dth1;
KE_2 = simplify(0.5*m2*expand((V_2(1,1)*dth1 + V_2(1,2)*dth2)^2 + (V_2(2,1)*dth1 + V_2(2,2)*dth2)^2));
KE_3 = simplify(0.5*m3*expand((V_3(1,1)*dth1 + V_3(1,2)*dth2 + V_3(1,3)*dth3)^2 + (V_3(2,1)*dth1 + V_3(2,2)*dth2 + V_3(2,3)*dth3)^2));

PE_1 = m1*g*A1*sin(th1);
PE_2 = m2*g*(A1*sin(th1) + A2*sin(th1+th2));
PE_3 = m3*g*(A1*sin(th1) + A2*sin(th1+th2) + A3*sin(th1+th2+th3));

L = simplify((KE_1 - PE_1) + (KE_2 - PE_2) + (KE_3 - PE_3));

Tau_1 = diff(diff(L,dth1),t) - diff(L,th1)
Tau_2 = diff(diff(L,dth2),t) - diff(L,th2)
Tau_3 = diff(diff(L,dth2),t) - diff(L,th2)
