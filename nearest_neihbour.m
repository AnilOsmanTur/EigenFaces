function [sel_classes, certainty, scores] = nearest_neihbour(k, n_class, trainX, trainY, testX, testY)
    n_sample = size(testX)(1);

    certainty = zeros(n_sample,1);
    sel_classes = zeros(n_sample,1);
    scores = zeros(n_sample,1);
    for i = 1:n_sample
        dis_knn = euclidean_distance(trainX, testX(i,:));
        [sorted_dis,ids] = sort(dis_knn);

        ids = ids(1:k);
        votes = trainY(ids);
        voting = zeros(n_class, 1);
        for j = 1:k
            voting(votes(j))++;
        end
        [vote_count, chosen_class] = max(voting);
        sel_classes(i) = chosen_class;
        certainty(i) = vote_count / k *100;
        if chosen_class == testY(i)
            scores(i) = 1; 
        end
    end
    
    printf('%d-NN classifier accuracy: %.2f%% : %d / %d\n', k, sum(scores) / n_sample *100, sum(scores), n_sample); 
end