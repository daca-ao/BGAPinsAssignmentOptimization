function Dsum = dsum( pinassign, n, source, ground )
%  计算均匀度D

nvar = source + ground;
D = zeros( nvar );
D2 = zeros( 1, nvar );

for i = 1 : nvar              %电源引脚和地引脚总数
    rowi = fix( (pinassign(i)-1)/n ) + 1;    %引脚i所在行
    coli = rem( (pinassign(i)-1),n ) + 1;    %引脚i所在列
    for j = ( i+1 ): nvar    %两个引脚之间
        rowj = fix( (pinassign(j)-1)/n ) + 1;   %引脚j所在行
        colj = rem( (pinassign(j)-1),n ) + 1;   %引脚j所在列
        d = sqrt( ( rowi - rowj )^2 + ( coli - colj )^2 );  %两引脚之间距离
        D( i, j ) = d;
        D( j, i ) = d;
    end
end

for i = 1 : nvar
    D( i, i ) = max( D( i, : ) );   %将自身距离改变
    D2( i ) = min( D( i, : ) );
end     %此时，D的每一行代表每一个电源/地引脚的独占球的半径

D2( D2 == 1 ) = 0;  % 对距离为1的引脚的罚函数
D2 = D2.^0.005;

Dsum = -sum( D2 );

end