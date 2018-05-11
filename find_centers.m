function [centers, classes] = find_centers(trainX, trainY)
    
    nSmp = size(trainY)(1);
    classCount = 0;
    for i = 1:nSmp
        if i == 1
            class = trainX(i,:); 
            count = 1;
            %printf('fist class\n')
            classes = trainY(i);
        else
            if last == trainY(i)
                class = class + trainX(i,:);
                count++;  
                %printf('add class %d %d\n', count, i)
                if i == nSmp
                    classes = [classes; trainY(i)];
                    class = class ./ count;
                    %printf('last class add\n')
                    centers = [centers;class];
                    classCount++;
                end 
            else
                class = class ./ count;
                if classCount == 0
                    %printf('fist class add\n')
                    centers = class;
                    classCount++; 
                else
                    classes = [classes; trainY(i-1)];
                    %printf('%d class add\n', classCount)
                    centers = [centers;class];
                    classCount++;
                end
                class = trainX(i,:);
                count = 1;
            end
        end
        last = trainY(i);    
    end
end