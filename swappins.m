function temp_pinassign = swappins( pinassign, m, n, pairs )
%  �������n�����ŵ�λ��

temp_pinassign = pinassign;

for i = 1 : pairs
    pin_1 = round(m*n*rand(1));  %���ȡĳ������
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