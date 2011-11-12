
in_dir = 'Movie/multi/';   
fout = 'Movie/multimodal.avi';
%total number of images is 611
num_images = 179;  
  
%Set a suitable frame rate fps 
aviobj = avifile(fout, 'compression', 'none', 'fps', 25); 
  
  
for i = 50:2:num_images; 
    temp = sprintf('%d', i); 
    name = [in_dir, 'output', temp, '.jpg'];
    img = imread(name); 
    img = imresize(img, [240 320], 'bilinear'); 
    
    img = img(1:120,:,:);
    
    %waitforbuttonpress
    frm = im2frame(img); 
    aviobj = addframe(aviobj,frm);         
    i 
end; 
  
aviobj = close(aviobj); 
return;