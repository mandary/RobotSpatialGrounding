%A*
%Dijkstra is the special case of A* when heuristic return 0

function main
    A = [0 3 2 1 0; 3 0 3 0 0; 2 3 0 2 1; 1 0 2 0 0; 0 0 1 0 0];
    names = {'A' 'B' 'C' 'D' 'E'};
    G = graph(A, names, 'OmitSelfLoops');
    astar(G);
    
    
    function y = heuristic(G, a, b)
        y = abs(degree(G,a) - degree(G,b));
    end

    function astar(G)
        disp(G);
        dij = 1;
        start = input('where is the source?', 's');
        goal = input('where is the goal?', 's');
        if dij==0
           path = shortestpath(G,start,goal);
           disp(path);
        else
           edges = G.Edges;
           aG = graph();
           i = 1;
           while i ~= height(edges) + 1
               temps = edges.EndNodes(i,1);
               tempt = edges.EndNodes(i,2);
               tempw = edges.Weight(i) + heuristic(G, temps, tempt);
               aG = addedge(aG, temps, tempt, tempw);
               i = i + 1;
              
           end
           path = shortestpath(aG,start,goal);
           disp(path);
        end
    end

end