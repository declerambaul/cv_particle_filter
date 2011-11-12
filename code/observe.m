function W = observe(obs,S,target,sigma,bins)
%
% This function updates the weights of all particles using
% the Bhattacharyya distance between the particle and the
% target distributions.
%
% Inputs:
% obs - new observation (new frame)
% S - particle set 
% target - the target state
% sigma - variance of gaussian distribution for determining probabilities
%          of weights
% bins - number of bins for histograms
%
% Output:
% W - updated weights for each particle
N = size(S,1);


W=zeros(N,1);
% constant term in gaussian term
constW = 1/sqrt(2*pi*sigma);
  

for i=1:N
    %take particle i
    s = S(i,:);
    
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
    window = obs(tl(1):br(1),tl(2):br(2),:);
    
    
    % again, this is rectangle specific, see description in histo()
    % not sure what to put in case of a rectangle
    a = norm([size(window,1),size(window,2)]);
    % centroid of window (relativ!)
    %c = [s(1),s(2)];                 
    c = round([size(window,1),size(window,2)]/2);
    % calculate distribution
    p_hyp = histo( window,c,a,bins );
    
    % Bhattacharyya distance between hypothesis and target
    d = bhattadistance(p_hyp,target);
    
    % update weights
    W(i) = constW * exp(-d/(2*sigma));
    
    if isnan(W(i))
       [i W(i)]
       a
       c
       p_hyp
       d
       s
       tl
       br
       size(obs)
       window
    end
    
    D(i) = d;

   
    %Debug: draw the rectangles
    if 1==0
        rec = [s(2)-s(6),s(1)-s(5),2*s(6),2*s(5)];   
        rectangle('Position',rec,'EdgeColor',[0.0,0.0,1.0]); 
        waitforbuttonpress
    end    
    
end


% NOTE: sigma has a big influence on the variance of the weights

nnW = W;

% normalize the weights
W = W/sum(W);

% debug - if you want to display this, uncomment line +/- 73
%[D', nnW,W]
[D', W]
%varW = var(W)
%varNNW = var(nnW)
%[sum(W),sum(nnW)]
[sum(W),var(W)]