function [ target Lsum Dsum ] = obj_fun( rate, pinassign, n, source, ground )
%  �����ܵ�к����;��ȶȺ�����Ŀ�꺯������

Lsum = lsum( pinassign, n, source, ground );
Dsum = dsum( pinassign, n, source, ground );
target = ((Lsum * rate) + Dsum) / (1 + rate);

end