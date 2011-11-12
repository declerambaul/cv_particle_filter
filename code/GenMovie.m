% 
%   An adaptive color-based particle filter
%
%   Fabian Kaelin - March 09

%  Random utilities
%


% Play a Movie

% Load uncompressed test movie (500mb)
if 1==0
    wwe = aviread('Movie/wwe.avi');
    %get rid of the first frames
    wwe = wwe(200:end);
    [dum,numframes]=size(wwe);
end


% Generate a movie

% axis 396 by 314
if 1==1
%propvariance = [5,5,0,0];
propvariance = [5,5,3,3];
%rec = [100,100,20,20];
rec = [150,150,20,20];
axis([0 396 0 314]); 
    for i=1:85
        rectangle('Position',rec,'EdgeColor',[0.0,0.0,0.0], 'FaceColor','black'); 
        
        %gaussian movement
        %rec = rec + randn(1,4) .* sqrt(propvariance);
        %uniform movement
        if rand < 0.2
            if rand < 0.5
                propvariance(2) = -propvariance(2);
            else
                propvariance(1) = -propvariance(1);
            end
        end
        
        rec(1:2) = rec(1:2) + rand(1,2) .* propvariance(1:2);
        
        pos = rec(1:2);
        siz = rec(3:4);
        
        pos(pos<1)=1;pos(pos>200)=1;
        siz(siz<10)=10;siz(siz>30)=40;
        
        rec = [pos,siz];
        

        new_movie(i) = getframe;
        
        %waitforbuttonpress
        clf;axis([0 394 0 314]);

    end
    obs = new_movie(2:end);
end


