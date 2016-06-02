% given width and height and number of obstacles
% filename you want to store map
function dataCollector(n)
    % randomized map
    %A = map(width, height, obstacle, filename);
    % map from sampleMap
    load('data/sampleMap1');
    for i = 1:n
        num = num2str(i);
        file = 'data/path';
        file = strcat(file, num);
        file = strcat(file, '.mat');
        [n, m] = plotonfig(A, goal, proportion);
        [xcon, ycon, xx, yy] = curving(n, m);
        % str = strcat(file, i);
        save('data/path10.mat', 'xcon', 'ycon', 'xx', 'yy');
    end
    
end