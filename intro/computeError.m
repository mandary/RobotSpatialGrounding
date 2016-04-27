% update weights for cost function
% take in weights, planned path feature list, sample path feature list, 
% learning rate, convex optimization rate(lambda)
function updatedWeights = computeError(weights, gradient, lr, lambda)
    updatedWeights = weights;
    weightn = size(weights, 2);
    for i = 1:weightn
        updatedWeights(i) = updatedWeights(i) * exp(-lr * (gradient(i) + lambda * updatedWeights(i)));
        if updatedWeights(i) >= 200
            updatedWeights(i) = 200;
        end
        
    end
        
end