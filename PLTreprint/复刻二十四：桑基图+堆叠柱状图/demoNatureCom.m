% -----------------------------------------------------+
% @author  | slandarer                                 |
% 公众号   | slandarer随笔                              |
% 知乎     | slandarer                                 |
% -----------------------------------------------------+
% 复刻自   | www.nature.com/articles/s41467-025-63215-6 |
% -----------------------------------------------------+
% 读取桑基图数据
Data1=readcell('natureCommunications1.xlsx');
Data1(1,:)=[];
% 创建图窗和坐标区域
fig=figure('Units','normalized','Position',[.2,.2,.52,.7]);
ax1=axes('Parent',fig, 'Position',[.2,.1,.6,.8]);
% 配色表
CList=[86,112,156;151,181,138;227,206,139;216,139,131;204,204,204;
    172,41,52;224,189,133;106,188,161;79,145,187;180,98,96;226,210,151;
    128,158,173;75,106,150;192,198,132;224,190,133;171,213,165;205,193,174;
    110,187,161;82,146,186;192,198,130;156,189,141;179,179,181;223,153,124;182,167,131]./255;
% 创建桑基图对象
SK=SSankey(Data1(:,1),Data1(:,2),Data1(:,3));
SK.ColorList=CList;        % 设置配色
SK.RenderingMethod='left'; % 修改链接颜色渲染方式
SK.Align='up';             % 修改对齐方式
SK.Sep=.2;                 % 设置缝隙占比
SK.draw()                  % 开始绘图
% 修改连接透明度及标签字体
for i=1:length(SK.LinkHdl)
    SK.setLink(i,'FaceAlpha',.7)
end
for i=1:length(SK.LabelHdl)
    SK.setLabel(i,'FontName','Arial')
end
%把第三列标签移动到右侧
SK.setLabelLocation(3,'right')

%% 绘制堆叠柱状图 ==========================================================
% 读取堆叠柱状图数据
Data2=readtable("natureCommunications2.xlsx");
Type=Data2.Properties.VariableNames(2:end);
Names=Data2.Pairings;
Values=table2array(Data2(:,2:end));
% 创建坐标区域
ax2=axes('Parent',fig, 'Position',[.2,.1,.4,.38],'Color','none',...
    'NextPlot','add','LineWidth',1.5,'FontSize',15,'XLim',[0,5],...
    'YLim',[0,90],'YTick',0:30:90,'XTick',1:4,'XTickLabel',Type,...
    'FontName','Arial');
ax2.YLabel.String='Pairings';
% 绘制堆叠柱状图
barHdl=bar(ax2,Values.','stacked','barwidth',.6,'EdgeColor','none','FaceAlpha',.9);
% 修改配色
for i=1:length(barHdl)
    barHdl(i).FaceColor=CList(strcmp(Names{i},SK.NodeList),:);
end

