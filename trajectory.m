function [traj,t] = trajectory(Points,TimeDuration)  % Points{Nx6} , TimeDuration{1x1}

    N = length(Points(:,1));
    for i=1:N
        trans(i,1) = Points(1,i);
        trans(i,2) = Points(2,i);     
    end

    T = 0: TimeDuration/(N-1) :TimeDuration;
    for j=1:N-2
        distance(1,:) = [0 0];
        distance(N,:) = [0 0];
        
        velocity(1,:) = [0 0];
        velocity(N,:) = [0 0];

        acceleration(1,:) = [0 0];
        acceleration(N,:) = [0 0];

        Dx = Points(1,j+1) - Points(1,j);dt = T(1,j+1)-T(1,j);
        Dy = Points(2,j+1) - Points(2,j);
        
        velocity(j+1,:) = [Dx/dt Dy/dt Dz/dt];
        
        Vx = velocity(j+1,1) - velocity(j,1);
        Vy = velocity(j+1,2) - velocity(j,2);
        
        acceleration(j+1,:) = [Vx/dt Vy/dt Vz/dt];
        
        Ax = acceleration(j+1,1) - acceleration(j,1);
        Ay = acceleration(j+1,2) - acceleration(j,2);
        
    end
    
    for k=1:N-1
        q0 = trans(k,:);
        v0 = velocity(k,:);
        ac0 = acceleration(k,:);
        q1 = trans(k+1,:);
        v1 = velocity(k+1,:);
        ac1 = acceleration(k+1,:);
        t0 = 0;
        tf = TimeDuration/(N-1);
        
        t = linspace(t0,tf,50);
        c = ones(size(t));
        for l=1:2
            M(:,:,l) = [ 1  t0 t0.^2 t0.^3   t0.^4    t0.^5;
						 0  1  2*t0  3*t0.^2 4*t0.^3  5*t0.^4;
						 0  0  2     6*t0    12*t0.^2 20*t0.^3;
						 1  tf tf.^2 tf.^3   tf.^4    tf.^5;
						 0  1  2*tf  3*tf.^2 4*tf.^3  5*tf.^4;
						 0  0  2     6*tf    12*tf.^2 20*tf.^3];

            b(:,l)=[q0(l); v0(l); ac0(l); q1(l); v1(l); ac1(l)];
            a(:,l) = inv(M(:,:,l))*b(:,l);
 
            qd(:,l) = a(1,l).*c + a(2,l).*t +a(3,l).*t.^2 + a(4,l).*t.^3 +a(5,l).*t.^4 + a(6,l).*t.^5;
            vd(:,l) = a(2,l).*c +2*a(3,l).*t +3*a(4,l).*t.^2 +4*a(5,l).*t.^3 +5*a(6,l).*t.^4;
            ad(:,l) = 2*a(3,l).*c + 6*a(4,l).*t +12*a(5,l).*t.^2 +20*a(6,l).*t.^3;
            
        end
        for m = 1:length(t)-1
            traj(:,:,m,k) = transl(qd(m,:)) * rpy2tr(qrd(m,1),qrd(m,2),qrd(m,3));
        end            
    end
    
    subplot(221);
    plot(T,Points(1,:)','r'); hold on
    plot(T,Points(2,:)','g');
    legend('Pos_X','Pos_Y');
    xlabel('Time');
    ylabel('Position');
    grid on
    
    subplot(222);
    plot(T,velocity(:,1),'r'); hold on
    plot(T,velocity(:,2),'g');
    legend('velocity_X','velocity_Y');
    xlabel('Time');
    ylabel('Velocity');
    grid on
    
    subplot(223);
    plot(T,acceleration(:,1),'r'); hold on
    plot(T,acceleration(:,2),'g');
    legend('acceleration_X','acceleration_Y');
    xlabel('Time');
    ylabel('Acceleration');
    grid on
    
end
