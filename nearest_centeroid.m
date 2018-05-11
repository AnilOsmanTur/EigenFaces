function [sel_classes, distances, scores, n_class] = nearest_centeroid(trainX, trainY, testX, testY)
    [centers, classes] = find_centers(trainX, trainY);
    n_class = size(centers)(1);
    n_sample = size(testX)(1);
    
    distances = zeros(n_sample,1);
    sel_classes = zeros(n_sample,1);
    scores = zeros(n_sample,1);
    for i = 1:n_sample
        min_dis = inf;
        for j = 1:n_class
            dis = euclidean_distance (testX(i,:), centers(j,:));
            if dis < min_dis
                min_dis = dis;
                class = classes(j);
            end
        end
        sel_classes(i) = class;
        distances(i) = min_dis; 
        if class == testY(i)
            scores(i) = 1;
        end
    end
    
    printf('NC classifier accuracy: %.2f%% : %d / %d\n', sum(scores) / n_sample *100, sum(scores), n_sample);
    
end
