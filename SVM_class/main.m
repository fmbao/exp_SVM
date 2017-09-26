clc,clear
nclas=5;%选取40个照片
global imgrow;
global imgcol;
global edit2
imgrow=87;     %%%%%%选择的照片的大小，应该都改为87，424
imgcol=424;
%%%%%%%%%%%%%%%基本过程就是将特征划分到一行然后贴上标签，同样的还有测试集的数据
feature1_7=zeros(300,7);
feature8_9=zeros(300,2);
feature10_14=zeros(300,5);
feature15_73=zeros(300,59);
feature74_75=zeros(300,2);
feature76_78=zeros(300,3);
feature79_3678=zeros(300,3600);
feature3679_7278=zeros(300,3600);
I=cell(5,60); 
I_1=I;
% I_1=cell(5,40); 
p=cell(60,5);
count=0;
% for i=1:5                  %%%%%%%%%%%%%%%不同情况的种类
%     picpath='C:\Users\Administrator\Desktop\实验\区域提取+特征提取+SVM分类\text10_temprature_substraction';   %%%%照片的路径
%     picpath=strcat(picpath,num2str(i)); 
%     cd (picpath);
% % I{1,1}=imread('1.jpg');
%     Im=dir('*.jpg');
% %     N=length(Im);
% %     I=cell(1,N); 
% %     I_1=cell(1,N); 
% %     p=cell(N,1);
%     for k=1:40 
%         I{i,k}=imread(Im(k,1).name);
%     end
%     cd ..
% end
%  I_1=I;
 
%% 训练数据
for i=1:5                 
    picpath='C:\Users\Administrator\Desktop\实验\区域提取+特征提取+SVM分类\text10_temprature_substraction';   %%%%照片的路径
    picpath=strcat(picpath,num2str(i)); 
    filename1=strcat(picpath,'\');
% I{1,1}=imread('1.jpg');
    for j=(1+(i-1)*90):(60+(i-1)*90)
        filename=strcat(filename1,num2str(j),'.jpg');
        I{i,(j-(i-1)*90)}=imread(filename);
        filename=filename1;
    end
   
end

T=cell(5,30);
T_1=T;
%% 测试数据
for i=1:5                 
    picpath='C:\Users\Administrator\Desktop\实验\区域提取+特征提取+SVM分类\text10_temprature_substraction';   %%%%照片的路径
    picpath=strcat(picpath,num2str(i)); 
    filename1=strcat(picpath,'\');
% I{1,1}=imread('1.jpg');
    for j=(90*i-29):i*90
        filename=strcat(filename1,num2str(j),'.jpg');
        T{i,(j-90*i+30)}=imread(filename);
        filename=filename1;
    end
   
end

 %% 提取训练数据特征
 %%%%%%现在的问题是可能是特征选择的不好，导致的泛化能力不强，现在有的几种特征是特征1-7：不变矩、特征8-9：面积和欧拉数
 %%%%%%%特征10-14：tamura纹理特征、特征15-73：LBP纹理特征、 特征74_75：加上整体的灰度值和标准差  
 %%%%%%%特征76_78:连通域面积（第一，第二大面积相加（有判断标准）），最大面积之间的标准差，最大面积之间的方差
 %%%%%%%特征79_3678是HOG的特征，特征3679_ 是信息熵的特征

for j=1:5
    for k=1:60
     count=count+1;
    imag=I{j,k};
    imag_1=I{j,k};
    SM=sum(imag_1(:));
    feature79_3678(count,:)=cell2mat(HOG(imag));
    feature3679_7278(count,:)=entropy(imag);
    [sum_area,block_num] =region_num(imag_1);
    sum_block=sum_area*block_num/10;
    feature76_78(count,:)=[sum_area,block_num,sum_block];
    feature74_75(count,:)=[mean2(imag_1),SM];
    imag=contourextraction(imag);
    I_1{j,k}=contourextraction(I{j,k});
%      I{j,k}=contourextraction(I{j,k});
    th = graythresh(imag);           %确定阈值
    I_1{j,k}=im2bw(imag,th);      %二值化 
    imag= I_1{j,k};
    I_1{j,k}=imopen(I_1{j,k},strel('disk',3));    %开运算
    I_1{j,k}=imfill(I_1{j,k}, 'holes');    %填充
    I_1{j,k}=~I_1{j,k};                        %取反
    Area=bwarea(I_1{j,k})/(imgrow*imgcol);    %求面积
    Euler=bweuler(I_1{j,k});             %求欧拉数
% I_1{1,k}=double(I_1{1,k});
    p{k,j}=imagejui(imag);               %不变距
    feature8_9(count,:)=[Area,Euler];
     feature1_7(count,:)=[p{k,j}]';
     
     Fcrs{k,j}=coarseness(I{j,k},4);
     Fcon{k,j}=contrast(I{j,k});
     [Fdir{k,j},sita{k,j}]=directionality(I{j,k});
     Flin{k,j}=linelikeness(I{j,k},sita{k,j},4);
%  Freg{k,1}=regularity(I{1,k},32);
     Frgh{k,j}=Fcrs{k,j}+Fcon{k,j};
     feature10_14(count,:)=[ Fcrs{k,j}, Fcon{k,j},Fdir{k,j},Flin{k,j},Frgh{k,j}];
     mapping=getmapping(8,'u2');   
     feature15_73(count,:)=lbp(I{j,k},1,8,mapping,'h'); %LBP histogram in (8,1) neighborhood  using uniform patterns
                                   
    end
end
% ,feature79_3678,,feature3679_7278,feature74_75,feature8_9,feature10_14,feature15_73,feature1_7,,feature79_3678
%  feature1_7,feature8_9,feature10_14,,feature3679_7278,feature79_3678,feature15_73,
feature_sum=cat(2,feature8_9,feature74_75,feature76_78,feature15_73,feature3679_7278);

%% 提取测试数据的特征
%%%%%%%%%%%%%%%%%%%%读取测试数据部分，测试数据与训练数据比例在1:4
feature_c_1_7=zeros(150,7);
feature_c_8_9=zeros(150,2);
feature_c_10_14=zeros(150,5);
feature_c_15_73=zeros(150,59);
feature_c_74_75=zeros(150,2);
feature_c_76_78=zeros(150,3);
feature_c_79_3678=zeros(150,3600);
feature_c_3679_7278=zeros(150,3600);
realclass=zeros(150,1);

count=0;
T_p=cell(30,5);
    %%%%%%%%%%%%%%%%算出这150个测试集的73个特征
for i=1:5
     for j=1:30
     count=count+1;
     T_1=T;
    imag=T{i,j};
    imag_1=T{i,j};
    SM_c_=sum(imag_1(:));
     [sum_area,block_num] =region_num(imag_1);
     sum_block=sum_area*block_num/10;
    feature_c_79_3678(count,:)=cell2mat(HOG(imag));
     feature_c_3679_7278(count,:)=entropy(imag);
    feature_c_76_78(count,:)=[sum_area,block_num,sum_block];
    feature_c_74_75(count,:)=[mean2(imag_1),SM_c_];
     imag=contourextraction(imag);
     T_1{i,j}=contourextraction( T_1{i,j});
%     testpics{1,k}=contourextraction(testpics{1,k});
    
    th = graythresh(imag);    %确定阈值
    T_1{i,j}=im2bw(imag,th);      %二值化 
    imag= T_1{i,j};
    T_1{i,j}=imopen(T_1{i,j},strel('disk',3));    %开运算
    T_1{i,j}=imfill(T_1{i,j}, 'holes');    %填充
    T_1{i,j}=~T_1{i,j};                    %取反
    Area=bwarea(T_1{i,j})/(imgrow*imgcol);    %求面积
    Euler=bweuler(T_1{i,j});             %求欧拉数
    T_p{j,i}=imagejui(imag);               %不变距
    feature_c_8_9(count,:)=[Area,Euler];
     feature_c_1_7(count,:)=[T_p{j,i}]';
    
     Fcrs_c_{j,i}=coarseness(T{i,j},4);
     Fcon_c_{j,i}=contrast(T{i,j});
     [Fdir_c_{j,i},sita_c_{j,i}]=directionality(T{i,j});
     Flin_c_{j,i}=linelikeness(T{i,j},sita_c_{j,i},4);
%  Freg{k,1}=regularity(I{1,k},32);
     Frgh_c_{j,i}=Fcrs_c_{j,i}+Fcon_c_{j,i};
     feature_c_10_14(count,:)=[ Fcrs_c_{j,i}, Fcon_c_{j,i},Fdir_c_{j,i},Flin_c_{j,i},Frgh_c_{j,i}];
     mapping=getmapping(8,'u2');   
     feature_c_15_73(count,:)=lbp(T{i,j},1,8,mapping,'h'); %LBP histogram in (8,1) neighborhood  using uniform patterns
     end                           
end

% ,feature_c_79_3678,feature_c_3679_7278 ,feature_c_74_75,feature_c_8_9,feature_c_10_14,feature_c_15_73,feature_c_1_7,,feature_c_79_3678
% feature_c_1_7,feature_c_8_9,feature_c_10_14,,feature_c_3679_7278,feature_c_79_3678feature_c_15_73,
feature_c_sum=cat(2,feature_c_8_9,feature_c_74_75,feature_c_76_78,feature_c_15_73,feature_c_3679_7278);

%% 给训练数据和测试数据贴上标签
%%%%%先把训练的标签贴起来
practise_label=zeros(300,1);
for i=1:300
    if rem(i,60)~=0
    practise_label(i)=floor(i/60)+1;
    else
    practise_label(i)=floor(i/60);
    end 
end
%%%%%测试的标签
test_label=zeros(150,1);
for i=1:150
    if rem(i,30)~=0
    test_label(i)=floor(i/30)+1;
    else
    test_label(i)=floor(i/30);
    end 
end

%% 数据归一化
% 数据预处理,将训练集和测试集归一化到[0,1]区间

[mtrain,ntrain] = size(feature_sum);
[mtest,ntest] = size(feature_c_sum);

dataset = [feature_sum;feature_c_sum];
% mapminmax为MATLAB自带的归一化函数
[dataset_scale,ps] = mapminmax(dataset',0,1);
dataset_scale = dataset_scale';

feature_sum = dataset_scale(1:mtrain,:);
feature_c_sum = dataset_scale( (mtrain+1):(mtrain+mtest),: );


%% PCA
set(edit2,'string','训练数据PCA特征提取......')
drawnow
[coef,score,latent,t2]=princomp(feature_sum);
% score=score';
% latent=latent';
% coef=coef';
pcapic=score(:,1:150);
disp('主成分因子');coef;
disp('贡献率');score;
disp('特征值');latent;
figure;
percent_explained = 100*latent/sum(latent);
pareto(percent_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
figure;
biplot(coef(:,1:3), 'scores',score(:,1:3));
% % mA=mean(f_matrix);
% mA=mean(feature_sum);
% k=50;%降维至10维
% [pcapic,V]=fastPCA(feature_sum,k,mA);%主成分分析法特征提取



%%%%%%%%%%%%%%这一部分是测试集的降维过程
%%%%%%%%%%测试数据降维
set(edit2,'string','测试数据PCA特征提取......')
drawnow
[coef_c,score_c,latent_c,t2_c]=princomp(feature_c_sum);
% score_c=score_c';
% latent_c=latent_c';
% coef_c=coef_c';
pcatestpics=score_c(:,1:150);
disp('主成分因子');coef_c;
disp('贡献率');score_c;
disp('特征值');latent_c;
figure;
percent_explained_c = 100*latent_c/sum(latent_c);
pareto(percent_explained_c);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
figure;
biplot(coef_c(:,1:3), 'scores',score_c(:,1:3));

%% 新
%% 选择最佳的SVM参数c&g

% 首先进行粗略选择: c&g 的变化范围是 2^(-10),2^(-9),...,2^(10)
[bestacc,bestc,bestg] = SVMcgForClass( practise_label, pcapic,-5,5,-5,5);

% 打印粗略选择结果
disp('打印粗略选择结果');
str = sprintf( 'Best Cross Validation Accuracy = %g%% Best c = %g Best g = %g',bestacc,bestc,bestg);
disp(str);

% 根据粗略选择的结果图再进行精细选择: c 的变化范围是 2^(-2),2^(-1.5),...,2^(4), g 的变化范围是 2^(-4),2^(-3.5),...,2^(4),
[bestacc,bestc,bestg] = SVMcgForClass(practise_label,pcapic,-2,4,-2,4,3,0.5,0.5,0.8);
% 打印精细选择结果
disp('打印精细选择结果');
str = sprintf( 'Best Cross Validation Accuracy = %g%% Best c = %g Best g = %g',bestacc,bestc,bestg);
disp(str);

%% 利用最佳的参数进行SVM网络训练
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
model = libsvmtrain(practise_label, pcapic,cmd);

%% SVM网络预测
[ptrain_label, train_accuracy,train_values] = libsvmpredict( practise_label,  pcapic, model);
[predict_label,accuracy,values] = libsvmpredict(test_label,pcatestpics,model);

% 打印训练集集分类准确率
total_x = length(practise_label);
right_x = sum(ptrain_label == practise_label);
disp('打印测试集分类准确率');
str = sprintf( 'Accuracy = %g%% (%d/%d)',train_accuracy(1),right_x,total_x);
disp(str);

% 打印测试集分类准确率
total = length(test_label);
right = sum(predict_label == test_label);
disp('打印测试集分类准确率');
str = sprintf( 'Accuracy = %g%% (%d/%d)',accuracy(1),right,total);
disp(str);

%% 结果分析

% 测试集的实际分类和预测分类图
% 通过图可以看出只有三个测试样本是被错分的
figure;
hold on;
plot(test_label,'o');
plot(predict_label,'r*');
xlabel('测试集样本','FontSize',12);
ylabel('类别标签','FontSize',12);
legend('实际测试集分类','预测测试集分类');
title('测试集的实际分类和预测分类图','FontSize',12);
grid on;
snapnow;




% %% 选择最佳的SVM参数c&g
% 
% 
% %%%%%%%%%利用ＳＶＭ进行分类
% 
% [bestacc,bestc,bestg]=SVMcgForClass( practise_label, pcapic,-3,3,-3,3);
% cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
% % cmd = ['-c ',num2str(bestc),'-t',0];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %分类预测
% model = libsvmtrain( practise_label,  pcapic,cmd);
% [ptrain_label, train_accuracy,train_values] = libsvmpredict( practise_label,  pcapic, model);
% train_accuracy;
% [ptest_label, test_accuracy,dec_values] = libsvmpredict(test_label, pcatestpics, model);
% test_accuracy;
% % toc;


 




