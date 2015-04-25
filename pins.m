function pinsmatrix = pins( pinassign, m, n, source, ground )
%  ����ʾ������ŵ�����ת��Ϊ���ž���

pinsmatrix = zeros(m,n);

for i = 1 : source
    r = fix( (pinassign(i)-1)/n ) + 1;    %����������
    c = rem( (pinassign(i)-1),n ) + 1;    %����������
    pinsmatrix(r, c) = 1;
end
for j = ( source+1 ) : ( source + ground )
    r = fix( (pinassign(j)-1)/n ) + 1;
    c = rem( (pinassign(j)-1),n ) + 1;
    pinsmatrix(r, c) = -1;
end

end