% update weights for cost function
function updatedWeights = computeError(weights, features, lr, error)
    updatedWeights = [0 0 0 0];
    for i = 1:size(features, 2)
        index = mod(i, size(weights, 2));
        if index == 0
            index = 4;
        end
        updatedWeights(index) = updatedWeights(index) + updatedWeights(index) + lr * error * features(i);
    end
    divd = size(features, 2) / size(weights, 2);
    for i = 1:size(updatedWeights, 2)
        updatedWeights(i) = updatedWeights(i) / divd;
    end
end

% might want considering normalize