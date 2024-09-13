function [data,idx] = heatmapPlot(data,bin,basal,sort_cols,sort_by,sort_idx,smooth_res,fig,clims)
% HEATMAPPLOT - Plot heatmap with rows sorted by certain columns.
% Comes from plotHeatmap
%
% Inputs:
%   data - the data of matrix. The range of data:[0 1].
%   sorted_by - Columns that used for row sorting. 
%   sort_idx -  Sort index can be given by this input.
%
% Outputs:
%   data - Sorted data.
%   idx - Sort index that are used.
%
% Example:
%   [~,s] = plotHeatmap(data1,41:61,[]);
%   plotHeatmap(data2,~,s);
%
% Other m-files required: none.
% Subfunctions: none.
% MAT-files required: none.
%
% See also: HIST_PLOT(), SCATTER_PLOT().

% Jingfeng Zhou, NIBS, jngfngzh@gmail.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Log:
% 06/03/2013: Complete
% 06/28/2013: Change the name from plotHeatmap to heatmapPlot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%make sure that 0 and 1 are included in the data set
s = size(data);
cell_number = s(1);
data_length = s(2) + 2;
data(:,data_length-1) = ones(cell_number,1);
data(:,data_length) = zeros(cell_number,1);

%sort data by rows and plot heatmap
if isempty(sort_idx)
    for i = 1:cell_number
        if sort_by ==1
            data(i,data_length+1) = sum(data(i,sort_cols));   %46:86
        elseif sort_by == 2
            data(i,data_length+1) = max(data(i,sort_cols));
        elseif sort_by == 3
            [~,k] = max(data(i,sort_cols));
            data(i,data_length+1) = -k;
        elseif sort_by == 4
            data(i,data_length+1) = sum(data(i,sort_cols) > 0.01);
        else
            data(i,data_length+1) = sum(data(i,sort_cols));   %46:86
        end
    end
    [data,idx] = sortrows(data,data_length + 1);
    data = flipud(data);
    idx = flipud(idx);
    data(:,data_length + 1) = [];
else
    data = data(sort_idx,:);
    idx = sort_idx;
end

data(:,data_length) = [];
data(:,data_length-1) = [];

figure(fig);
if smooth_res
    smoothed_data = linearSmooth1(data,smooth_res);
else
    smoothed_data = data;
end
if ~isempty(clims)
    imagesc(smoothed_data,clims);
else
    imagesc(smoothed_data,[min(min(smoothed_data)),max(max(smoothed_data))]);
end

data_length = data_length - 2;
xlim([0 data_length/smooth_res]);

if ~isempty(bin)
    xtick = 1:(1/(bin*smooth_res)):data_length/smooth_res;
    xticklable = -basal:1:(data_length*bin) - basal;
    set(gca,'Xtick',xtick,'XTickLabel',xticklable);
    xlim([0 data_length/smooth_res]);
end

box off;

assignin('base','Heatmap_sorted_data',data);
assignin('base','sort_index',idx);






