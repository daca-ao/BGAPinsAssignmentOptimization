function pinsmatrix = pins( pinassign, m, n, source, ground )
%  将表示引脚序号的向量转换为引脚矩阵

pinsmatrix = zeros(m,n);

for i = 1 : source
    r = fix( (pinassign(i)-1)/n ) + 1;    %引脚所在行
    c = rem( (pinassign(i)-1),n ) + 1;    %引脚所在列
    pinsmatrix(r, c) = 1;
end
for j = ( source+1 ) : ( source + ground )
    r = fix( (pinassign(j)-1)/n ) + 1;
    c = rem( (pinassign(j)-1),n ) + 1;
    pinsmatrix(r, c) = -1;
end

end