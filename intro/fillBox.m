
% This fill in the matrix will specified values at randomized location
function [matrix, t] = fillBox(matrix, offset, value, w, h, time)
    x = [];
    y = [];
    for n = 1:time 
        i = randi([1, h]);
        j = randi([1, w]);
        x = [x;j];
        y = [y;i];
        for k = -offset:offset
            for f = -offset:offset
                if ((k+i <= h) && (k+i >= 1) && (j+f <= w) && (j+f >= 1))
                    matrix(i+k, j+f) = value; % obstacle assigned -1
                end
            end
        end
    end
    t = table(x, y);
end