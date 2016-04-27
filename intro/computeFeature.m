
% return a list of features value of the (x, y) point
% [d to goal, d to nearest obstacle, a to goal, a to obstacle, ]
% feature value range from 0 to 100
function [feature] = computeFeature(x, y, goal, obstacle)
    feature = [];
    
%     % compute d to goal
%     xcor = goal{1, 1};
%     ycor = goal{1, 2};
%     dg = sqrt((xcor - x).^2 + (ycor - y).^2);
%     feature = [feature dg];
    
    % compute d to nearest obstacle
    mind = Inf;
    mx = 0;
    my = 0;
    for i = 1:size(obstacle, 1) % incorporate the proportion/sufcace
        xc = obstacle{i, 1};
        yc = obstacle{i, 2};
        d = sqrt((xc - x).^2 + (yc - y).^2);
        if d < mind
            mind = d;
            mx = xc;
            my = yc;
        end
    end
    feature = [feature mind];
%     
%     % Compute a to goal
%     sita = GetAngle([x y], [xcor ycor]);
%     feature = [feature sita];
%     
    % Compute a to nearest obstacle
%     sita2 = GetAngle([x y], [mx my]);
%     feature = [feature sita2];
    
    % Constant feature for number of steps
    feature = [feature 1];
end