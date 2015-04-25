function [  ] = drawpins( pinsmatrix, m, n )
%  将引脚矩阵pinsmatrix画出来

shg;    %显示当前图形窗口
hold off;
rectangle('Position',[1,1,n,m],'Curvature',[0,0],'Facecolor','w','LineWidth',1)
hold on;
for c=1:1:n
    for r=1:1:m
        switch pinsmatrix((c-1)*m+r)    %由于matlab中矩阵是倒置，所以要从列开始访问
            case 0
                PinColor = 'w';
            case 1
                PinColor = 'r';
            case -1
                PinColor = 'b';
            case 2
                PinColor = 'g';
        end
        rectangle('Position',[c+0.15,(m+1-r)+0.15,0.7,0.7],'Curvature',[1,1],'Facecolor',PinColor,'LineWidth',1)
        hold on
    end
end
rectangle('Position',[0.9,0.9,n+0.2,m+0.2],'Curvature',[0,0],'Edgecolor','y','LineWidth',2)
hold off;
daspect([1,1,1]);
xlim([0,2+n]);
ylim([0,2+m]);
box on;
drawnow;
end