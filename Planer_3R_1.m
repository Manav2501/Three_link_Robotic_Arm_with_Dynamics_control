
L (1) = Revolute('d',0      ,'a',0.5   ,'alpha',0       ,'qlim',[0 2.9671]);
L (2) = Revolute('d',0      ,'a',0.5   ,'alpha',0       ,'qlim',[-2.3562 2.3562]);
L (3) = Revolute('d',0      ,'a',0.5   ,'alpha',0       ,'qlim',[-2.3562 2.3562]);
qz = [0 0 0]; %Home position where all thetas are zero
R3 = SerialLink(L,'name','RSS');
R3.manufacturer = 'Mohan Bhagwat';
R3.ikineType = '3_Planer';
% R3.plot(qz)

Points = [1.5 0;0.6 0.8];
timeDuration = 10;
Force = [15;15];
N = 50;  % total points
traj = ctraj(transl(Points(1,1),Points(1,2),0),transl(Points(2,1),Points(2,2),0),N);

for k = 1:length(traj)
        Des = traj(:,:,k);
        if(k == 1)
            Ini_val = [pi/3 -pi/6 -pi/6];
        else
            Ini_val = OPx(:,k-1);
        end
        Func = 1e-3;
        Step = 1e-3; 
%         fprintf('\n Fsolve iterating for the %d(%d) position in the trajectory.\n',k,h);
        options = optimoptions('fsolve','Display','iter','Algorithm','levenberg-marquardt','FunValCheck','on','FunctionTolerance',Func,'StepTolerance',Step);
        OPx(:,k) = fsolve(@ikine_Num,Ini_val,options,Des);
        
        Jacob(:,:,k) = 0.5 .* [ -sin(OPx(1,k) + OPx(2,k) + OPx(3,k)) - sin(OPx(1,k) + OPx(2,k)) - sin(OPx(1,k)),      - sin(OPx(1,k) + OPx(2,k) + OPx(3,k)) - sin(OPx(1,k) + OPx(2,k)),       -sin(OPx(1,k) + OPx(2,k) + OPx(3,k));
                                cos(OPx(1,k) + OPx(2,k) + OPx(3,k)) + cos(OPx(1,k) + OPx(2,k)) + cos(OPx(1,k)),        cos(OPx(1,k) + OPx(2,k) + OPx(3,k)) + cos(OPx(1,k) + OPx(2,k)),        cos(OPx(1,k) + OPx(2,k) + OPx(3,k))];
                            
        Torque(:,k) = Jacob(:,:,k)' * Force;
end



% OPx(1,k) = linspace(-pi/2,pi/2,200)';
% OPx(2,k) = linspace(-pi/2,pi/2,200)';
% OPx(3,k) = linspace(-pi/2,pi/2,200)';
time = linspace(0,timeDuration,N)';

Th1 = [time OPx(1,:)'];
Th2 = [time OPx(2,:)'];
Th3 = [time OPx(3,:)'];

Tq1 = [time Torque(1,:)'];
Tq2 = [time Torque(2,:)'];
Tq3 = [time Torque(3,:)'];
