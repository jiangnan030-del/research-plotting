rng(1);
figure('Position',[600,200,600,600]);

X = randi([2, 8], [4, 7]) + rand([4, 7]);
% Create radar chart object.
RC = radarChart(X);

% Set property names and class names.
RC.PropName = {'Modeling', 'Experiments', 'Programming', 'Summarizing', 'Writing', 'Innovation', 'Slacking'};
RC.ClassName = {'Peer A', 'Peer B', 'Peer C', 'Peer D'};

% Draw radar chart and display legend.
RC = RC.draw();
RC = RC.legend();

% 'Line' / 'Patch' / 'Both'
RC.setType('Patch');
