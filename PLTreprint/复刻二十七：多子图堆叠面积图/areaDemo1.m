% Inspired by : Fig. 2a: 
%     Barton, A., Afrad, M.H., Taylor-Brown, A. et al. 
%     Evolution of pandemic cholera at its global source. 
%     Nature 653, 491–498 (2026). https://doi.org/10.1038/s41586-026-10340-x
%
% Fig. 2 : Dynamics of V. cholerae sublineages in the Ganges Basin and international transmission.

% 数据读取
T1 = readtable('Group_AAAA.csv');
T2 = readtable('Group_BBBB.csv');
T3 = readtable('Group_CCCC.csv');
Data1 = T1{:, 4:end};
Data2 = T2{:, 4:end};
Data3 = T3{:, 4:end};

% 获取变量名
varNames = T1.Properties.VariableNames(4:end);
varNames = strrep(varNames, '_', '.');
gNames = {'Group-AAAA', 'Group-BBBB', 'Group-CCCC'};

% 获取日期
Year = T1.Year; Month = T1.Month; Day = T1.Day;
DT = datetime(Year, Month, Day);

% 获取配色
cmap = [flipud(slanCM(17, 18)); flipud(slanCM(19, 18))];

% 图窗及坐标区域创建
fig = figure('Units','normalized', 'Position',[.02,.05,.9,.88], 'Color','w');
ax1 = axes('Parent',fig, 'Position',[.1, 2/3 + .065, .7, 1/3 - .1], 'NextPlot','add', ...
    'TickLength',[.005,.001], 'LineWidth',1.5, 'TickDir','out', 'FontSize',13, 'FontName','Arial');
ax2 = axes('Parent',fig, 'Position',[.1, 1/3 + .065, .7, 1/3 - .1], 'NextPlot','add', ...
    'TickLength',[.005,.001], 'LineWidth',1.5, 'TickDir','out', 'FontSize',13, 'FontName','Arial');
ax3 = axes('Parent',fig, 'Position',[.1, 0   + .065, .7, 1/3 - .1], 'NextPlot','add', ...
    'TickLength',[.005,.001], 'LineWidth',1.5, 'TickDir','out', 'FontSize',13, 'FontName','Arial');
% 绘图
aHdl1 = area(ax1, DT, Data1, 'LineWidth',1.5); set(aHdl1, {'FaceColor'}, num2cell(cmap, 2));
aHdl2 = area(ax2, DT, Data2, 'LineWidth',1.5); set(aHdl2, {'FaceColor'}, num2cell(cmap, 2));
aHdl3 = area(ax3, DT, Data3, 'LineWidth',1.5); set(aHdl3, {'FaceColor'}, num2cell(cmap, 2));

% 添加标签及图例
set(ax1.YLabel, 'String',gNames{1}, 'FontSize',16)
set(ax2.YLabel, 'String',gNames{2}, 'FontSize',16)
set(ax3.YLabel, 'String',gNames{3}, 'FontSize',16)
set(ax3.XLabel, 'String','Year', 'FontSize',16)
ax1.XTickLabel = regexprep(ax1.XTickLabel, '\D', '');
ax2.XTickLabel = regexprep(ax2.XTickLabel, '\D', '');
ax3.XTickLabel = regexprep(ax3.XTickLabel, '\D', '');
annotation('textbox', [.03, .4995, .001, .001], 'String','Value', 'FontSize',21, 'FontName','Arial', ...
    'HorizontalAlignment','center', 'VerticalAlignment','middle', 'Rotation',90, 'EdgeColor','none');
lgdHdl = legend(ax1, varNames, 'AutoUpdate','off', 'Position', [.825, .05, .15, .9], 'NumColumns',2, 'Box','off');
lgdHdl.ItemTokenSize = [22, 22];
set(lgdHdl.Title, 'String','Sublineage', 'FontSize',21, 'FontName','Arial')

