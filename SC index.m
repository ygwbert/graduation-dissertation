function [si_total,si] = sc(rst,L)
%��������ϵ����Silhouette Coefficient��
%rst����������δreshape֮ǰ�Ľ����3ά��������
%L�������ǩ����
%si���������ݵ������ϵ��������
%si_total������������������ϵ��
%[m,n] = size(rst);
m = 3023;
n = 6247;
sumintra = 0;
intranum = 0;
internum = 0;
suminter = 0;
ai = zeros(1,m*n);
bi = zeros(1,m*n);
si = zeros(1,m*n);
for i = 1:m*n
	for j = 1:m*n
		if(L(i)==L(j) && rst(1,i)~=0 && rst(1,j)~=0)
			intranum = intranum +1;
			intradist = sqrt((rst(1,i)-rst(1,j))^2+(rst(2,i)-rst(2,j))^2+(rst(3,i)-rst(3,j))^2);%ŷ�Ͼ���
			sumintra = sumintra + intradist;
        elseif(L(i)~=L(j) && rst(1,i)~=0 && rst(1,j)~=0)
				internum = internum+1; 
				interdist = sqrt((rst(1,i)-rst(1,j))^2+(rst(2,i)-rst(2,j))^2+(rst(3,i)-rst(3,j))^2);
				suminter = suminter + interdist;
        end
    end
    ai(i) = sumintra/(intranum-1);
    bi(i) = suminter/internum;
    si(i) = (bi(i)-ai(i))/max(bi(i),ai(i));
end
sum = 0;
for i = 1:m*n
	sum = sum + si(i);
end

si_total = sum/(m*n);