function F = ikine_Num(th,Des) 
       
    F(1) = cos(th(3))*(cos(th(1))*cos(th(2)) - sin(th(1))*sin(th(2))) - sin(th(3))*(cos(th(1))*sin(th(2)) + cos(th(2))*sin(th(1))) - Des(1,1);

    F(2) = cos(th(3))*(cos(th(1))*sin(th(2)) + cos(th(2))*sin(th(1))) + sin(th(3))*(cos(th(1))*cos(th(2)) - sin(th(1))*sin(th(2))) - Des(2,1);

    F(3) = - cos(th(3))*(cos(th(1))*sin(th(2)) + cos(th(2))*sin(th(1))) - sin(th(3))*(cos(th(1))*cos(th(2)) - sin(th(1))*sin(th(2))) - Des(1,2);

    F(4) = cos(th(3))*(cos(th(1))*cos(th(2)) - sin(th(1))*sin(th(2))) - sin(th(3))*(cos(th(1))*sin(th(2)) + cos(th(2))*sin(th(1))) - Des(2,2);

    F(5) = cos(th(1))/2 + (cos(th(1))*cos(th(2)))/2 - (sin(th(1))*sin(th(2)))/2 + (cos(th(3))*(cos(th(1))*cos(th(2)) - sin(th(1))*sin(th(2))))/2 - (sin(th(3))*(cos(th(1))*sin(th(2)) + cos(th(2))*sin(th(1))))/2 - Des(1,4);

    F(6) = sin(th(1))/2 + (cos(th(1))*sin(th(2)))/2 + (cos(th(2))*sin(th(1)))/2 + (cos(th(3))*(cos(th(1))*sin(th(2)) + cos(th(2))*sin(th(1))))/2 + (sin(th(3))*(cos(th(1))*cos(th(2)) - sin(th(1))*sin(th(2))))/2 - Des(2,4);
    
    F(7) = 1 - Des(3,3);F(8) = 0 - Des(3,1);F(9) = 0 - Des(3,2);F(10) = 0 - Des(1,3);F(11) = 0 - Des(2,3);F(12) = 0 - Des(4,3);
end
