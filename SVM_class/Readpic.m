%%%%%%%%%%%��ȡ����
function [f_matrix,realclass]=Readpic(npics,flag)
%����
%   npics-�������Ƭ��   ǰ5����ѵ������   ����5������֤����
%   imgrow-������Ϊȫ�ֱ���
%   imgcol-������Ϊȫ�ֱ���
%   flag-��־��0-����ѵ������ 1-�����������
%���
%��֪ȫ�ֱ�����imgrow=87 ,imgcol=424  �������Ѿ�ʹ��ԭ����ͼƬ��

global imgrow;
global imgcol;
realclass=zeros(npics*8,1);   %%%��ʱ����Ҫ������ص�5����
% f_matrix=zeros(npics*32,imgrow*imgcol);
% t_matrix=zeros(npics*8,imgrow*imgcol);
if flag==0
     f_matrix=zeros(npics*32,imgrow*imgcol);
else
    f_matrix=zeros(npics*8,imgrow*imgcol);
end
%%%%%%%%%Ѱ����Ƭλ��
for i=1:npics                  %%%%%%%%%%%%%%%��ͬ���������
    picpath='G:\desktop\experience_photo\text10_temprature_substraction';   %%%%��Ƭ��·��
    picpath=strcat(picpath,num2str(i));                  %%%%%Ѱ���ض����ļ���
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
          picpath=strcat(picpath,num2str(k));       %%%%%%%%%����ط���5  ��Ҫע���޸�
          realclass((i-1)*8+k)=i;
          picpath=strcat(picpath,'.jpg');
          img=imread(picpath);
         f_matrix((i-1)*8+k,:)=img(:)';
    end
    
end


end
    
    
    
    
    
    
    
    
    
    
    
%      for j=1:5
%         picpath=cachepath;
%         if  flag==0    %%%%%��ȡѵ��������ͼ�������
%             picpath=strcat(picpath,'0'+j);
%         else
%             %%%%%��ȡ��������
%             picpath=strcat(picpath,num2str(5+j));       %%%%%%%%%����ط���5  ��Ҫע���޸�
%             realclass((i-1)*5+j)=i;
%         end
%         picpath=strcat(picpath,'.jpg');
%         img=imread(picpath);
%         f_matrix((i-1)*5+j,:)=img(:)';
%     end
end


        
            


