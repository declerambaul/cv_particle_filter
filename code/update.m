function  target  = update( target,s,obs,bins,alpha )
%
% target update: we adapt our target distribution
% to take into account changes of illumination 
% or scale or rotation
% Inputs: 
%   target - target distribution historgram
%   s - posterior state (new estimate)
%   alpha - the adaptation factor
% Output:
%   target - updated target model

% watch out, could be negative......
% tl = topleft br = bottomright

tl = [s(1)-s(5) , s(2)-s(6)];
tl(tl<1)=1;

brx = s(1)+s(5);
if brx > size(obs,1)
    brx = size(obs,1);
end
bry = s(2)+s(6);
if bry > size(obs,2)
    bry = size(obs,2);
end
br = [brx , bry];

% at this point those are rectangles, so it is easy to extract those pixels
s;
tl;
br;
window = obs(tl(1):br(1),tl(2):br(2),:)

a = norm([size(window,1),size(window,2)]);
% centroid of window (relativ!)
%c = [s(1),s(2)];                 
c = round([size(window,1),size(window,2)]/2);
% calculate distribution
posteriordist = histo( window,c,a,bins );

target;
posteriordist;

%target = (1-alpha).*target + alpha.*posteriordist;



