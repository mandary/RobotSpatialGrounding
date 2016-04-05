% given width and height and number of obstacles
% filename you want to store map
function dataCollector(n, width, height, obstacle, filename)
    % randomized map
    A = map(width, height, obstacle, filename);
    % map from sampleMap
    load('data/sampleMap');
    for i = 1:n
        [n, m] = plotonfig(A, goal, proportion);
        [xcon, ycon, xx, yy] = curving(n, m);
        % str = strcat(file, i);
        save('path10.mat', 'xcon', 'ycon', 'xx', 'yy');
    end
    
end