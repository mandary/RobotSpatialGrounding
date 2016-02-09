% input
% BTG and BTP for goal and path BNF constraints
% set of objects
% pdist on labels of each object
% relation weights
% robot position

% output
% joint distribution on landmark objects

function [jointP] = objGrounding(BTG, BTP, objects, pdist, weights, pos)
    for label in pdist %for each loop?
        posterior = pdist/?;
    end 
    % call algorithm 2
    for object in objects
        % calculate cost from (x,y) to goal, using object
    end
    
    for object % could not understand
    end 

end
