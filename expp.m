function [result,rst] = expp(k,z)
A = imread("���а�","tiff");
%imshow(A);
[m,n] = size(A);
X = reshape(A,1,m*n);
X = double(X);

%������������
a1 = 1:m;
a1 = a1';
a1 = (a1./m).*z;
A1 = A;
for i1 = 1:n
    A1(:,i1)=a1;
end
A1 = zeros(m,n);
for i1 = 1:n
    A1(:,i1)=a1;
end
a2 = 1:n;
a2 = (a2./n).*z;
A2 = zeros(m,n);
for i2 = 1:m
A2(i2,:) = a2;
end
%��A1��A2��������Χ������ֵ��Ϊ�㣬�����ھ�����һ���ᱻ��Ϊͬһ��

X1 = reshape(A1,1,m*n);
X2 = reshape(A2,1,m*n);
for j = 1:m*n
    if(X(j)==0)
        X1(j) = 0;
        X2(j) = 0;
    end
end

 Feat = [X;X1;X2];
X = Feat;
k = k+1;


L = [];% ��ǩ����
L1 = 0;
while length(unique(L)) ~= k
    % ��ʼ����������
    C = X(:,1+round(rand*(size(X,2)-1)));
    L = ones(1,size(X,2));
    for i = 2:k
        D = X-C(:,L);
        D = cumsum(sqrt(dot(D,D,1)));
        if D(end) == 0, C(:,i:k) = X(:,ones(1,k-i+1)); return; end
        C(:,i) = X(:,find(rand < D/D(end),1));
        [~,L] = max(bsxfun(@minus,2*real(C'*X),dot(C,C,1).'));
    end 
    % ���·ִ�
    while any(L ~= L1)
        L1 = L;
        for i = 1:k, l = L==i; C(:,i) = sum(X(:,l),2)/sum(l); end
        [~,L] = max(bsxfun(@minus,2*real(C'*X),dot(C,C,1).'),[],1);
    end
    
end
%-------K-means++����-------%
label = L;
label = reshape(label,m,n);
for i = 1:m*n
L(i) = C(L(i));
end
rst = reshape(L,m,n);%������ͼ
%imshow(rst/256);
result = labeloverlay(A,label);  %��ǩ��ʾ������