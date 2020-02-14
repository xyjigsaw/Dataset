clc
clear
load('dataName.mat')
data = [ins, lab];
fid = fopen('dataName.txt', 'wt');
for i = 1 : size(data, 1)
    for j = 1 : size(data, 2) - 1
        fprintf(fid,'%e   ',data(i, j));
    end
    fprintf(fid,'%e\n',data(i, size(data, 2)));
end
fclose(fid);
