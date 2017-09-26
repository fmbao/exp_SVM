%%%%计算出sum_area和区域数量，区域块数量打算用作后期的权重
function [sum_area,block_num]= region_num(gray_img)


% gray_img = imread('250.jpg');
%  gray_img = rgb2gray(img);
T = graythresh(gray_img);
 bw_img = im2bw(gray_img, T);
 img_reg = regionprops(bw_img,  'area', 'boundingbox');
 areas = [img_reg.Area];
 rects = cat(1,  img_reg.BoundingBox);
% figure(1)
%  imshow(gray_img);
%  for i = 1:size(rects, 1)  
%            rectangle('position', rects(i, :), 'EdgeColor', 'r');  
%  end

% 以上代码已经可以标记处全部斑块

% 以下代码用于标记最大斑块
[~, max_id] = max(areas);
 max_rect = rects(max_id, :);
%  figure(2),
%  imshow(bw_img);
%  rectangle('position', max_rect, 'EdgeColor', 'r')
 x_1=max_rect(1,1);
 y_1=max_rect(1,2);
 x_2=max_rect(1,3);
 y_2=max_rect(1,4);
 final_imag_first=gray_img(y_1:y_2,x_1:x_2);
% figure(11)
% imshow(final_imag_first);
[m,n]=size(final_imag_first);
aera_final_first=m*n;
new_areas=sort(areas,'descend');
for i=1:size(rects, 1) 
    if  areas(i)==new_areas(2)
        flag=i;
    end
end

block_num=size(rects, 1) ;
 x_3=rects(flag,1);
 
 x_4=rects(flag,3);
if  x_3<x_1  && x_4>x_1
sum_area=aera_final_first+new_areas(2);
else
    sum_area=aera_final_first;
end

end