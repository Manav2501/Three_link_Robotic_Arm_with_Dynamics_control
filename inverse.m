clear all;
clc;
close all;

syms th1 th2 th3
syms AL1 AL2 AL3
syms A1 A2 A3
syms D1 D2 D3


A1 = 0.5;   D1 = 0;  AL1 = 0;  %th_1 = pi/12;
A2 = 0.5;  D2 = 0;    AL2 = 0;     %th_2 = pi/6;
A3 = 0.5;   D3 = 0;    AL3 = 0;  %th_3 = 0;


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

Ans = Eular_Rot_Mat_1 * Eular_Rot_Mat_2 * Eular_Rot_Mat_3;

J = [diff(Ans(1,4),th1) diff(Ans(1,4),th2) diff(Ans(1,4),th3);
    diff(Ans(2,4),th1) diff(Ans(2,4),th2) diff(Ans(2,4),th3)];

Jacob = simplify(J)