% Collect path coordinates from map A
function [n, m] =  plotonfig(A, goal, offset)
    xcor = goal{1, 1};
    ycor = goal{1, 2};
    hors = xcor - offset;
    hore = xcor + offset;
    vers = ycor - offset;
    vere = ycor + offset;
    % adjust coordinate 
    plot(0, 0);
    hold on;
    imagesc(A);
    % get points from mouse
    %[x,y] = ginput;
    p1 = 0;
    p2 = 0;
    m = [];
    n = [];
    i = 1;
    bool = 0;
    while ~bool
        [x, y] = ginput(1);
        plot(x, y, '.');
        % not first iteration
        if i ~= 1 
            start = [p1, x];
            goal = [p2, y];
            % graph the line
            line(start, goal, 'Color', 'r');
            % sample points
           % [xs, ys] = fillline([p1, p2], [x, y], 5);
            % append points
            n = [n x];
            m = [m y];
        end
        p1 = x;
        p2 = y;
        i = i + 1;
        bool = and(and((p1 < hore), (p1 > hors)), and((p2 < vere), (p2 > vers)));
    end
end