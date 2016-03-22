% update weights for cost function
function updatedWeights = computeError(weights, pfeat, sfeat, lr, lambda)
    updatedWeights = weights;
    siz = min(size(sfeat, 2), size(pfeat, 2));
    for i = 1:siz
        index = mod(i, 4);
        if index == 0
            index = 4;
        end
        updatedWeights(index) = updatedWeights(index) + lr * ((sfeat(i) - pfeat(i)) + lambda * updatedWeights(index));
        if updatedWeights(index) >= 200
            updatedWeights(index) = 200;
        end
%         if updatedWeights(index) < 0
%             updatedWeights(index) = 0;
%         end
        
    end
        
end

% might want considering normalize