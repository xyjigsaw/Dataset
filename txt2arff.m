clc;
dataNameArray = {'MultipleF','Isolet5','Madelon','LSVT','SemeionHW','wbcd','Australian','Spectf','Ionosphere','Climate','Libras','German','Sonar','Musk','HillValley','Parkinson','wine','LungCancer'};
for i = 7:7
    load(['dataset/' dataNameArray{i} '.mat'])
    dim = size(ins,2);
    disp(['@relation ' dataNameArray{i}]);
    for j = 1:dim
        disp(['@attribute lbl' num2str(j)  ' numeric']);
    end
    label = unique(lab);
    fprintf('@attribute cls {');
    for k = 1:length(label)
        if k ~= length(label)
            fprintf('%d,',label(k));
        else
            fprintf('%d',label(k));
        end
    end
    fprintf('}\n\n');
    disp('@data');
end