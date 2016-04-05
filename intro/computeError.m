% update weights for cost function
% take in weights, planned path feature list, sample path feature list, 
% learning rate, convex optimization rate(lambda)
function updatedWeights = computeError(weights, pfeat, sfeat, lr, lambda)
    updatedWeights = weights;
    weightn = size(weights, 2);
    siz = min(size(sfeat, 2), size(pfeat, 2));
    for i = 1:siz
        index = mod(i, weightn);
        if index == 0
            index = weightn;
        end
        updatedWeights(index) = updatedWeights(index) * exp(-lr * ((sfeat(i) - pfeat(i)) + lambda * updatedWeights(index)));
        if updatedWeights(index) >= 200
            updatedWeights(index) = 200;
        end
        
    end
        
end