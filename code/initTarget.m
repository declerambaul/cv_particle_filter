function [targetparticle target] = initTarget( obs ,bins)
% INITTARGET helps us determine what excactly 
% we want to track
% 
% Input:
% obs - observations

% Output:
% target - a prior state that we want to track

% The state of the target that we want to track
% NOTE : x-axis is vertical in this case
% state = [ x, y, vx, vy, Hx, Hy, sc]
% [x,y] - centroid of the target
% [vx,vy] - velocities
% [Hx,Hy] - size of the target (for now a rectangle, maybe an ellispe in the future)
% sc - scaling factor

% At this point, we extract the first frame (ff)
% and choose a target to track by drawing a 
% rectangle.
ff = obs;

imagesc(ff); % display first frame
waitforbuttonpress; % 
p1=get(gca,'CurrentPoint'); p1=round(p1(1,1:2));
rbbox;
p2=get(gca,'CurrentPoint'); p2=round(p2(1,1:2));
t_xywh = [p1,p2-p1]; % [x y w h]
tracking(1,:) = t_xywh;
rectangle('Position',tracking(1,:),'EdgeColor',[1.0,1.0,0.0]); 




% TARGET FOR RECTANGLE:
tx = floor(t_xywh(2)+t_xywh(4)/2);
ty = floor(t_xywh(1)+t_xywh(3)/2);
Hx = floor(t_xywh(4)/2);
Hy = floor(t_xywh(3)/2);
targetparticle = [tx ty 0 0 Hx Hy 1];



%first lets calculate the distribution of the target
tl = [targetparticle(1)-targetparticle(5) , targetparticle(2)-targetparticle(6)];
br = [targetparticle(1)+targetparticle(5) , targetparticle(2)+targetparticle(6)];
window = obs(tl(1):br(1),tl(2):br(2),:);
a = norm([size(window,1),size(window,2)]);    
c = round([size(window,1),size(window,2)]/2);
target = histo( window,c,a,bins );


