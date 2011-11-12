function [S,W] = initParticles( target,N,param )
%INITPARTICLES creates the initial sets of particles

% Inputs:
% target - initial target that we want to track,
% this function creates a set of samples around that
% target that all have a uniform weight
% N - number of particles

% Outputs:
% S - set of particles
% W - set of weights (all initialized at 1/N)
% 

% the state of the target 
% NOTE : x-axis is vertical in this case
% state = [ x, y, vx, vy, Hx, Hy, sc]
% [x,y] - centroid of the target
% [vx,vy] - velocities
% [Hx,Hy] - size of the target (for now a rectangle, maybe an ellispe in the future)
% sc - scaling factor


S=[];
W=[];

delta_max = param;
for i=1:N
    %uniformly distribute vx,vy,sc
    delta = -delta_max + 2*delta_max .* rand(size(delta_max,1),1);
    delta(1) = round(delta(1));
    delta(2) = round(delta(2));    
    %create sample
    dx = target(1) + delta(1);
    dy = target(2) + delta(2);
    dvx = delta(1);
    dvy = delta(2);
    dHx = round(target(5)*(1+delta(3)));
    dHy = round(target(6)*(1+delta(3)));   
    dsc = delta(3);
    s = [dx,dy,dvx,dvy,dHx,dHy,dsc] ;
    
    %add particle to set S
    S = [S;s];
    %add initial weight 1/N to set W
    W = [W;1/N];
       
end