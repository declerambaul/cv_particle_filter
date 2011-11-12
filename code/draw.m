function [] = draw( s )
%
% draw displays the input state on the given frame
% 
% 
% Input:
% s - state we want to display
% NOTE : x-axis is vertical in this case
% state = [ x, y, vx, vy, Hx, Hy, sc]
% [x,y] - centroid of the target
% [vx,vy] - velocities
% [Hx,Hy] - size of the target (for now a rectangle, maybe an ellispe in the future)
% sc - scaling factor

rec = [s(2)-s(6),s(1)-s(5),2*s(6),2*s(5)];   
rectangle('Position',rec,'EdgeColor',[1.0,0.0,0.0]); 

