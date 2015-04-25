function Lsum = lsum( pinassign, n, source, ground )
%  �����ܵ��L

nvar = source + ground;
L = zeros( (source + ground) );

for i = 1 : source
    for j = ( i+1 ) : source               %������Դ����֮��
        rowi = fix( (pinassign(i)-1)/n ) + 1;    %����i�����У���һ�򻯼��㣬��ͬ��
        coli = rem( (pinassign(i)-1),n ) + 1;    %����i������
        rowj = fix( (pinassign(j)-1)/n ) + 1;    %����j������
        colj = rem( (pinassign(j)-1),n ) + 1;    %����j������
        d = sqrt( ( rowi - rowj )^2 + ( coli - colj )^2 );  %������֮��ľ���
        l=log( 100000/d );    %�ֲ����
        L( i, j ) = l;
        L( j, i ) = l;
    end
    for j = ( source + 1 ) : nvar    %��Դ���ź͵�����֮��
        rowi = fix( (pinassign(i)-1)/n ) + 1;   %����i������
        coli = rem( (pinassign(i)-1),n ) + 1;   %����i������
        rowj = fix( (pinassign(j)-1)/n ) + 1;   %����j������
        colj = rem( (pinassign(j)-1),n ) + 1;   %����j������
        d = sqrt( ( rowi - rowj )^2 + ( coli - colj )^2 );  %������֮��ľ���
        l=log( 100000/d );    %�ֲ����
        L( i, j ) = -l;
        L( j, i ) = -l;
    end
end

for i = ( source + 1 ) : nvar
    for j = ( i+1 ): nvar                %����������֮��
        rowi = fix( (pinassign(i)-1)/n ) + 1;   %����i������
        coli = rem( (pinassign(i)-1),n ) + 1;   %����i������
        rowj = fix( (pinassign(j)-1)/n ) + 1;   %����j������
        colj = rem( (pinassign(j)-1),n ) + 1;   %����j������
        d = sqrt( ( rowi - rowj )^2 + ( coli - colj )^2 );  %������֮��ľ���
        l=log( 100000/d );    %�ֲ����
        L( i, j ) = l;
        L( j, i ) = l;
    end
end

Lsum = sum( L(:) );

end