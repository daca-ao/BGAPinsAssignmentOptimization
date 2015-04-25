function [ target Lsum Dsum ] = obj_fun( rate, pinassign, n, source, ground )
%  关于总电感函数和均匀度函数的目标函数集合

Lsum = lsum( pinassign, n, source, ground );
Dsum = dsum( pinassign, n, source, ground );
target = ((Lsum * rate) + Dsum) / (1 + rate);

end