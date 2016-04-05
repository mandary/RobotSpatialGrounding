% Compute angle between 2 points
function result = GetAngle(p1, p2)
   result = atan2(p2(2)-p1(2), p2(1)-p1(1));
   if ~isreal(result)
       result = 0;
   end
   result = result + pi;
end