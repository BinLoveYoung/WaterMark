function [Wg,nc] = getdwtwatermark(Iw,W,ntimes,rngseed,flag)
%% GETDWTWATERMARK С��ˮӡ��ȡ����������Ҫʹ��ԭʼ�����ˮӡͼ��
%   Iw����ˮӡ��ͼ��
%   W: ԭʼˮӡ��ֻ��Ϊ�˼��������
%   ntimes����Կ1��Arnold�任����
%   rngseed����Կ2���������������
%   flag���Ƿ���ʾ�м�ͼ��
%   Wg����ȡ����ˮӡ
%   nc�����ϵ��
    
    [mW,nW] = size(W);
    
    % ����Arnold����ֻ�ܶԷ�����д���
    if mW ~= nW
        error('ARNOLD����Ҫ��ˮӡͼ��ĳ��������ȣ�');
    end
    
    Iw = double(Iw);
    W = logical(W);
    
    %% 1 �������С��ϵ��
    % һ��haarС���ֽ�
    % ��Ƶ��ˮƽ����ֱ���Խ���
    ca1w = dwt2(Iw,'haar');
    % ����haarС���ֽ�
    ca2w = dwt2(ca1w,'haar');
    
    %% 2 ��ϵ����ȡˮӡ��Ϣ
    % ��ʼ��ˮӡ����
    Wa = W;
    % rngseed����Կ2�������������������
    rng(rngseed);
    idx = randperm(numel(ca2w),numel(Wa));
    % ���ϵ����ȡ��Ϣ
    for i = 1:numel(Wa)
        c = ca2w(idx(i));
        z = mod(c,nW);
        if z<nW/2
            Wa(i)=0;
        else
            Wa(i)=1;
        end
    end
    
    %% 3 ����Ϣ���з�Arnold�任
    Wg = Wa;
    % ntimes ����Կ1��Arnold�任����
    H = [2 -1; -1 1]^ntimes;
    for i = 1:nW
        for j = 1:nW
            idx = mod(H*[i-1;j-1],nW)+1;
            Wg(idx(1),idx(2)) = Wa(i,j);
        end
    end
    
    %% 4 ��ȡ��ԭʼˮӡ���ϵ������
    nc = sum(Wg(:).*W(:))/sqrt(sum(Wg(:).^2))/sqrt(sum(W(:).^2));
    
    % ��ͼ��ʾ���
    if flag
        figure('Name','����ˮӡ��ȡ���')
        subplot(1,2,1)
        imshow(W);
        title('ԭʼˮӡ');
        subplot(1,2,2)
        imshow(Wg);
        title(['��ȡˮӡ��NC = ',num2str(nc)]);
    end
end

