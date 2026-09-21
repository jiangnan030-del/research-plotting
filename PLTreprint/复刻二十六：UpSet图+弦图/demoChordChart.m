%% Chord chart part

% Read data (数据导入)
adjData = readtable('adjMat.csv');
adjMat = adjData{:, 2:end};
rowName = adjData.Var1;
colName = adjData.Properties.VariableNames(2:end);

% Create chord chart object and draw
CC = chordChart(adjMat, 'RowName',rowName, 'ColName',colName);
CC.SRadius = [1.025, 1.15];
CC.LRadius = 1.09;
CC.draw()

% Set fonts, colors, and face alpha (设置字体、颜色、透明度)
CC.setFont('Color','w')
CC.setSquareColorF([177,156,132; 144,209,196; 131,146,179]./255)
CC.setSquareColorT([232,72,51;76,187,214;0,160,136;59,83,137]./255)
CC.setChordColorBySquareF()
CC.setChordProp('FaceAlpha', .4)



