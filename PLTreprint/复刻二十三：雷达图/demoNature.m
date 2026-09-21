rng(1)
figure('Position',[600,200,600,600]);

Data = rand([2, 10]);
RC = radarChart(Data);

RC.RLim = [0,1];         % Set the data range to be between 0 and 1
RC.RTick = [0,.5,1];     % Set radius ticks at 0, 0.5, and 1
RC.RRange = [.1,1];      % Set the range for the background (0.1 to 1)
RC.Rotation = pi/2;      % Set the initial angle
RC.ThetaDir = 'reverse'; % Set the direction of the label arrangement

% Assign class and property labels
RC.ClassName = {'Stalk-like','Tip-like'};
RC.PropName = num2cell('A':'J'); 
% RC.PropName = {'A','B','C','D','E','F','G','H','I','J'}
RC.CList = [151,125,154; 179,97,97]./255;


RC = RC.draw();

% Customize visual appearance properties
RC.setPropLabel('FontSize', 21, 'FontName', 'Times New Roman');   % Property label formatting.
RC.setRTick('LineWidth', 2);                                      % Radial tick mark thickness.
RC.setRLabel('Color', 'none');                                    % Hide radial axis labels.
RC.setBkg('EdgeColor', 'none');                                   % Remove background grid borders.
RC.setThetaTick('LineWidth', 2);                                  % Angular tick line thickness.
RC.setType('Both');                                               % Render both line and patch styles.

% Configure line and marker properties for each data series
RC.setPatchN(1, 'LineWidth', 5, 'MarkerSize', 8);  % Format class 1 (Stalk-like)
RC.setPatchN(2, 'LineWidth', 5, 'MarkerSize', 8);  % Format class 2 (Tip-like)



% Generate and format legend
RC = RC.legend();
RC.setLegend('FontSize', 21, 'FontName', 'Times New Roman');