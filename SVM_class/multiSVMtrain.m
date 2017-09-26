%%%%%%%%%%%%%%%SVM������ѵ��
function [multiSVMstruct] =multiSVMtrain(traindata,nclass,gamma,c)
%%%�����SVMѵ����

for i=1:(nclass-1)
    for j=(i+1):nclass
        X=[traindata((32*(i-1)+1):32*i,:);traindata((32*(j-1)+1):32*j,:)];
        Y=[ones(32,1);zeros(32,1)]; 
        multiSVMstruct{i}{j}=svmtrain(X,Y,'kernel_Function',@(X,Y) kfun_rbf(X,Y,gamma),'boxconstraint',c);
    end
end



end