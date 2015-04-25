function Dsum = dsum( pinassign, n, source, ground )
%  ������ȶ�D

nvar = source + ground;
D = zeros( nvar );
D2 = zeros( 1, nvar );

for i = 1 : nvar              %��Դ���ź͵���������
    rowi = fix( (pinassign(i)-1)/n ) + 1;    %����i������
    coli = rem( (pinassign(i)-1),n ) + 1;    %����i������
    for j = ( i+1 ): nvar    %��������֮��
        rowj = fix( (pinassign(j)-1)/n ) + 1;   %����j������
        colj = rem( (pinassign(j)-1),n ) + 1;   %����j������
        d = sqrt( ( rowi - rowj )^2 + ( coli - colj )^2 );  %������֮�����
        D( i, j ) = d;
        D( j, i ) = d;
    end
end

for i = 1 : nvar
    D( i, i ) = max( D( i, : ) );   %���������ı�
    D2( i ) = min( D( i, : ) );
end     %��ʱ��D��ÿһ�д���ÿһ����Դ/�����ŵĶ�ռ��İ뾶

D2( D2 == 1 ) = 0;  % �Ծ���Ϊ1�����ŵķ�����
D2 = D2.^0.005;

Dsum = -sum( D2 );

end