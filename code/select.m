function SS = select( S,W )
%
% Selection of particle that will form the new set.
% Resampling according to their weights to avoid
% particle degeneracy
% 
% Input:
% S - set of particles
% W - set of weights
%
% Output:
% SS - resampled set of particles that we will propagate next
% 
SS = S;

N = size(S,1);

%to resample, we calculate the cumulative probabilities
C = zeros(N,1);
for i=2:N
   C(i) = C(i-1) + W(i);       
end
C = C / C(N);


for i=1:N
    CT = C;
    CT(CT<rand)=1;
    [minC,minI] = min(CT);
    %indeces(i)=minI;
    SS(i,:) = S(minI,:);
end

%debug only, display a histogram of what particles have been chosen, next
%to the probability of being chosen. Note that changing the parameter sigma
%has a big effect


% indeces
% ihist=zeros(N,1);
% for i=1:100
%     ihist(indeces(i))=ihist(indeces(i))+1;
% end
% [ihist,W]
