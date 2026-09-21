% 读取桑基图数据
Data=readcell('natureCommunications1.xlsx');
Data(1,:)=[];
% 创建图窗和坐标区域
fig=figure('Units','normalized','Position',[.2,.2,.52,.7]);
ax1=axes('Parent',fig, 'Position',[.2,.1,.6,.8]);
% 创建桑基图对象
SK=SSankey(Data(:,1),Data(:,2),Data(:,3));
SK.LabelLocation='left';    % 修改标签位置
SK.RenderingMethod='left'; % 修改链接颜色渲染方式
SK.Align='up';             % 修改对齐方式
SK.Sep=.2;                 % 设置缝隙占比
SK.draw()                  % 开始绘图
%把第三列标签移动到右侧
SK.setLabelLocation(3,'right')