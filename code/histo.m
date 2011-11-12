function [ hist ] = histo( im,y,a,bins )

% histo returns a bins x 3 matrix that contains the 
% distribution for the RGB space of the image im. 
% The further away points are from y, the less they contribute
% to the distribution. The distribution are normalized so that
% they can be seen as probability distributions.

% inputs:
% im - RGB image we are seeking the histogram from 
% y - (Center) 2x1 point that we use for weighting the histogram
% a - factor to influence the weighting by adapting the size of the region
% bins - Number of bins for the histogram



[rows,cols,rgb] = size(im);
% adapt size of the region
%a = norm([rows,cols])
%a = sqrt(rows^2+cols^2);

% kernel
k = zeros(rows,cols);

for i=1:rows
    for j=1:cols
        k(i,j) = 1- (norm([i,j]-y)/a)^2;
        if k(i,j)<0
            y
            n = norm([i,j]-y)
            a = a
            k = k(i,j)
            error('no good, kernel is negative, make "a" bigger or set k(i,j) to zero');
        end
        
        
        
        
    end
end

% for every color RGB 
hist = zeros(bins,rgb);
binsf = 256/bins;

for i=1:rows
    for j=1:cols
    
        % we weight our histogram according to the distances calculated above
        w = k(i,j);
        %w=1;
        
        rbin = 1+ floor(double(im(i,j,1))/binsf);
        gbin = 1+ floor(double(im(i,j,2))/binsf);
        bbin = 1+ floor(double(im(i,j,3))/binsf);
        
        hist(rbin,1) = hist(rbin,1)+w;
        hist(gbin,2) = hist(gbin,2)+w;
        hist(bbin,3) = hist(bbin,3)+w;
        
        %same thing
%         rgb_im = floor(double(im(i,j,:)/binsf))+1;
%         hist(rgb_im(1),1) = hist(rgb_im(1),1)+w;
%         hist(rgb_im(2),2) = hist(rgb_im(2),2)+w;
%         hist(rgb_im(3),3) = hist(rgb_im(3),3)+w;    

    end
end

f = sum(sum(k));

hist = hist/f;



