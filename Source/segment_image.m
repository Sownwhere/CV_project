function [seg]=segment_image(I)
   
   seg=sobel(I);
    
end
function [seg]=sobel(I)
    image_size=size(I);
    dimension=numel(image_size);    
    if dimension==2
        Ig = I; 
    end
    if dimension==3
       Ig = im2gray(I);
    end
    ;
    Ig=medfilt2(Ig);
    seg=edge(Ig,"sobel");
  

end

function [r] = intensity_change_detection(Im)
    I = im2gray(Im);
%     I=im2double(Io);S
    Idiffv=I(1:end-1,:)-I(2:end,:);
    Idiffh=I(:,1:end-1)-I(:,2:end);
    Idiff=sqrt(Idiffh(1:end-1,:).^2+Idiffv(:,1:end-1).^2);
    r=imbinarize(Idiff,0.06);
    [x,y] = size(I);
    r(x,y)= 0;
   
end
function [seg]= Dog(I)  % Difference of Gussian
    gc=fspecial('gaussian',9,1);
    gs=fspecial('gaussian',9,1.5);
    IaBY=conv2(I(:,:,3),gc,'same')-conv2(mean(I(:,:,1:2),3),gs,'same'); %blue-on, yellow-of
    I=imbinarize(IaBY,0.01);
    dog=fspecial('gaussian',3,0.45)-fspecial('gaussian',3,0.5);
    Idiff = conv2(I,dog,'same');
    seg=imbinarize(Idiff,0.0001);
end

function [seg] = Can(I)
    ICanny=edge(I,'Canny');
    seg = ICanny;
end

%get Blue min yellow part 
function [seg] =BY(I)
    gc=fspecial('gaussian',9,1);
    gs=fspecial('gaussian',9,1.5);
    IaBY=conv2(I(:,:,3),gc,'same')-conv2(mean(I(:,:,1:2),3),gs,'same'); %blue-on, yellow-of
    seg=imbinarize(IaBY,0.01);
end


