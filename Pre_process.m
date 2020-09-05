
%   Iset='\PutDB\JPG\Train'; % Path to the DB that need to be pre-processed

im=imageSet(Iset);
% e=size(dir(fullfile(Iset,'*.jpg')),1);
faceDetector = vision.CascadeObjectDetector('EyePairBig');


for i=1:im.Count

im=read(im,i);
im=rgb2gray(im);

bbox = step(faceDetector, im);
[x,~]=find(bbox==max(bbox(:,3)));
bbox(x,end) = bbox(x,end-1);

im = im(bbox(x,2):bbox(x,2)+bbox(x,4),...
    bbox(x,1):bbox(x,1)+bbox(x,3));

if ~isempty(bbox)
im=imresize(im,[240 240]);

db{i}=im;

end
end

%% Wrting to a folder
% e=size(db,2)
% 
% for i=1:e
%  
%     if ~isempty(db{i})
%        im=db{i};
%        imwrite(im,sprintf('%d.jpg',i))
%     end
% end
%% Rename
% Im='\PutDB\Real\Test';   
% imo=imageSet(Im);
% for i=1:imo.Count    
% imorp=read(imo,i);
% imwrite(imorp,sprintf('%d.jpg',i+268))
% end

