function [best, best_len]=GAforTSP(A,pop,Pc,Pm,gem)
A=load('att48.txt');                   % A是读取的坐标，N*3列，N表示城市数
subplot(1,2,1);
plot(A(:,2),A(:,3),'s','markersize',2);   % 画出散点图

%种群大小pop=80, 最大世代数gem=100，交叉概率Pc=0.9，变异概率Pm=0.2，C为复制个数
 pop=120;
Pc=0.9;
 Pm=0.2;
 gem=100;
 m=2;
%初始化参数定义部分

[N,col1]=size(A);                         %获取城市数
D=distance(A);


P0=zeros(pop,N+1);
for i=1:pop
    P0(i,2:N)=randperm(N-1)+1;                  %生成初始群体P0
end;
    for i=1:pop
        PP(i,:)=[1 P0(i,2:N) 1];
    end; %构造改良圈算法初始矩阵
    for k=1:pop
        flag=1;
        while flag
            flag=0;
            for i=1:N-2
                for j=i+2:N
                    if D(PP(k,i),PP(k,j))+D(PP(k,i+1),PP(k,j+1))<D(PP(k,i),PP(k,i+1))+D(PP(k,j),PP(k,j+1))
                        PP(k,(i+1):j)=PP(k,j:-1:(i+1));
                        flag=1;
                    end
                end
            end
        end
    end %PPP为优化过的父代
    P1=PP(:,1:N);
        
while gem
    P2=[];                              %P2是子代，先存取父代的值
    P3=[];
    ss=randperm(pop);
    nn=0;
    sss=0;
    for i=1:2:pop-1
        B=P1(ss(i),:);
        C=P1(ss(i+1),:);
        if rand<Pc
            [B,C]=cross(B,C);
            nn=nn+1;
            P2(nn,:)=B;
            P2(nn+1,:)=C;
        end; 
         if rand>1-Pm
            pp=randperm(N);
            [B(pp(1)),B(pp(2))]=exchange(B(pp(1)),B(pp(2)));
            sss=sss+1;
            P3(sss,:)=B;
        end;
        if rand>1-Pm
            ppp=randperm(N);
            [C(ppp(1)),C(ppp(2))]=exchange(C(ppp(1)),C(ppp(2)));
            P3(sss+1,:)=C;
        end;  
    end;
    P=[P1;P2;P3];
    Fit2=fitness(P,D);
    [rrr,bbb]=sort(Fit2);
    best_len=rrr(1);
    best=P(bbb(1) ,:);
    P4=P(bbb(1:pop),:);
     P1=P4;
     clear P2;
     clear P3;
     clear P4;
     gem=gem-1;
end;
subplot(1,2,2) %画出闭合路径曲线图
scatter(A(:,2),A(:,3),'x');
hold on;
plot([A(best(1),2),A(best(N),2)],[A(best(1),3),A(best(N),3)]);
hold on;
for i=1:N-1
    x0=A(best(i),2);
    x1=A(best(i+1),2);
    y0=A(best(i),3);
    y1=A(best(i+1),3);
    xx=[x0, x1];
    yy=[y0, y1];
    plot(xx,yy);
    hold on;
end;
 

function D= distance(A)            %计算距离矩阵
    [N,col1]=size(A);
	D=zeros(N);
    for i=1:N
        for j=i:N
            D(i,j)=sqrt((A(i,2)-A(j,2)).^2+(A(i,3)-A(j,3)).^2);
            D(j,i)=D(i,j);
        end;
    end;
    
function Fit=fitness(P,D)        %计算闭合路径值(矩阵）
    pop=size(P,1);
    Fit=zeros(pop,1);        %数值
    [N,QQ]=size(D);
    for i=1:pop
        for j=1:N-1
          Fit(i,1)=Fit(i,1)+D(P(i,j),P(i,j+1));
        end;
         Fit(i,1)=Fit(i,1)+D(P(i,N),P(i,1));
    end;
            
function [B,C]=cross(B,C)       %部分匹配交叉法
    L=length(B);
    cp1=randperm(L-2);
    if cp1(1)>cp1(2)
        cpmax=cp1(1)+1;
        cpmin=cp1(2)+1;
    else cpmax=cp1(2)+1;
         cpmin=cp1(1)+1;
    end;
    B1=B;
    for i=cpmin:cpmax
        x=find(B==C(i));
        [B(x),B(i)]=exchange(B(x),B(i));
    end
    for i=cpmin:cpmax
        y=find(C==B1(i));
        [C(y),C(i)]=exchange(C(y),C(i));
    end;
    
function [x,y]=exchange(x,y)
        temp=x;
        x=y;
        y=temp;






    