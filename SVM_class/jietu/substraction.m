%%
%减去相应温度的图像
%%%%将程序改一改   改成五个五个文件夹都可以用的

clear
clc

str='G:\desktop\jietu\CSV\2\'; %待处理图像文件夹
str1='G:\desktop\jietu\pics\2\temprature_substraction\';%保存减去对应温度处理后图形的文件夹
str2='G:\desktop\jietu\pics\2\temprature_substraction1\';%保存减去对应温度处理后图形的文件夹：标准化变换
str3='G:\desktop\jietu\pics\2\temprature_distribution\';%保存直接归一化[0,1]处理后图形的文件夹

for i=91:120
targetImage=csvread([str,num2str(i),'.csv'], 2,1); %依次读取每一幅图像
% targetImageData=targetImage-23.1;
% targetImageData=mat2gray(targetImageData); %I = mat2gray(A, [amin amax])将图像矩阵A中介于amin和amax的数据归一化处理， 其余小于amin的元素都变为0， 大于amax的元素都变为1。
 I=targetImage-26.1;  
% I=mat2gray(I);%图像矩阵数据归一化，将I的范围归一化到[0,1],0对应黑色，1对应白色，显示很清晰，但起不到图像归一化的作用

% u=(x-min(min(x)))./(max(max(x))-min(min(x)));将I的范围归一化到[0,1]
Y=(I-(-11.3700))./(25.3400-(-11.3700));
% Y=(1/29.422)*I+(11.3700/29.422);
Y=double(Y);
figure(1),imshow(Y);        
impixelinfo%在显示图像上坐标随鼠标位置而显示
% imtool(grayimg/255);% imtool(I);%在图形中显示灰度图像I，I为矩阵，元素范围为0-255.
% I=imread('230.jpg');
% graydraw = imadjust(I);%增加了对比度,将矩阵I先行映射到graydraw[0,1],增加图像的对比度，作用于mat2gray相同
% [X,Y]=ginput(4);%取点方式：左上、右上、左下、右下。
% inpts =[X(1) Y(1);X(2) Y(2);X(3) Y(3);X(4) Y(4)];

% drawedge=edge(Y,'canny');
drawedge=mat2gray(Y);
% drawedge=double(drawedge);
% level = graythresh(drawedge);
% bw = im2bw(drawedge,level);
% bw = bwareaopen(bw, 0);
figure(2),imshow(drawedge);
impixelinfo
[M,N]=ginput(4);%取点方式：左上、右上、左下、右下。
inpts1 =[M(1) N(1);M(2) N(2);M(3) N(3);M(4) N(4)];

% inpts =[27.4676   94.0966;284.7313   96.4661;29.1601  145.2109; 284.0543  144.8724];%A表示原图的4个取点  
rectangle('Position',[inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%标记服务器的绿色矩形框,左侧比较宽

cropimg2 = imcrop(drawedge, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
cropimg1 = imcrop(Y, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
figure(3),imshow(cropimg1);

imwrite(cropimg1,[str1,num2str(i),'.jpg']);%保存原图像截取的矩形，保存减去对应温度处理后图形的文件夹
imwrite(cropimg2,[str3,num2str(i),'.jpg']);%保存直接归一化[0,1]处理后截取矩形图形的文件夹，看温度分布情况的

   
%outpts=[inpts(1,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1), inpts(1,2)+inpts(3,2)-inpts(1,2); inpts(1,1) inpts(1,2)+inpts(3,2)-inpts(1,2)];%B表示投影变换后新图像的点
outpts=[1 1;424 1;1 87;424 87];

tform= maketform('projective',inpts1,outpts);
J=imtransform(Y,tform);
figure(4),imshow(J);
impixelinfo
rectangle('Position',[51,171,423,86],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%标记服务器的绿色矩形框

cropimg = imcrop(J, [51,171,423,86]);% graydraw=imcrop(I,[100 270 800 180]);%图像裁剪左两个数为左顶点依次为长和宽
figure(5),imshow(cropimg);


X=imtransform(Y,tform,'XData',[1 424],'YData',[1 87]);
figure(6),imshow(X);
impixelinfo

imwrite(X,[str2,num2str(i),'.jpg']);
% ginput();
end

%% 第二部分
for i=121:150
targetImage=csvread([str,num2str(i),'.csv'], 2,1); %依次读取每一幅图像
% targetImageData=targetImage-23.1;
% targetImageData=mat2gray(targetImageData); %I = mat2gray(A, [amin amax])将图像矩阵A中介于amin和amax的数据归一化处理， 其余小于amin的元素都变为0， 大于amax的元素都变为1。
 I=targetImage-26.7;  
% I=mat2gray(I);%图像矩阵数据归一化，将I的范围归一化到[0,1],0对应黑色，1对应白色，显示很清晰，但起不到图像归一化的作用

% u=(x-min(min(x)))./(max(max(x))-min(min(x)));将I的范围归一化到[0,1]
Y=(I-(-11.3700))./(25.3400-(-11.3700));
% Y=(1/29.422)*I+(11.3700/29.422);
Y=double(Y);
figure(1),imshow(Y);        
impixelinfo%在显示图像上坐标随鼠标位置而显示
% imtool(grayimg/255);% imtool(I);%在图形中显示灰度图像I，I为矩阵，元素范围为0-255.
% I=imread('230.jpg');
% graydraw = imadjust(I);%增加了对比度,将矩阵I先行映射到graydraw[0,1],增加图像的对比度，作用于mat2gray相同
% [X,Y]=ginput(4);%取点方式：左上、右上、左下、右下。
% inpts =[X(1) Y(1);X(2) Y(2);X(3) Y(3);X(4) Y(4)];

% drawedge=edge(Y,'canny');
drawedge=mat2gray(Y);
% drawedge=double(drawedge);
% level = graythresh(drawedge);
% bw = im2bw(drawedge,level);
% bw = bwareaopen(bw, 0);
figure(2),imshow(drawedge);
impixelinfo
[M,N]=ginput(4);%取点方式：左上、右上、左下、右下。
inpts1 =[M(1) N(1);M(2) N(2);M(3) N(3);M(4) N(4)];

% inpts =[27.4676   94.0966;284.7313   96.4661;29.1601  145.2109; 284.0543  144.8724];%A表示原图的4个取点  
rectangle('Position',[inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%标记服务器的绿色矩形框,左侧比较宽

cropimg2 = imcrop(drawedge, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
cropimg1 = imcrop(Y, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
figure(3),imshow(cropimg1);

imwrite(cropimg1,[str1,num2str(i),'.jpg']);%保存原图像截取的矩形，保存减去对应温度处理后图形的文件夹
imwrite(cropimg2,[str3,num2str(i),'.jpg']);%保存直接归一化[0,1]处理后截取矩形图形的文件夹，看温度分布情况的

   
%outpts=[inpts(1,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1), inpts(1,2)+inpts(3,2)-inpts(1,2); inpts(1,1) inpts(1,2)+inpts(3,2)-inpts(1,2)];%B表示投影变换后新图像的点
outpts=[1 1;424 1;1 87;424 87];

tform= maketform('projective',inpts1,outpts);
J=imtransform(Y,tform);
figure(4),imshow(J);
impixelinfo
rectangle('Position',[51,171,423,86],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%标记服务器的绿色矩形框

cropimg = imcrop(J, [51,171,423,86]);% graydraw=imcrop(I,[100 270 800 180]);%图像裁剪左两个数为左顶点依次为长和宽
figure(5),imshow(cropimg);


X=imtransform(Y,tform,'XData',[1 424],'YData',[1 87]);
figure(6),imshow(X);
impixelinfo

imwrite(X,[str2,num2str(i),'.jpg']);
% ginput();
end

%% 第三部分
for i=151:180
targetImage=csvread([str,num2str(i),'.csv'], 2,1); %依次读取每一幅图像
% targetImageData=targetImage-23.1;
% targetImageData=mat2gray(targetImageData); %I = mat2gray(A, [amin amax])将图像矩阵A中介于amin和amax的数据归一化处理， 其余小于amin的元素都变为0， 大于amax的元素都变为1。
 I=targetImage-25.8;  
% I=mat2gray(I);%图像矩阵数据归一化，将I的范围归一化到[0,1],0对应黑色，1对应白色，显示很清晰，但起不到图像归一化的作用

% u=(x-min(min(x)))./(max(max(x))-min(min(x)));将I的范围归一化到[0,1]
Y=(I-(-11.3700))./(25.3400-(-11.3700));
% Y=(1/29.422)*I+(11.3700/29.422);
Y=double(Y);
figure(1),imshow(Y);        
impixelinfo%在显示图像上坐标随鼠标位置而显示
% imtool(grayimg/255);% imtool(I);%在图形中显示灰度图像I，I为矩阵，元素范围为0-255.
% I=imread('230.jpg');
% graydraw = imadjust(I);%增加了对比度,将矩阵I先行映射到graydraw[0,1],增加图像的对比度，作用于mat2gray相同
% [X,Y]=ginput(4);%取点方式：左上、右上、左下、右下。
% inpts =[X(1) Y(1);X(2) Y(2);X(3) Y(3);X(4) Y(4)];

% drawedge=edge(Y,'canny');
drawedge=mat2gray(Y);
% drawedge=double(drawedge);
% level = graythresh(drawedge);
% bw = im2bw(drawedge,level);
% bw = bwareaopen(bw, 0);
figure(2),imshow(drawedge);
impixelinfo
[M,N]=ginput(4);%取点方式：左上、右上、左下、右下。
inpts1 =[M(1) N(1);M(2) N(2);M(3) N(3);M(4) N(4)];

% inpts =[27.4676   94.0966;284.7313   96.4661;29.1601  145.2109; 284.0543  144.8724];%A表示原图的4个取点  
rectangle('Position',[inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%标记服务器的绿色矩形框,左侧比较宽

cropimg2 = imcrop(drawedge, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
cropimg1 = imcrop(Y, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
figure(3),imshow(cropimg1);

imwrite(cropimg1,[str1,num2str(i),'.jpg']);%保存原图像截取的矩形，保存减去对应温度处理后图形的文件夹
imwrite(cropimg2,[str3,num2str(i),'.jpg']);%保存直接归一化[0,1]处理后截取矩形图形的文件夹，看温度分布情况的

   
%outpts=[inpts(1,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1), inpts(1,2)+inpts(3,2)-inpts(1,2); inpts(1,1) inpts(1,2)+inpts(3,2)-inpts(1,2)];%B表示投影变换后新图像的点
outpts=[1 1;424 1;1 87;424 87];

tform= maketform('projective',inpts1,outpts);
J=imtransform(Y,tform);
figure(4),imshow(J);
impixelinfo
rectangle('Position',[51,171,423,86],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%标记服务器的绿色矩形框

cropimg = imcrop(J, [51,171,423,86]);% graydraw=imcrop(I,[100 270 800 180]);%图像裁剪左两个数为左顶点依次为长和宽
figure(5),imshow(cropimg);


X=imtransform(Y,tform,'XData',[1 424],'YData',[1 87]);
figure(6),imshow(X);
impixelinfo

imwrite(X,[str2,num2str(i),'.jpg']);
% ginput();
end



%%
% %Hough直线检测
% bw=drawedge1;
% [H,T,R]=hough(bw);                                     %霍夫变换进行直线检测
% P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% lines=houghlines(bw,T,R,P,'FillGap',25,'MinLength',50);  %获得检测到的直线
% % lines=houghlines(BW,T,R,P,'FillGap',58,'MinLength',5);
% figure,imshow(bw),
% title('直线标记结果'); 
% impixelinfo
% hold on
% max_len=0;
% for k=1:length(lines)    
%     xy=[lines(k).point1;lines(k).point2]; 
%     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green'); %标记直线边缘对应的起点  
%     plot(xy(1,1),xy(1,2),'y','LineWidth',2,'Color','blue'); 
%     plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red'); %计算直线边缘长度  
%     len=norm(lines(k).point1-lines(k).point2);  
%     if(len>max_len)    
%         max_len=len;     
%         xy_long=xy;   
%     end
% end
% 
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','r');
% % J=imtransform(I,tform,'XData',[1 424],'YData',[1 87]);







