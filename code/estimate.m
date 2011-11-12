function meanstate  = estimate( S,W )

%ESTIMATE will return a new estimate of the mean state.
%The returned state will then used to update the target
%model for the next iteration.

N = size(S,1);

meanstate = zeros(1,size(S,2));
for i=1:N
    s = S(i,:);
    meanstate = meanstate + W(i) * s;    
end
meanstate(1:6) = round(meanstate(1:6));