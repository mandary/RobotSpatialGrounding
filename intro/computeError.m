% update weights for cost function
function updatedWeights = computeError(weights, pfeat, sfeat, lr)
    updatedWeights = weights;
    for i = 1:size(pfeat, 2)
        index = mod(i, size(pfeat, 2));
        if index == 0
            index = 4;
        end
        updatedWeights(index) = updatedWeights(index) + lr * (sfeat(i) - pfeat(i));
        if updatedWeights(index) >= 100 || updatedWeights(index) < 0
            updatedWeights(index) = 0;
        end
    end
end

% might want considering normalize