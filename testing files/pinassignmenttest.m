%  Ŀ�꺯�����Գ���

% tic
now = cputime;

%����Ϊ���Բ�����
m = 6;
n = 6;
source = 2;
ground = 2;

pinassign = [1 16 4 13];
Lsum = lsum( pinassign, n, source, ground )
Dsum = dsum( pinassign, n, source, ground )
pinsmatrix = pins(pinassign, m, n, source, ground);
drawpins(pinsmatrix, m, n);

load chirp
sound(y,Fs)
% toc
runtime = cputime - now

clear