function Lsum = lsum( pinassign, n, source, ground )
%  计算总电感L

nvar = source + ground;
L = zeros( (source + ground) );

for i = 1 : source
    for j = ( i+1 ) : source               %两个电源引脚之间
        rowi = fix( (pinassign(i)-1)/n ) + 1;    %引脚i所在行（减一简化计算，下同）
        coli = rem( (pinassign(i)-1),n ) + 1;    %引脚i所在列
        rowj = fix( (pinassign(j)-1)/n ) + 1;    %引脚j所在行
        colj = rem( (pinassign(j)-1),n ) + 1;    %引脚j所在列
        d = sqrt( ( rowi - rowj )^2 + ( coli - colj )^2 );  %两引脚之间的距离
        l=log( 100000/d );    %局部电感
        L( i, j ) = l;
        L( j, i ) = l;
    end
    for j = ( source + 1 ) : nvar    %电源引脚和地引脚之间
        rowi = fix( (pinassign(i)-1)/n ) + 1;   %引脚i所在行
        coli = rem( (pinassign(i)-1),n ) + 1;   %引脚i所在列
        rowj = fix( (pinassign(j)-1)/n ) + 1;   %引脚j所在行
        colj = rem( (pinassign(j)-1),n ) + 1;   %引脚j所在列
        d = sqrt( ( rowi - rowj )^2 + ( coli - colj )^2 );  %两引脚之间的距离
        l=log( 100000/d );    %局部电感
        L( i, j ) = -l;
        L( j, i ) = -l;
    end
end

for i = ( source + 1 ) : nvar
    for j = ( i+1 ): nvar                %两个地引脚之间
        rowi = fix( (pinassign(i)-1)/n ) + 1;   %引脚i所在行
        coli = rem( (pinassign(i)-1),n ) + 1;   %引脚i所在列
        rowj = fix( (pinassign(j)-1)/n ) + 1;   %引脚j所在行
        colj = rem( (pinassign(j)-1),n ) + 1;   %引脚j所在列
        d = sqrt( ( rowi - rowj )^2 + ( coli - colj )^2 );  %两引脚之间的距离
        l=log( 100000/d );    %局部电感
        L( i, j ) = l;
        L( j, i ) = l;
    end
end

Lsum = sum( L(:) );

end