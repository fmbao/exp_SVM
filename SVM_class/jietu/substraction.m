%%
%��ȥ��Ӧ�¶ȵ�ͼ��
%%%%�������һ��   �ĳ��������ļ��ж������õ�

clear
clc

str='G:\desktop\jietu\CSV\2\'; %������ͼ���ļ���
str1='G:\desktop\jietu\pics\2\temprature_substraction\';%�����ȥ��Ӧ�¶ȴ�����ͼ�ε��ļ���
str2='G:\desktop\jietu\pics\2\temprature_substraction1\';%�����ȥ��Ӧ�¶ȴ�����ͼ�ε��ļ��У���׼���任
str3='G:\desktop\jietu\pics\2\temprature_distribution\';%����ֱ�ӹ�һ��[0,1]������ͼ�ε��ļ���

for i=91:120
targetImage=csvread([str,num2str(i),'.csv'], 2,1); %���ζ�ȡÿһ��ͼ��
% targetImageData=targetImage-23.1;
% targetImageData=mat2gray(targetImageData); %I = mat2gray(A, [amin amax])��ͼ�����A�н���amin��amax�����ݹ�һ�������� ����С��amin��Ԫ�ض���Ϊ0�� ����amax��Ԫ�ض���Ϊ1��
 I=targetImage-26.1;  
% I=mat2gray(I);%ͼ��������ݹ�һ������I�ķ�Χ��һ����[0,1],0��Ӧ��ɫ��1��Ӧ��ɫ����ʾ�����������𲻵�ͼ���һ��������

% u=(x-min(min(x)))./(max(max(x))-min(min(x)));��I�ķ�Χ��һ����[0,1]
Y=(I-(-11.3700))./(25.3400-(-11.3700));
% Y=(1/29.422)*I+(11.3700/29.422);
Y=double(Y);
figure(1),imshow(Y);        
impixelinfo%����ʾͼ�������������λ�ö���ʾ
% imtool(grayimg/255);% imtool(I);%��ͼ������ʾ�Ҷ�ͼ��I��IΪ����Ԫ�ط�ΧΪ0-255.
% I=imread('230.jpg');
% graydraw = imadjust(I);%�����˶Աȶ�,������I����ӳ�䵽graydraw[0,1],����ͼ��ĶԱȶȣ�������mat2gray��ͬ
% [X,Y]=ginput(4);%ȡ�㷽ʽ�����ϡ����ϡ����¡����¡�
% inpts =[X(1) Y(1);X(2) Y(2);X(3) Y(3);X(4) Y(4)];

% drawedge=edge(Y,'canny');
drawedge=mat2gray(Y);
% drawedge=double(drawedge);
% level = graythresh(drawedge);
% bw = im2bw(drawedge,level);
% bw = bwareaopen(bw, 0);
figure(2),imshow(drawedge);
impixelinfo
[M,N]=ginput(4);%ȡ�㷽ʽ�����ϡ����ϡ����¡����¡�
inpts1 =[M(1) N(1);M(2) N(2);M(3) N(3);M(4) N(4)];

% inpts =[27.4676   94.0966;284.7313   96.4661;29.1601  145.2109; 284.0543  144.8724];%A��ʾԭͼ��4��ȡ��  
rectangle('Position',[inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%��Ƿ���������ɫ���ο�,���ȽϿ�

cropimg2 = imcrop(drawedge, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
cropimg1 = imcrop(Y, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
figure(3),imshow(cropimg1);

imwrite(cropimg1,[str1,num2str(i),'.jpg']);%����ԭͼ���ȡ�ľ��Σ������ȥ��Ӧ�¶ȴ�����ͼ�ε��ļ���
imwrite(cropimg2,[str3,num2str(i),'.jpg']);%����ֱ�ӹ�һ��[0,1]�������ȡ����ͼ�ε��ļ��У����¶ȷֲ������

   
%outpts=[inpts(1,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1), inpts(1,2)+inpts(3,2)-inpts(1,2); inpts(1,1) inpts(1,2)+inpts(3,2)-inpts(1,2)];%B��ʾͶӰ�任����ͼ��ĵ�
outpts=[1 1;424 1;1 87;424 87];

tform= maketform('projective',inpts1,outpts);
J=imtransform(Y,tform);
figure(4),imshow(J);
impixelinfo
rectangle('Position',[51,171,423,86],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%��Ƿ���������ɫ���ο�

cropimg = imcrop(J, [51,171,423,86]);% graydraw=imcrop(I,[100 270 800 180]);%ͼ��ü���������Ϊ�󶥵�����Ϊ���Ϳ�
figure(5),imshow(cropimg);


X=imtransform(Y,tform,'XData',[1 424],'YData',[1 87]);
figure(6),imshow(X);
impixelinfo

imwrite(X,[str2,num2str(i),'.jpg']);
% ginput();
end

%% �ڶ�����
for i=121:150
targetImage=csvread([str,num2str(i),'.csv'], 2,1); %���ζ�ȡÿһ��ͼ��
% targetImageData=targetImage-23.1;
% targetImageData=mat2gray(targetImageData); %I = mat2gray(A, [amin amax])��ͼ�����A�н���amin��amax�����ݹ�һ�������� ����С��amin��Ԫ�ض���Ϊ0�� ����amax��Ԫ�ض���Ϊ1��
 I=targetImage-26.7;  
% I=mat2gray(I);%ͼ��������ݹ�һ������I�ķ�Χ��һ����[0,1],0��Ӧ��ɫ��1��Ӧ��ɫ����ʾ�����������𲻵�ͼ���һ��������

% u=(x-min(min(x)))./(max(max(x))-min(min(x)));��I�ķ�Χ��һ����[0,1]
Y=(I-(-11.3700))./(25.3400-(-11.3700));
% Y=(1/29.422)*I+(11.3700/29.422);
Y=double(Y);
figure(1),imshow(Y);        
impixelinfo%����ʾͼ�������������λ�ö���ʾ
% imtool(grayimg/255);% imtool(I);%��ͼ������ʾ�Ҷ�ͼ��I��IΪ����Ԫ�ط�ΧΪ0-255.
% I=imread('230.jpg');
% graydraw = imadjust(I);%�����˶Աȶ�,������I����ӳ�䵽graydraw[0,1],����ͼ��ĶԱȶȣ�������mat2gray��ͬ
% [X,Y]=ginput(4);%ȡ�㷽ʽ�����ϡ����ϡ����¡����¡�
% inpts =[X(1) Y(1);X(2) Y(2);X(3) Y(3);X(4) Y(4)];

% drawedge=edge(Y,'canny');
drawedge=mat2gray(Y);
% drawedge=double(drawedge);
% level = graythresh(drawedge);
% bw = im2bw(drawedge,level);
% bw = bwareaopen(bw, 0);
figure(2),imshow(drawedge);
impixelinfo
[M,N]=ginput(4);%ȡ�㷽ʽ�����ϡ����ϡ����¡����¡�
inpts1 =[M(1) N(1);M(2) N(2);M(3) N(3);M(4) N(4)];

% inpts =[27.4676   94.0966;284.7313   96.4661;29.1601  145.2109; 284.0543  144.8724];%A��ʾԭͼ��4��ȡ��  
rectangle('Position',[inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%��Ƿ���������ɫ���ο�,���ȽϿ�

cropimg2 = imcrop(drawedge, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
cropimg1 = imcrop(Y, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
figure(3),imshow(cropimg1);

imwrite(cropimg1,[str1,num2str(i),'.jpg']);%����ԭͼ���ȡ�ľ��Σ������ȥ��Ӧ�¶ȴ�����ͼ�ε��ļ���
imwrite(cropimg2,[str3,num2str(i),'.jpg']);%����ֱ�ӹ�һ��[0,1]�������ȡ����ͼ�ε��ļ��У����¶ȷֲ������

   
%outpts=[inpts(1,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1), inpts(1,2)+inpts(3,2)-inpts(1,2); inpts(1,1) inpts(1,2)+inpts(3,2)-inpts(1,2)];%B��ʾͶӰ�任����ͼ��ĵ�
outpts=[1 1;424 1;1 87;424 87];

tform= maketform('projective',inpts1,outpts);
J=imtransform(Y,tform);
figure(4),imshow(J);
impixelinfo
rectangle('Position',[51,171,423,86],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%��Ƿ���������ɫ���ο�

cropimg = imcrop(J, [51,171,423,86]);% graydraw=imcrop(I,[100 270 800 180]);%ͼ��ü���������Ϊ�󶥵�����Ϊ���Ϳ�
figure(5),imshow(cropimg);


X=imtransform(Y,tform,'XData',[1 424],'YData',[1 87]);
figure(6),imshow(X);
impixelinfo

imwrite(X,[str2,num2str(i),'.jpg']);
% ginput();
end

%% ��������
for i=151:180
targetImage=csvread([str,num2str(i),'.csv'], 2,1); %���ζ�ȡÿһ��ͼ��
% targetImageData=targetImage-23.1;
% targetImageData=mat2gray(targetImageData); %I = mat2gray(A, [amin amax])��ͼ�����A�н���amin��amax�����ݹ�һ�������� ����С��amin��Ԫ�ض���Ϊ0�� ����amax��Ԫ�ض���Ϊ1��
 I=targetImage-25.8;  
% I=mat2gray(I);%ͼ��������ݹ�һ������I�ķ�Χ��һ����[0,1],0��Ӧ��ɫ��1��Ӧ��ɫ����ʾ�����������𲻵�ͼ���һ��������

% u=(x-min(min(x)))./(max(max(x))-min(min(x)));��I�ķ�Χ��һ����[0,1]
Y=(I-(-11.3700))./(25.3400-(-11.3700));
% Y=(1/29.422)*I+(11.3700/29.422);
Y=double(Y);
figure(1),imshow(Y);        
impixelinfo%����ʾͼ�������������λ�ö���ʾ
% imtool(grayimg/255);% imtool(I);%��ͼ������ʾ�Ҷ�ͼ��I��IΪ����Ԫ�ط�ΧΪ0-255.
% I=imread('230.jpg');
% graydraw = imadjust(I);%�����˶Աȶ�,������I����ӳ�䵽graydraw[0,1],����ͼ��ĶԱȶȣ�������mat2gray��ͬ
% [X,Y]=ginput(4);%ȡ�㷽ʽ�����ϡ����ϡ����¡����¡�
% inpts =[X(1) Y(1);X(2) Y(2);X(3) Y(3);X(4) Y(4)];

% drawedge=edge(Y,'canny');
drawedge=mat2gray(Y);
% drawedge=double(drawedge);
% level = graythresh(drawedge);
% bw = im2bw(drawedge,level);
% bw = bwareaopen(bw, 0);
figure(2),imshow(drawedge);
impixelinfo
[M,N]=ginput(4);%ȡ�㷽ʽ�����ϡ����ϡ����¡����¡�
inpts1 =[M(1) N(1);M(2) N(2);M(3) N(3);M(4) N(4)];

% inpts =[27.4676   94.0966;284.7313   96.4661;29.1601  145.2109; 284.0543  144.8724];%A��ʾԭͼ��4��ȡ��  
rectangle('Position',[inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%��Ƿ���������ɫ���ο�,���ȽϿ�

cropimg2 = imcrop(drawedge, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
cropimg1 = imcrop(Y, [inpts1(1,1),inpts1(1,2),inpts1(4,1)-inpts1(3,1),inpts1(3,2)-inpts1(1,2)]);
figure(3),imshow(cropimg1);

imwrite(cropimg1,[str1,num2str(i),'.jpg']);%����ԭͼ���ȡ�ľ��Σ������ȥ��Ӧ�¶ȴ�����ͼ�ε��ļ���
imwrite(cropimg2,[str3,num2str(i),'.jpg']);%����ֱ�ӹ�һ��[0,1]�������ȡ����ͼ�ε��ļ��У����¶ȷֲ������

   
%outpts=[inpts(1,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1),inpts(1,2);inpts(1,1)+inpts(4,1)-inpts(3,1), inpts(1,2)+inpts(3,2)-inpts(1,2); inpts(1,1) inpts(1,2)+inpts(3,2)-inpts(1,2)];%B��ʾͶӰ�任����ͼ��ĵ�
outpts=[1 1;424 1;1 87;424 87];

tform= maketform('projective',inpts1,outpts);
J=imtransform(Y,tform);
figure(4),imshow(J);
impixelinfo
rectangle('Position',[51,171,423,86],'Curvature',[0,0],'LineWidth',2,'EdgeColor','g');%��Ƿ���������ɫ���ο�

cropimg = imcrop(J, [51,171,423,86]);% graydraw=imcrop(I,[100 270 800 180]);%ͼ��ü���������Ϊ�󶥵�����Ϊ���Ϳ�
figure(5),imshow(cropimg);


X=imtransform(Y,tform,'XData',[1 424],'YData',[1 87]);
figure(6),imshow(X);
impixelinfo

imwrite(X,[str2,num2str(i),'.jpg']);
% ginput();
end



%%
% %Houghֱ�߼��
% bw=drawedge1;
% [H,T,R]=hough(bw);                                     %����任����ֱ�߼��
% P=houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% lines=houghlines(bw,T,R,P,'FillGap',25,'MinLength',50);  %��ü�⵽��ֱ��
% % lines=houghlines(BW,T,R,P,'FillGap',58,'MinLength',5);
% figure,imshow(bw),
% title('ֱ�߱�ǽ��'); 
% impixelinfo
% hold on
% max_len=0;
% for k=1:length(lines)    
%     xy=[lines(k).point1;lines(k).point2]; 
%     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green'); %���ֱ�߱�Ե��Ӧ�����  
%     plot(xy(1,1),xy(1,2),'y','LineWidth',2,'Color','blue'); 
%     plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red'); %����ֱ�߱�Ե����  
%     len=norm(lines(k).point1-lines(k).point2);  
%     if(len>max_len)    
%         max_len=len;     
%         xy_long=xy;   
%     end
% end
% 
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','r');
% % J=imtransform(I,tform,'XData',[1 424],'YData',[1 87]);






