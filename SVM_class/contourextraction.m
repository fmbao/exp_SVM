%%%%%%%%%%%%%%%%%%%区域提取函数
%%%%%%%%%%%%%%%%%%现在的一个问题就是提取之后直接就是将背景置为0？还是裁剪出一块不规则的轮廓出来
function newimg=contourextraction(f)
%     f=imread('1.jpg');
%     f=rgb2gray(f);                            %%%如果是RGB图片这一步加上
    g=im2bw(f,graythresh(f));
    %%%%%%%%%%%%%%%%%%经过对比二值图和之后滤波后的图，发现二值图的可利用性更大，划分区域令人满意，故采用二值图
%%%%%%%%%%%%%%%%%%%进行区域搜索,二值图的标记参照的是二值图像多目标区域的标号和几何特征提取的文章
    [row,col]=size(g);
    L=zeros(row,col);   %%%作为标记的
 for i=1:row
    for j=1:col
        L(i,j)=-1;
    end
end
%%%%%%%%%%%先将四周点的标号标记好
for i=1:row
    if g(i,1)==1
        L(i,1)=0;
    end
    if g(i,col)==1;
        L(i,col)=0;
    end
end

for j=1:col
    if g(1,j)==1
        L(1,j)=0;
    end
    if g(row,j)==1;
        L(row,j)=0;
    end
end
count=0;
for i=2:row
    for j=2:col
       
        if g(i-1,j)==0 && g(i,j-1)==1 && g(i,j)==1
            count=L(i,j-1);
            L(i,j)=count;
        end
        if g(i-1,j)==1 && g(i,j-1)==0 && g(i,j)==1
             count=L(i-1,j);
            L(i,j)=count;
        end
        if g(i-1,j)==1 && g(i,j-1)==1 && g(i,j)==1
            L(i,j)=L(i,j-1);
            L(i,j)=L(i-1,j);
            count=L(i,j);
        end
        if g(i-1,j)==0 && g(i,j-1)==0 && g(i,j)==1
            count=count+1;
            L(i,j)=count;
        end
        if g(i-1,j)==g(i,j-1)==1 && L(i-1,j)~=L(i,j-1) && g(i,j)==1
            count=min(L(i-1,j),L(i,j-1));
            L(i-1,j)=count;
            L(i,j-1)=count;
            L(i,j)=count;
        end  

    end
end
% figure(2)
% imshow(L);

% %%%%%%%%%%%%%%统计一下列如果这一列20%（阈值）是目标值，则将这一列定义为隔断列
% %%%%%%%%%%%%%%如果是隔断列就不允许将两个块进行合并成块,gap(j)=-1则 这个列就是隔断
% %%%%%%%%%%%%%%%%%暂时未实现比较实际的功能
% gap=zeros(1,col);
% for j=1:col
%     sum_gap=0;
%     for i=1:row
%     if L(i,j)==-1
%         sum_gap=sum_gap+1;
%     end
%     end
%     if  double(sum_gap/col)>0.8
%         gap(j)=-1;
%     end
% end
%%%%%%%%%%%%%通过得到的点，筛选出可以融入到大区域的像素点   找出边界点换算出  最小外接矩形的长宽
%%%%%%%%%%%%这个方案感觉会损耗比较多的计算性能
%%%%%%%%%%%%改用寻找每个块的重心  然后采用主动轮廓模型  找到应该找到的块
%%%%%%%%%%%%在workspace很清楚地看到  总共有ct个块  所以采用ct个点
ct=max(max(L));
x_zhongxin=zeros(1,ct);
y_zhongxin=zeros(1,ct);
for mod=1:ct
    [m,n]=find(L==mod);
    x_zhongxin(mod)=(sum(m))/(length(m));
    y_zhongxin(mod)=sum(n)/(length(n));  
end
%%%%%%%%%%%%%%%%得到的ct个点然后作为种子点，区域增长
%%%%%%%%%%%%%%%%%区域增长,方法1
 x_zhongxin(isnan( x_zhongxin)) = [];
  y_zhongxin(isnan( y_zhongxin)) = [];
  ct=length(y_zhongxin);

segF=zeros(row,col);
final=segF;
for mod=1:ct
    segF=regionGrow(x_zhongxin(mod),y_zhongxin(mod),f,3);
    final=final|segF;
end
final=final|g;
im=imfill(final,'holes');
im2=bwperim(im);
% figure(211)
% imshow(im,[]);title('填充');
% figure(985)
% imshow(im2,[]),title('轮廓');
bwimg=imfill(im2,'holes');
bwimg=im2double(bwimg);
newimg=double(f).*bwimg;
% figure(2011)
% imshow(newimg,[]),title('提取得到的区域');


end