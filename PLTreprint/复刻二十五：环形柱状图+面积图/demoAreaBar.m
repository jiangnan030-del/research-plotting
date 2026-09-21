% 复刻自 | https://www.nature.com/articles/s42003-025-08265-8 
% + Li, G., Su, X., Yang, Y. et al. 
%   Interpretability-guided RNA N6-methyladenosine modification site prediction 
%   with invertible neural networks. Commun Biol 8, 1022 (2025). 
%   https://doi.org/10.1038/s42003-025-08265-8

clc; clear
% 原图环形柱状图柱子长度显著性水平，顶部的数字表示富集基因的数量
% 这里我们直接随便编一下

Name = {'GeneXXXXXX-A', 'GeneXYYYYYYYY-B', 'GeneXXXXXXYYY-C', 'GeneXXXXXXYY-D', ...
        'GeneXXXXXX-E', 'GeneXXXXXXXXX-F', 'GeneXXXXXX-G', 'GeneXXXXXX-H', ...
        'GeneABCABCXXXXXX-I', 'GeneXXXXXX-J'};
Value = [31, 17, 17, 21, 20, 18, 11, 15, 7, 9];
Len = Value; % 我们这里直接长度和数字统一，可自行换成其他数值
Class = [1, 2, 2, 1, 1, 2, 2, 2, 2, 2];
ClassName = {'SLAN-related', 'Other'};

% 随机生成了一些 0-80 的数字，并随机将其分类(类1、类2)
rng(1)
Num = [randi([0, 80], [1, 50]), randi([10, 20], [1, 40]), randi([75, 80], [1, 10])];
NumClass = randi([1, 2], [1, 100]);



% 配色，这里只有两种颜色，如果类更多的话要增添更多颜色
CList = [235,173,189; 
        123,166,211]./255; 


%% 开始绘图 ================================================================
figure('Units','normalized', 'Position',[.1,.2,.7,.7]);
%% 环形柱状图
ax1 = axes('Parent',gcf, 'Position',[.05,.1,.9,.8], 'DataAspectRatio',[1,1,1], ...
    'XLim', [-2, 1], 'YLim', [-1,1], 'NextPlot','add', 'XColor','none', 'YColor','none');
N = length(Value); M = max(Len);
% 绘制环形柱状图网格
tt = linspace(pi/2, -pi/2, 100); xx = cos(tt); yy = sin(tt);
XX = repmat([xx.'; nan], [1, N]).*repmat(((1:N) + .5)./(N + .5), [101, 1]);
YY = repmat([yy.'; nan], [1, N]).*repmat(((1:N) + .5)./(N + .5), [101, 1]);
plot(XX(:), YY(:), 'LineWidth',1, 'Color',[1,1,1].*.9)
th = [pi/2, -pi/2, pi/6, -pi/6];
XX = [th.*0; cos(th); th.*nan];
YY = [th.*0; sin(th); th.*nan];
plot(XX(:), YY(:), 'LineWidth',1, 'Color',[1,1,1].*.9)
% 绘制柱状图
for i = 1:N
    R = (N - i + 1)./(N + .5); r = .3./(N + .5);
    TT = (tt - pi/2).*.8.*Len(i)./M + pi/2;
    XX = [cos(TT).*(R + r), cos(TT(end:-1:1)).*(R - r)];
    YY = [sin(TT).*(R + r), sin(TT(end:-1:1)).*(R - r)];
    fill(XX, YY, CList(Class(i),:), 'LineWidth',1.5)
    text(cos(TT(end)).*R + sin(TT(end))./(N)./2, sin(TT(end)).*R - cos(TT(end))./(N)./2, ...
        num2str(Value(i)), 'HorizontalAlignment','center', 'FontName','Arial', 'FontSize',13)
    text(-.05, R, Name{i}, 'HorizontalAlignment','right', 'FontName','Arial', 'FontSize',13)
end

for i = 1:max(Class)
    lgdHdl1(i) = fill([115,108,97,110,100], [97,114,101,114,32], CList(Class(i),:), 'LineWidth',1.5);
end
lgd1 = legend(lgdHdl1, ClassName, 'Box','off', 'FontName','Arial', ...
    'FontSize',16, 'FontWeight','bold', 'Location','northwest');

%% 核密度图
ax2 = axes('Parent',gcf, 'Position',[.18,.1,.42,.4], 'NextPlot','add', ...
    'XLim', [-20,100], 'LineWidth',1.5, 'Box','on', 'TickLength',[.001,0], ...
    'TickDir','out', 'FontSize',13);
xlabel(ax2, 'XXXX-XXXX-xxxxxxxx', 'FontName','Arial', 'FontSize',16)
ylabel(ax2, 'Density', 'FontName','Arial', 'FontSize',16)
xline(40, 'LineWidth',1, 'Alpha',1, 'LineStyle','--');

for i = 1:max(NumClass)
    x = Num(NumClass == i);
    [f, xi] = ksdensity(x);
    lgdHdl2(i) = area(xi, f, 'FaceColor',CList(i,:), 'EdgeColor',CList(i,:), 'FaceAlpha',.5);
    lgdtxt{i} = ['Mean counts: ' ,num2str(round(mean(x)))];
end
lgd2 = legend(lgdHdl2, ClassName, 'Box','off', 'FontName','Arial', ...
    'FontSize',16, 'Location','northeast');
