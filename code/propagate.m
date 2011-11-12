function S = propagate( SS,n )

%
% This function propages a state according to a simple
% dynamical model.
% 
% 
% Input:
% SS - original states to propagate
% n - a vector containg the variances of the different state features  
%
% Output:
% S - updated states that have been propagated
% 


%state = [134,40,3,4,20,20,0.05];
%n = [5,5,5,5,5,5,0.001];

N = size(SS,1);
S = zeros(size(SS));

A = [1 0 1 0 0 0 0;
     0 1 0 1 0 0 0;
     0 0 1 0 0 0 0;
     0 0 0 1 0 0 0;
     0 0 0 0 1 0 0;
     0 0 0 0 0 1 0;
     0 0 0 0 0 0 1];

width = 320; 
%height = 240;
height = 120;

for i=1:N
    
    s = SS(i,:);   
    A(5,5) = 1+s(7);
    A(6,6) = 1+s(7);
    
    ps = A * s';
    ps = ps' + randn(1,7) .* sqrt(n);
    ps(1:6) = round(ps(1:6));
    
    %enforce maximas
    if ps(1)<1 , ps(1)=1 ;end
    if ps(1)>height , ps(1)=height ;end
    if ps(2)<1 , ps(2)=1 ;end
    if ps(2)>width , ps(2)=width ;end
   
    vmax = 10;
    if ps(3)<-vmax , ps(3)=-vmax ;end
    if ps(3)>vmax , ps(3)=vmax ;end    
    if ps(4)<-vmax , ps(4)=-vmax ;end
    if ps(4)>vmax , ps(4)=vmax ;end    

    if ps(5)<5 , ps(5)=5 ;end
    if ps(5)>25 , ps(5)=25 ;end    
    if ps(6)<5 , ps(6)=5 ;end
    if ps(6)>25 , ps(6)=25 ;end    

    if ps(7)<-0.1 , ps(7)=-0.1 ;end
    if ps(7)>0.1 , ps(7)=0.1 ;end     
    
    S(i,:) = ps;
 
end

%[SS S]