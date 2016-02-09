% This creates a visualized map with specified dimensions and y obstacles

function [A] = map(width, height, obstacle, filename)
    A(1:height, 1:width) = 0; % all zero at first
    proportion = round(min(width, height)/12);
    % randomized obstacles
    [A, object] = fillBox(A, proportion, -1, width, height, obstacle);
    % randomized start and destinations
    [A, start] = fillBox(A, proportion, 5, width, height, 1); % start assigned 5
    [A, goal] = fillBox(A, proportion, 10, width, height, 1); % goal assigned 10
    plot(0, 0);
    hold on;
    imagesc(A);
    save(filename, 'A', 'object', 'start', 'goal', 'width', 'height', 'proportion');
end

% may develop further function for different shapes of obstacles