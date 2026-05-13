%% Notes
% make usre the Codegen and Controller folders are on path

% call function
VCU_app();

function VCU_app()
    % attempt to pull in p, x, y from workspace
    try
        p = evalin('base', 'p');
        xVCU = evalin('base', 'xVCU');
        yVCU = evalin('base', 'yVCU');
    catch % if that fails, run init funcs, then save
        p = class2struct(pVCU_master()); 
        xVCU = class2struct(xVCU_master());
        yVCU = class2struct(yVCU_master(p));
        % Assign to workspace
        assignin('base', 'p', p);
        assignin('base', 'x', xVCU);
        assignin('base', 'y', yVCU);
    end
    
    xNames = fieldnames(xVCU);
    yNames = fieldnames(yVCU);
    
    % Find midpoint of y to split it into two columns
    yMid = ceil(length(yNames) / 2);
    
    % Calculate max rows needed (+1 for the button row)
    numRows = max(length(xNames), yMid) + 1;
    
    % --- 2. Create UI Figure and Layout ---
    % Widened the figure appropriately for 6 grid columns
    fig = uifigure('Name', 'VCU Step App', 'Position', [100 100 800 400]);
    grid = uigridlayout(fig, [numRows, 6]); 
    grid.ColumnWidth = {'fit', '1x', 'fit', '1x', 'fit', '1x'};
    
    inFields = struct();
    outFields = struct();
    
    % --- 3. Dynamic Generation of Inputs (xVCU) - Left Column ---
    for i = 1:length(xNames)
        lbl = uilabel(grid, 'Text', [xNames{i} ' (In):']);
        lbl.Layout.Row = i;
        lbl.Layout.Column = 1;
        
        inFields.(xNames{i}) = uieditfield(grid, 'text', 'Value', mat2str(xVCU.(xNames{i})));
        inFields.(xNames{i}).Layout.Row = i;
        inFields.(xNames{i}).Layout.Column = 2;
    end
    
    % --- 4. Dynamic Generation of Outputs (yVCU) - Center & Right Columns ---
    for i = 1:length(yNames)
        lbl = uilabel(grid, 'Text', [yNames{i} ' (Out):']);
        outFields.(yNames{i}) = uieditfield(grid, 'text', 'Value', mat2str(yVCU.(yNames{i})), 'Editable', 'off');
        
        if i <= yMid
            % Center visual column (Grid cols 3 & 4)
            lbl.Layout.Row = i;
            lbl.Layout.Column = 3;
            outFields.(yNames{i}).Layout.Row = i;
            outFields.(yNames{i}).Layout.Column = 4;
        else
            % Right visual column (Grid cols 5 & 6)
            lbl.Layout.Row = i - yMid;
            lbl.Layout.Column = 5;
            outFields.(yNames{i}).Layout.Row = i - yMid;
            outFields.(yNames{i}).Layout.Column = 6;
        end
    end
    
    % --- 5. Run Button ---
    btn = uibutton(grid, 'Text', 'Run vcu_step', 'ButtonPushedFcn', @runStep);
    btn.Layout.Row = numRows;
    btn.Layout.Column = [1 6]; % Span across all 6 columns at the bottom
    
    % --- 6. Button Callback ---
    function runStep(~, ~)
        % Read data from UI into struct x
        for k = 1:length(xNames)
            xVCU.(xNames{k}) = str2num(inFields.(xNames{k}).Value); %#ok<ST2NM>
        end
        
        % Run the external script/function
        yVCU = vcu_step(p, xVCU, yVCU);
        
        % Write data from struct y into UI
        for k = 1:length(yNames)
            outFields.(yNames{k}).Value = mat2str(yVCU.(yNames{k}));
        end

        % update x, y in workspace
        assignin('base', 'x', xVCU)
        assignin('base', 'y', xVCU)
    end
end