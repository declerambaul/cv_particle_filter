function [ d ] = bhattadistance( p,q )
%BHATTADISTANCE returns a scalar value that is the
%Bhattacharyya distance between two distributions
% Inputs
%   p - proposed histrogram distribution of a particle
%   q - target distribution

% Question: How does one combine the three histograms
% (RGB) into just one distance?

if size(p,1)~=size(q,1) || size(p,2)~=size(q,2)
   error('dimensions of distributions have to match') 
end

d = sum(sqrt(p.*q));
% average distance over the three distributions?
d = sum(d)/length(d);

d = sqrt(1-d);


