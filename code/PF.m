% 
%   An adaptive color-based particle filter
%
%   Fabian Kaelin - March 09

%
%
%  MAIN FILE
%
%  Point videofile to an uncompressed avi file 
%  and you are ready to go


videofile = 'Movie/multimodal.avi';
%setup

% Load uncompressed test movie
if 1==1
    %obs = aviread('Movie/track_obs.avi');
    obs = aviread(videofile);
    %get rid of the first frames
    %obs = obs(1000:end);
end
[dum,numframes]=size(obs);

% Number of samples for the particle filter
N = 100;
% Number of bins for the histograms
bins = 8;
% Variance of Gaussian used to assign a weight to a particle based on the
% Bhattacharyya distance between a hypothesis and the target distribution
sigma = 0.1;
% Noise vector for the dynamical model
%n = [1,1,1,1,1,1,0.01];
%n = [1,30,0,1,0,0,0];
n = [5,5,10,10,3,3,0.1];
%n = zeros(1,7);
% range of particles during initialization
vx_max = 20;
vy_max = 20;
sc_max = 0.1;
% factor that determines how much the posterior distribution
% influences our target distribution
alpha=0.1;

% The state of the target that we want to track
% NOTE : x-axis is vertical in this case
% state = [ x, y, vx, vy, Hx, Hy, sc]
% [x,y] - centroid of the target
% [vx,vy] - velocities
% [Hx,Hy] - size of the target (for now a rectangle, maybe an ellispe in the future)
% sc - scaling factor


%obs = obs(400:end);
%extract the first frame ff
[ff,map]=frame2im(obs(:,1)); 
%colormap(map);

%initialize a target that we try to track
%target =[251    62     0     0    12    11     1];
[targetparticle target] = initTarget(ff,bins);
%calculate the histogram of the target 



%TODO : INIT PARTICLES WITH GAUSSIAN PARAMETERS
param = [vx_max; vy_max; sc_max];
% We create the initial sample set
[S W] = initParticles(targetparticle,N,param);
% We observe the weights for the first target 
% Note: we could also start with the uniform weights
W = observe(ff,S,target,sigma,bins);

% meanstate = estimate(S,W);
% draw(meanstate);

%SS = select(S,W);

 
% MAIN LOOP

for i=2:numframes
    % resampling
    SS = select(S,W);
    % dynamical model / particle propagation
    S = propagate( SS,n );
    % observation
    [nf,map]=frame2im(obs(:,i));      
    W = observe(nf,S,target,sigma,bins);
    % estimation
    posterior = estimate(S,W);
    % target update
    target = update(target,posterior,obs,bins,alpha);
    
   

    
    
    
    if 1==1
        
        maxW = max(W);
        for j=1:1:N
            %if W(i) == maxW
                s=S(j,:);
                %watch out, they could be smaller than zero, no error
                rec = [s(2)-s(6),s(1)-s(5),2*s(6),2*s(5)];            
                %cvalue = W(i)/maxW;                        
                cvalue = 1;
                rectangle('Position',rec,'EdgeColor',[0.0,cvalue,0.0]); 
            %end
        end
        %rectangle('Position',tracking(1,:),'EdgeColor',[1.0,1.0,0.0]);     

    end
    draw(posterior);
    
    %waitforbuttonpress
    
    %outputf = sprintf('tracking/frames/output%d',i);
    %saveas(gcf,outputf , 'jpg');
    
    track_movie(i-1) = getframe(gcf,[0 0 320 120]);
    %track_movie(i-1) = getframe;
end



% we can save the movie
if 1==0
    fout = 'Tracking/tracked.avi';
    aviobj = avifile(fout, 'compression', 'none', 'fps', 25);
    for i = 1:length(track_movie) 
 
        im = track_movie(i);
        im = im.cdata;
        
        %Write frames to output video 
        frm = im2frame(im); 
        aviobj = addframe(aviobj,frm);     
        i   %Just to display frame number 
    end; 
    aviobj = close(aviobj); 
    
end


