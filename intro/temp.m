function temp
    height = 150;
    width = 100;
    A(1:height, 1:width) = 0; % all zero at first
    proportion = round(min(width, height)/12);
    % randomized obstacles
    object = table();
    [A, obs1] = fillBox(30, 40, A, proportion, -1, width, height, 1);
    object = [object; obs1];
    [A, obs2] = fillBox(90, 40, A, proportion, -1, width, height, 1);
    object = [object; obs2];
    [A, obs3] = fillBox(30, 80, A, proportion, -1, width, height, 1);
    object = [object; obs3];
    [A, obs4] = fillBox(70, 90, A, proportion, -1, width, height, 1);
    object = [object; obs4];
    [A, obs5] = fillBox(100, 80, A, proportion, -1, width, height, 1);
    object = [object; obs5];
    [A, obs6] = fillBox(60, 50, A, proportion, -1, width, height, 1);
    object = [object; obs6];
    % randomized start and destinations
    [A, start] = fillBox(10, 20, A, proportion, 5, width, height, 1); % start assigned 5
    [A, goal] = fillBox(140, 90, A, proportion, 10, width, height, 1); % goal assigned 10
    plot(0, 0);
    hold on;
    imagesc(A);
    disp(object);
    save('sampleMap', 'A', 'object', 'start', 'goal', 'width', 'height', 'proportion');

end
