%%%%%%%%%%%%%%%%%数据规范化
function [scaledpic]=scaling(picMat,lowvec,upvec)
%特征数据规范化
%输入-picMat需要规范化图像数据
%        lowvec-原来的最小值
%        upvec-原来的最大值

upnew=1;
lownew=-1;
[m,n]=size(picMat);
scaledpic=zeros(m,n);
for i=1:m
    scaledpic(i,:)=lownew+(picMat(i,:)-lowvec)./(upvec-lowvec)*(upnew-lownew);
end



end