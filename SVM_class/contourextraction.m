%%%%%%%%%%%%%%%%%%%������ȡ����
%%%%%%%%%%%%%%%%%%���ڵ�һ�����������ȡ֮��ֱ�Ӿ��ǽ�������Ϊ0�����ǲü���һ�鲻�������������
function newimg=contourextraction(f)
%     f=imread('1.jpg');
%     f=rgb2gray(f);                            %%%�����RGBͼƬ��һ������
    g=im2bw(f,graythresh(f));
    %%%%%%%%%%%%%%%%%%�����Աȶ�ֵͼ��֮���˲����ͼ�����ֶ�ֵͼ�Ŀ������Ը��󣬻��������������⣬�ʲ��ö�ֵͼ
%%%%%%%%%%%%%%%%%%%������������,��ֵͼ�ı�ǲ��յ��Ƕ�ֵͼ���Ŀ������ı�źͼ���������ȡ������
    [row,col]=size(g);
    L=zeros(row,col);   %%%��Ϊ��ǵ�
 for i=1:row
    for j=1:col
        L(i,j)=-1;
    end
end
%%%%%%%%%%%�Ƚ����ܵ�ı�ű�Ǻ�
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

% %%%%%%%%%%%%%%ͳ��һ���������һ��20%����ֵ����Ŀ��ֵ������һ�ж���Ϊ������
% %%%%%%%%%%%%%%����Ǹ����оͲ�������������кϲ��ɿ�,gap(j)=-1�� ����о��Ǹ���
% %%%%%%%%%%%%%%%%%��ʱδʵ�ֱȽ�ʵ�ʵĹ���
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
%%%%%%%%%%%%%ͨ���õ��ĵ㣬ɸѡ���������뵽����������ص�   �ҳ��߽�㻻���  ��С��Ӿ��εĳ���
%%%%%%%%%%%%��������о�����ıȽ϶�ļ�������
%%%%%%%%%%%%����Ѱ��ÿ���������  Ȼ�������������ģ��  �ҵ�Ӧ���ҵ��Ŀ�
%%%%%%%%%%%%��workspace������ؿ���  �ܹ���ct����  ���Բ���ct����
ct=max(max(L));
x_zhongxin=zeros(1,ct);
y_zhongxin=zeros(1,ct);
for mod=1:ct
    [m,n]=find(L==mod);
    x_zhongxin(mod)=(sum(m))/(length(m));
    y_zhongxin(mod)=sum(n)/(length(n));  
end
%%%%%%%%%%%%%%%%�õ���ct����Ȼ����Ϊ���ӵ㣬��������
%%%%%%%%%%%%%%%%%��������,����1
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
% imshow(im,[]);title('���');
% figure(985)
% imshow(im2,[]),title('����');
bwimg=imfill(im2,'holes');
bwimg=im2double(bwimg);
newimg=double(f).*bwimg;
% figure(2011)
% imshow(newimg,[]),title('��ȡ�õ�������');


end