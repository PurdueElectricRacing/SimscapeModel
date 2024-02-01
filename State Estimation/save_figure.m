function save_figure(h,name,format,varargin)
% Saves 2D figures with a single plot (not meant for multiple subplots)
% with minimal boundary white spaces in multiple file formats. This version
% supports png pdf eps fig.
%
% save_figure(h,filename,format)
%       Saves the figure with handle h to filename with file-format
%       specified in format. format can be 'png', 'pdf', 'eps', 'fig', or
%       'all'. 'all' saves the file in all the other formats. Specifying
%       the extension in the filename is not recommended.
%       E.g.:
%       h = figure();
%       plot(sin(1:0.01:2*pi));
%       save_figure(h,'sine_plot','pdf');
%
% save_figure(h,filename,format,folder_location)
%       Allows the user to specify the folder location as folder_location
%       where the figure needs to be saved. Both relative and absolute path
%       can be specified. The folder location can also be directly
%       specified in the filename.
%       E.g.:
%       h = figure();
%       plot(sin(1:0.01:2*pi));
%       save_figure(h,'sine_plot','pdf','D:\');

% Coded 11/06/16 by Kumar Akash
% akashkr14@gmail.com
%
% Modifications:
% 05/16/17 Improved the code to crop the whitespaces.
% 02/03/19 Increased output resolution to 300dpi

    if nargin<4
        save_path = pwd;
    else
        save_path = char(varargin(1));
    end
    if ~strcmpi(name(end-2:end),format) && ~strcmp(format,'all')
        name = [char(name) '.' format];
    end
    if ~strcmp(format,'all')
        ax = get(h,'CurrentAxes');

        Position = get(ax,'Position');

        outerpos = get(ax,'OuterPosition');
        ti = get(ax,'TightInset'); 
        left = outerpos(1) + ti(1);
        bottom = outerpos(2) + ti(2);
        ax_width = outerpos(3)*0.999 - ti(1) - ti(3);
        ax_height = outerpos(4)*0.999 - ti(2) - ti(4);
        set(ax,'Position',[left bottom ax_width ax_height]);
    end
    
    if strcmp(format,'fig')
        savefig(h,fullfile(save_path,name));       
        set(ax,'Position',Position);
    elseif strcmp(format,'png')  
        print(h,fullfile(save_path,name),'-dpng','-r300');       
        set(ax,'Position',Position);
    elseif  strcmp(format,'pdf')
        PaperPositionMode = get(h,'PaperPositionMode');
        PaperSize = get(h,'PaperSize');
        
        set(h,'PaperPositionMode', 'auto');
        pos = get(h,'PaperPosition');
        set(h,'PaperSize',[pos(3), pos(4)])  
        print(h,fullfile(save_path,name),'-dpdf','-r300');
        
        set(h,'PaperPositionMode',PaperPositionMode);
        set(h,'PaperSize',PaperSize);        
        set(ax,'Position',Position);
    elseif  strcmp(format,'eps')
        PaperPositionMode = get(h,'PaperPositionMode');
        PaperSize = get(h,'PaperSize');
        
        set(h,'PaperPositionMode', 'auto');
        pos = get(h,'PaperPosition');
        set(h,'PaperSize',[pos(3), pos(4)])  
        print(h,fullfile(save_path,name),'-depsc','-r300');
        
        set(h,'PaperPositionMode',PaperPositionMode);
        set(h,'PaperSize',PaperSize);
        set(ax,'Position',Position);
    elseif strcmp(format,'all')
        save_figure(h,name,'pdf');
        save_figure(h,name,'png');
        save_figure(h,name,'eps');
        save_figure(h,name,'fig');
    else
        disp('Unsupported format to save. Skipping..')
    end   
    
end
            
     