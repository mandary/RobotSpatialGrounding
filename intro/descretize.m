
% descretize line by bresenham's
function [rx, ry] = descretize(x, y)
    sx = x(1);
    sy = y(1);
    xx = [];
    yy = [];
    % bresenham all dots along the line
    for i = 2:size(x, 2)
        [tx, ty] = bresenham(sx, sy, x(i), y(i));
        xx = [xx;tx];
        yy = [yy;ty];
        sx = x(i);
        sy = y(i);
    end
    % round and remove repetiton
    rx = [];
    ry = [];
    rx = [rx round(xx(1))];
    ry = [ry round(yy(1))];
    for i = 2:size(xx, 1)
        siz = size(rx, 2);
        if rx(siz) ~= round(xx(i)) && ry(siz) ~= round(yy(i))
            rx = [rx round(xx(i))];
            ry = [ry round(yy(i))];
        end
    end
end