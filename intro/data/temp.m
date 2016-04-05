function temp
    height = 300;
    width = 300;
    A(1:height, 1:width) = 0; % all zero at first
    proportion = round(min(width, height)/12);
    % randomized obstacles
    object = table();
    [A, obs1] = fillBox(200, 200, A, proportion, -100, width, height, 1);
    object = [object; obs1];
    [A, obs2] = fillBox(100, 180, A, proportion, -100, width, height, 1);
    object = [object; obs2];
    [A, obs3] = fillBox(150, 100, A, proportion, -100, width, height, 1);
    object = [object; obs3];
    [A, obs4] = fillBox(80, 260, A, proportion, -100, width, height, 1);
    object = [object; obs4];
    [A, obs5] = fillBox(100, 40, A, proportion, -100, width, height, 1);
    object = [object; obs5];
    [A, obs6] = fillBox(250, 100, A, proportion, -100, width, height, 1);
    object = [object; obs6];
    % randomized start and destinations
    [A, start] = fillBox(270, 270, A, proportion, 20, width, height, 1); % start assigned 5
    [A, goal] = fillBox(30, 30, A, proportion, 10, width, height, 1); % goal assigned 10
    plot(0, 0);
    hold on;
    imagesc(A);
    save('data/sampleMap1', 'A', 'object', 'start', 'goal', 'width', 'height', 'proportion');
end