%
% This function is used to convert the input data to '.arff'
% file format,which is compatible to weka file format ...
%
% Parameters:
% input_filename -- Input file name,only can conversion '.mat','.txt'
% or '.csv' file format ...
% arff_filename -- the output '.arff' file ...

% NOTEs:
%The input 'M*N' file data must be the following format:
% M: sampel numbers;
% N: sample features and label,"1:N-1" -- features, "N" - sample label ...


% 读取文件数据 ...
clear
clc
input_filename = 'GLIOMA-t.mat';
arff_filename = 'GLIOMA.arff';
if strfind(input_filename,'.mat')
matdata = importdata(input_filename);
elseif strfind(input_filename,'.txt')
matdata = textread(input_filename) ;
elseif strfind(input_filename,'.csv')
matdata = csvread(input_filename);
end

[row,col] = size(matdata);
f = fopen(arff_filename,'wt');
if (f < 0)
error(sprintf('Unable to open the file %s',arff_filename));
return
end
fprintf(f,'%s\n',['@relation ',arff_filename]);
for i = 1 : col - 1
st = ['@attribute att_',num2str(i),' numeric'];
fprintf(f,'%s\n',st);
end
% 保存文件头最后一行类别信息
floatformat = '%.16g';
Y = matdata(:,col);
uY = unique(Y); % 得到label类型
st = ['@attribute label {'];
for j = 1 : size(uY) - 1
st = [st sprintf([floatformat ' ,'],uY(j))];
end
st = [st sprintf([floatformat '}'],uY(length(uY)))];
fprintf(f,'%s\n\n',st);
% 开始保存数据 ...
labelformat = [floatformat ' '];
fprintf(f,'@data\n');
for i = 1 : row
Xi = matdata(i,1:col-1);
s = sprintf(labelformat,Y(i));
s = [sprintf([floatformat ' '],[; Xi]) s];
fprintf(f,'%s\n',s);
end
fclose(f);