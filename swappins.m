function temp_pinassign = swappins( pinassign, m, n, pairs )
%  随机调换n对引脚的位置

temp_pinassign = pinassign;

for i = 1 : pairs
    pin_1 = round(m*n*rand(1));  %随机取某个引脚
    if pin_1 < 1 
        pin_1 = 1;
    end
    pin_2 = round(m*n*rand(1));
    if pin_2 < 1
        pin_2 = 1;
    end
    temp = temp_pinassign(pin_1);
    temp_pinassign(pin_1) = temp_pinassign(pin_2);
    temp_pinassign(pin_2) = temp;
end