function [ init_pinassign init_Lsum init_Dsum ]= initialsolution( m, n, source, ground )
%  ���������ʼ����λ������
%  �������ʾ����

init_pinassign = randperm( m*n );
init_Lsum = lsum( init_pinassign, n, source, ground );
init_Dsum = dsum( init_pinassign, n, source, ground );
init_pinsmatrix = pins(init_pinassign, m, n, source, ground);
drawpins(init_pinsmatrix, m, n);

end