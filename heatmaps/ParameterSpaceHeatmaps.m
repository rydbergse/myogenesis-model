function ParameterSpaceHeatmaps(data, par_ranges, logscalex, logscaley, x_label, y_label,...
    color, ticks1, ticks2, plotnames, caxisv, dirname, name)
    % data = structure array generated after running the function
    % StochasticSimulationsRepressilator
    % logscale = specify if you want to plot the axis of the parameter
    % space in logarithmic scale (1 = yes, 0 = no)
    % color = string specifying the colormap to plot the heatmaps
    % ticks1 = row vector specifying the axis ticks to show in the y axis 
    % ticks2 = row vetor specifying the axis ticks to show in the x axis
    % plotnames = cell array where each element is a string to display in
    % each plot
    % caxisv = cell array where each element is a row vector specfying the
    % colormap limits for the current axes
    % dirname = string specifying the directory to save the plots

    range_size = sqrt(size(par_ranges,1));    
    yy = flip(reshape(par_ranges(:,1),range_size,range_size)');
    xx = flip(reshape(par_ranges(:,2),range_size,range_size)');
    
    plots = fieldnames(data)';
    
    %%%%%%%%%%%%%%%%%%%%%
    %%% Surface Plots %%%
    %%%%%%%%%%%%%%%%%%%%%
    
    j = 1; 
    for i = plots
        f = figure('Renderer', 'painters', 'Position', [415 305 620 460]);
        f.Color='white';
        hold on
        pp = flip(reshape(eval(['data.',i{1}]),range_size,range_size)'); 
        surface(xx, yy, pp, 'EdgeColor', 'None');
        colormap(color);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Current Axis Properties %%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if logscalex == 1
            set(gca,'XScale','log')
        end
        if logscaley == 1
            set(gca,'YScale','log')
        end
        xlabel(x_label);
        ylabel(y_label);
        ylim([min(min(yy)),max(max(yy))]); 
        xlim([min(min(xx)),max(max(xx))]);
        yticks(ticks1);
        xticks(ticks2);
        set(gca,'FontSize', 20)

        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% ColorBar Properties %%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        c = colorbar;
        set(gca,'ColorScale','log')
        c.LineWidth = 1.5;
        c.FontSize = 20;
        c.FontName = 'Helvetica';
        c.Label.String = plotnames{j};
        caxis(caxisv{j});
        
%         t=get(c,'Limits');
%         T=linspace(t(1),t(2),5)
%         set(c,'Ticks',T)
%         TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
%         set(c,'TickLabels',TL)

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Current Figure Handle %%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        set(gcf,'color','w')
        %fig_pdf(gcf)

        %%%%%%%%%%%%%%%%%%%%%
        %%% Save the Plot %%%
        %%%%%%%%%%%%%%%%%%%%%
        if ~exist(dirname)
            mkdir(dirname)
        end
        saveas(f,[dirname,'/',name,i{1},'.png'])
        j = j +1;
    end
end