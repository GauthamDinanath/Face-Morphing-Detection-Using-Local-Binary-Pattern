close all
clear variables

% Im='\FRGC\Morphed\Train';   
% Ir='\FRGC\Real\Train';

Im='C:\Users\gauth\Downloads\AdCV\PutDB\Morphed\Train';
Ir='C:\Users\gauth\Downloads\AdCV\PutDB\Real\Train'; 

% Im='\FRGC+PutDB\Morphed\Train';   
% Ir='\FRGC+PutDB\Real\Train';
% 
% Im='\FRGC\Noised\Morphed\Train';   
% Ir='\FRGC\Noised\Real\Train';


imo=imageSet(Im);
ire=imageSet(Ir);

for i=1:imo.Count
    
imorp=read(imo,i);
#featuresm(i,:)=extractHOGFeatures(imorp);
a=extractLBPFeatures(imorp,'NumNeighbors',8,'Radius',1,'CellSize',[80,80]);
b=extractLBPFeatures(imorp,'NumNeighbors',8,'Radius',2);
c=extractLBPFeatures(imorp,'NumNeighbors',16,'Radius',2);
featuresm(i,:)=[a,b,c];
end
featuresm(:,end+1)=1;

for i=1:ire.Count
    
ireal=read(ire,i);
#featuresr(i,:)=extractHOGFeatures(imorp);
a=extractLBPFeatures(ireal,'NumNeighbors',8,'Radius',1,'CellSize',[80,80]);
b=extractLBPFeatures(ireal,'NumNeighbors',8,'Radius',2);
c=extractLBPFeatures(ireal,'NumNeighbors',16,'Radius',2);
featuresr(i,:)=[a,b,c];
end
featuresr(:,end+1)=0;

features=[featuresm;featuresr];
features = features(randperm(size(features, 1)), :);
% features=features(:,1:end-1);

%% Training SVM
[trainedClassifier, validationAccuracy] = svm(features);

%% Testing

featuresm=[];
featuresr=[];

Im='\FRGC\Morphed\Test';   
Ir='C\FRGC\Real\Test';

% Im='\FRGC+PutDB\Morphed\Test';
% Ir='\FRGC+PutDB\Real\Test';

% Im='\PutDB\Morphed\Test';
% Ir='\PutDB\Real\Test';

% Im='\FRGC\Noised\Morphed\Test';   
% Ir='\FRGC\Noised\Real\Test';

imo=imageSet(Im);
ire=imageSet(Ir);

for i=1:imo.Count
    
imorp=read(imo,i);
a=extractLBPFeatures(imorp,'NumNeighbors',8,'Radius',1,'CellSize',[80,80]);
b=extractLBPFeatures(imorp,'NumNeighbors',8,'Radius',2);
c=extractLBPFeatures(imorp,'NumNeighbors',16,'Radius',2);
% featuresm(i,:)=extractLBPFeatures(imorp);
featuresm(i,:)=[a,b,c];
end
featuresm(:,end+1)=1;

for i=1:ire.Count
    
ireal=read(ire,i);
a=extractLBPFeatures(ireal,'NumNeighbors',8,'Radius',1,'CellSize',[80,80]);
b=extractLBPFeatures(ireal,'NumNeighbors',8,'Radius',2);
c=extractLBPFeatures(ireal,'NumNeighbors',16,'Radius',2);
featuresr(i,:)=[a,b,c];
end
featuresr(:,end+1)=0;

F_Test =[featuresm;featuresr];
F_Test = F_Test(randperm(size(F_Test, 1)), :);
L_Test=F_Test(:,end);
F_Test=F_Test(:,1:end-1);

  y=trainedClassifier.predictFcn(F_Test);

%% Metrics

cm = (confusionmat(L_Test,double(y),'Order',[1,0]));
confusionchart (cm);
apcer= cm(1,2)/(cm(1,2) + cm(1,1));
bpcer= cm(2,1)/(cm(2,1) + cm(2,2));
acc= mean(y==L_Test);

% T1 = table(acc*100,apcer*100,bpcer*100,'RowNames',{'M&R'});
% T1.Properties.VariableNames={'Accuracy','APCER','BPCER'};
% save T1 T1

load T1
new=table(acc*100,apcer*100,bpcer*100,'RowNames',{'PutDB|FRGC'});
new.Properties.VariableNames={'Accuracy','APCER','BPCER'};
T1=[T1;new];
save T1 T1
