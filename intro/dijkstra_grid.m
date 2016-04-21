%% USE DIJKSTRA'S ALGORITHM TO COMPUTE SHORTEST PATH USING THE FINAL COST FUNCTION
function [path_LC] = dijkstra_grid(start,goal,cost,connectivity)
    % FIND THE LEAST COST PATH BETWEEN START & GOAL STATES BASED ON A
    % NON-NEGATIVE COST DEFINED ON THE STATE SPACE
    %
    % INPUTS ARE: 
    % START        : Start state of the path, a 2 x 1 matrix of the form [col;row]
    % GOAL         : Goal state of the path, a 2 x 1 matrix of the form [col;row] 
    % COST         : A non-negative cost defined over the entire state space. It
    %                is a m x n matrix where the state space is discretized into   
    %                a m x n grid (NOTE: THE COST HAS TO BE non-negativer
    %                everywhere)
    % CONNECTIVITY : This is the connectivity of the state space (or) the
    %                allowable actions from each state. Options are
    %                '4-connected' and '8-connected'. For a '4-connected'
    %                neighborhood, each state can reach 4 neighboring
    %                states (up,down,right & left) of it. For a
    %                '8-connected' neighborhood, diagonal actions are also
    %                allowed
    %
    % OUTPUT IS:
    % PATH_LC      : LEAST COST PATH BETWEEN START & GOAL, IN THE FORM
    %                OF [COL;ROW] INDICES OF THE VERTICES ALONG THE PATH
    %                It is a [2 x k] array where k is the length of the
    %                path.

    % ASSIGN actions based on the connectivity. For a 8-connected grid,
    % have 8 actions including diagonal moves, for 4 connected, only have 4
    % actions (no diagonal moves)
    if strcmp(connectivity,'4-connected') % 4-connected neighborhood
        dRow = [1, -1, 0,  0]; % dRow
        dCol = [0,  0, 1, -1]; % dCol
    elseif strcmp(connectivity,'8-connected') % 8-connected neighborhood
        dRow = [1, -1, 0,  0, 1, -1,  1, -1]; % dRow
        dCol = [0,  0, 1, -1, 1,  1, -1, -1]; % dCol
    else
        error('Unknown connectivity option given. Available options are "8-connected" or "4-connected"');
    end
    
    %{
    if (numel(dRow) ~= numel(dCol))
        error('Number of actions is not consistent across dRow & dCol!');
    end
    %}

    lim = size(cost);
    st_id = sub2ind(lim,start(2),start(1));
    %goal_id = sub2ind(lim,goal(2),goal(1));

    % DO BREADTH FIRST SEARCH ON THE STATE SPACE       
    stack = start;
    stack_cost = cost(start(2),start(1));

    visited = zeros(lim); % list of visited states & states in stack - all zeros at first
    % IF VISITED(STATE) = 1, IT MEANS WE HAVE VISITED THE STATE,
    % IF VISITED(STATE) = 2, IT MEANS THE STATE IS IN THE STACK

    % List of back pointers!!
    Parent = zeros(lim);
    Parent(start(2),start(1)) = st_id;

    % Matrix of PATH cost!!
    Pcost = Inf*ones(lim);
    Pcost(start(2),start(1)) = 0;

    while ~isempty(stack)

        % Pop top element from stack
        curr = stack(:,1); % [col;row]
        stack(:,1) = [];

        % Pop top element from stack that has cost of all elements in stack!
        curr_cost = stack_cost(1);
        stack_cost(1) = [];

        % SET VISITED FLAG FOR CURRENT STATE TO BE 1
        visited(curr(2),curr(1)) = 1; % curr state has been explored!!!

        % If we have reached goal state, STOP
        if(curr(1) == goal(1) && curr(2) == goal(2))
            break;
        end

        % CHECK ALL NEIGHBORS OF CURRENT STATE!
        neigh_st = bsxfun(@plus,curr,[dCol;dRow]);

        % CHECK LIMITS NOW! (lim(1) -> row limit, lim(2)-> column
        % limit & neigh_st is of form [col;row]
        flgx = neigh_st(1,:) < 1 | neigh_st(1,:) > lim(2) | neigh_st(2,:) < 1 | neigh_st(2,:) > lim(1); 
        neigh_st = neigh_st(:,~flgx); % REMOVE ALL ITEMS THAT ARE BEYOND THE LIMITS!

        % WE HAVE TO CONSIDER ALL REMAINING NEIGHBORS!
        neigh = sub2ind(lim,neigh_st(2,:),neigh_st(1,:));

        % If any of these neighbours have been visited, do not add them to stack
        neigh = neigh(~(visited(neigh) == 1));

        % Compute the cost of each neighbour
        neigh_cost = curr_cost + cost(neigh); 

        % Do we get a lesser cost by going through curr than by any other way to reach neigh??
        flgx = (neigh_cost < Pcost(neigh));
        neigh = neigh(flgx); % IF SO,Update only those that get a lesser cost through curr 
        Pcost(neigh) = neigh_cost(flgx); % If so, update the cost to this lesser cost

        % UPDATE THE BACK POINTERS FOR THESE STATES TO CURR
        Parent(neigh) = sub2ind(lim,curr(2),curr(1)); % We visit these states by taking an action from curr

        % Do not re-add any states that are already in the stack
        newadd = neigh(~(visited(neigh) == 2));
        visited(newadd) = 2; % THIS STATE IS IN THE STACK

        % Add the neighbours to last part of stack!!
        [nadd_R,nadd_C] = ind2sub(lim,newadd);
        stack = [stack, [nadd_C;nadd_R]]; % [COL;ROW]
        stack_cost = [stack_cost Pcost(newadd)]; % Add the cost of these states to stack_cost

        % Reorder the stack at every instance so that we get the index with the smallest cost at next step!!
        [stack_cost,idv] = sort(stack_cost,'ascend');
        stack = stack(:,idv);
        %}

    end

    % NOW BACKTRACK ON THE PARENT ARRAY to compute best path
    path_LC = goal; % [COL;ROW]
    curr = goal; %[COL;ROW]
    while curr(1) ~= start(1) || curr(2) ~= start(2) % BACKTRACK UNTIL WE REACH THE START STATE!
        [t_R,t_C] = ind2sub(lim,Parent(curr(2),curr(1))); % Get the corresponding row & column indices of the vertex
        path_LC = [[t_C;t_R], path_LC]; % Add it to the path
        curr = path_LC(:,1); % Get the next node on the path 
    end
end