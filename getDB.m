function DB = getDB(x, cid)
    clusts = unique(cid);
    num = length(clusts);
    centroids = NaN(num,size(x,2));
    aveWithinD= zeros(num,1);
%��Wi
    for count =1:num
        members = (cid == clusts(count));
        if any(members)               %�ж�Ԫ���Ƿ�Ϊ����Ԫ��any(v),���v�Ƿ���Ԫ�ط���true(��1)���򷵻�flase(��0)
            centroids(count,:) = mean(x(members,:),1);   %�ҵ������������
            %average Euclidean distance of each observation to the centroids
            aveWithinD(count)= mean(pdist2(x(members,:),centroids(count,:)));
        end
    end
    interD = pdist(centroids,'euclidean'); %Cij         
    R = zeros(num);
    for count = 1:num
        for j=count+1:num %j>i
            R(count,j)= (aveWithinD(count)+aveWithinD(j))/ interD((count-1)*(num-count/2)+j-count);%d((I-1)*(M-I/2)+J-I)
        end
    end
    R=R+R';


    RI = max(R,[],1);
    DB = mean(RI);
end 
Esh = evalclusters(X,'kmeans','silhouette','klist',[3:6]) ;