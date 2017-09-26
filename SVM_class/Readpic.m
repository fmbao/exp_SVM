%%%%%%%%%%%读取数据
function [f_matrix,realclass]=Readpic(npics,flag)
%输入
%   npics-读入的照片数   前5张做训练样本   后面5张做验证样本
%   imgrow-行像素为全局变量
%   imgcol-列像素为全局变量
%   flag-标志，0-读入训练样本 1-读入测试样本
%输出
%已知全局变量：imgrow=87 ,imgcol=424  （假设已经使用原来的图片）

global imgrow;
global imgcol;
realclass=zeros(npics*8,1);   %%%到时候需要更改相关的5参数
% f_matrix=zeros(npics*32,imgrow*imgcol);
% t_matrix=zeros(npics*8,imgrow*imgcol);
if flag==0
     f_matrix=zeros(npics*32,imgrow*imgcol);
else
    f_matrix=zeros(npics*8,imgrow*imgcol);
end
%%%%%%%%%寻找照片位置
for i=1:npics                  %%%%%%%%%%%%%%%不同情况的种类
    picpath='G:\desktop\experience_photo\text10_temprature_substraction';   %%%%照片的路径
    picpath=strcat(picpath,num2str(i));                  %%%%%寻找特定的文件夹
    picpath=strcat(picpath,'\');
    cachepath=picpath;  
if  flag==0  
    for  j=1:32
         picpath=cachepath;
         picpath=strcat(picpath,num2str(j));
         picpath=strcat(picpath,'.jpg');
         img=imread(picpath);
         f_matrix((i-1)*32+j,:)=img(:)';
    end
else
    for j=33:40
            k=j-32;
            picpath=cachepath;
          picpath=strcat(picpath,num2str(k));       %%%%%%%%%这个地方的5  需要注意修改
          realclass((i-1)*8+k)=i;
          picpath=strcat(picpath,'.jpg');
          img=imread(picpath);
         f_matrix((i-1)*8+k,:)=img(:)';
    end
    
end


end
    
    
    
    
    
    
    
    
    
    
    
%      for j=1:5
%         picpath=cachepath;
%         if  flag==0    %%%%%读取训练样本的图像的数据
%             picpath=strcat(picpath,'0'+j);
%         else
%             %%%%%读取测试数据
%             picpath=strcat(picpath,num2str(5+j));       %%%%%%%%%这个地方的5  需要注意修改
%             realclass((i-1)*5+j)=i;
%         end
%         picpath=strcat(picpath,'.jpg');
%         img=imread(picpath);
%         f_matrix((i-1)*5+j,:)=img(:)';
%     end
end


        
            


