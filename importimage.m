clear all;
close all;

% ��ȡ����ͼ��
I = imread('000073604.jpg');
I = imresize(I,[540,960]);

% ת��Ϊ�Ҷ�ͼ
YUV = rgb2ycbcr(I);
Y = YUV(:,:,1); U = YUV(:,:,2); V = YUV(:,:,3);


% ��ȡˮӡͼ��
W = imread('logo.tif');

% ת��Ϊ��ֵͼ
% level = graythresh(W);
% W = im2bw(W,level);

% �ü�Ϊ�������
W = imresize(W,[80,80]);

figure('Name','����ͼ��');
imshow(I);
title('����ͼ��');

figure('Name','ˮӡͼ��');
imshow(W);
title('ˮӡͼ��');
