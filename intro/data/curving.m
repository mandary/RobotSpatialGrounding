

function [xcon, ycon, xx, yy] = curving(n, m)

    [xcon, ycon, ind] = consolidator(n, m, @max, 0);
    xx = linspace(min(xcon),max(xcon),100); 
    yy = spline(xcon, ycon, xx); 
    figure,plot(xcon, ycon,'o',xx,yy);
    
end