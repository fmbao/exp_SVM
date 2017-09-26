%%%%%%%%%%%%%%%%%���ݹ淶��
function [scaledpic]=scaling(picMat,lowvec,upvec)
%�������ݹ淶��
%����-picMat��Ҫ�淶��ͼ������
%        lowvec-ԭ������Сֵ
%        upvec-ԭ�������ֵ

upnew=1;
lownew=-1;
[m,n]=size(picMat);
scaledpic=zeros(m,n);
for i=1:m
    scaledpic(i,:)=lownew+(picMat(i,:)-lowvec)./(upvec-lowvec)*(upnew-lownew);
end



end