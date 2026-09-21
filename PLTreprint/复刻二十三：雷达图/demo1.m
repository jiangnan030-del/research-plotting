rng(5);
figure('Position', [600,200,600,600]);

X = randi([-3, 8], [4, 7]) + rand([4, 7]);

% Create radar chart object.
RC = radarChart(X);

% Set R-axis limit and ticks.
RC.RLim = [-5,10];
RC.RTick = [-5,2,8,10];

% Draw radar chart.
RC = RC.draw();

% Display legend.
RC.legend();