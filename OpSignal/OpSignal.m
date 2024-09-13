function varargout = OpSignal(varargin)
% OPSIGNAL MATLAB code for OpSignal.fig
%      OPSIGNAL, by itself, creates a new OPSIGNAL or raises the existing
%      singleton*.
%
%      H = OPSIGNAL returns the handle to a new OPSIGNAL or the handle to
%      the existing singleton*.
%
%      OPSIGNAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPSIGNAL.M with the given input arguments.
%
%      OPSIGNAL('Property','Value',...) creates a new OPSIGNAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OpSignal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OpSignal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OpSignal

% Last Modified by GUIDE v2.5 26-May-2016 09:50:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OpSignal_OpeningFcn, ...
                   'gui_OutputFcn',  @OpSignal_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before OpSignal is made visible.
function OpSignal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OpSignal (see VARARGIN)

% Choose default command line output for OpSignal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OpSignal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OpSignal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonLoad.
function pushbuttonLoad_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.CSV', 'Open CSV file');
handles.file_path_and_name = fullfile(pathname, filename);

if filename == 0
    return;
end

set(handles.edit_file, 'String', handles.file_path_and_name);

data = csvread(handles.file_path_and_name);
handles.channelnum=size(data,2);
handles.length = size(data,1);
set(handles.pm_cue,'String',num2str((1:1:handles.channelnum-1)'));
set(handles.pm_cue,'Value',1);

for i=1:handles.channelnum-1
    eval(['handles.data',num2str(i),'=','data(:,i)',';']);
end
handles.wave = data(:,handles.channelnum);

cell=[];   
for i=1:handles.length-1
	if handles.data1(i)==0 && handles.data1(i+1)==1
		cell(i+1) =1;
	else	
		cell(i+1) =0;
	end
end
handles.upindex=find(cell==1);
trialnum = size(handles.upindex);
handles.trialnum = trialnum(2);

set(handles.edit_sti1, 'String', num2str(handles.trialnum));

guidata(hObject, handles);


function edit_file_Callback(hObject, eventdata, handles)
% hObject    handle to edit_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_file as text
%        str2double(get(hObject,'String')) returns contents of edit_file as a double


% --- Executes during object creation, after setting all properties.
function edit_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonDrawAll.
function pushbuttonDrawAll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDrawAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.f=figure;
% handles.bin = str2num(get(handles.edit_bin,'String'));
% handles.scrobin=handles.bin/handles.length;
% handles.scrolength=handles.length-handles.bin;
% 
% a=axes('position',[.1 .9 .8 .05],'units','normalized');
% x=1:1:handles.length;
% ylim([0,1]);
% set(gca,'xtick',[],'ytick',[]) 
% %axis([1 handles.length 0 1]);
% stairs(x,handles.data1);
% xlim([0,handles.bin]);
% 
% b=axes('position',[.1 .2 .8 0.6],'units','normalized');
% plot(x,handles.wave);
% xlim([0,handles.bin]);
% 
% uicontrol('units','normalized','Style','slider','pos',[.1 .1 .8 .05],'SliderStep',[handles.scrobin handles.scrobin],...
%     'min',0,'max',handles.scrolength,'callback',{@slider_callback,a,b});
% uicontrol('units','normalized','Style','pushbutton','pos',[.1 .03 .15 .05],'min',0,'max',10,'String', 'Zoomin',...
%     'Callback',{@zoomin_callback,a,b});
% uicontrol('units','normalized','Style','pushbutton','pos',[.3 .03 .15 .05],'min',0,'max',10,'String', 'Zoomout',...
%     'Callback',{@zoomout_callback,a,b});
% guidata(hObject, handles);

interval = 1/str2num(get(handles.TB_SampleRate,'String'));
t=interval*(1:1:handles.length);
figure;
for i=1:handles.channelnum-1
    subplot(handles.channelnum+2,1,i);
    eval(['plot(t,handles.data',num2str(i),');']);
end
subplot(handles.channelnum+2,1,handles.channelnum:handles.channelnum+2);
plot(t,handles.wave);
xlabel('Time (s)');


function edit_bin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bin as text
%        str2double(get(hObject,'String')) returns contents of edit_bin as a double


% --- Executes during object creation, after setting all properties.
function edit_bin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonAverage.
function pushbuttonAverage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonAverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning('off');

upindex=handles.upindex;
trialnum=handles.trialnum;
length=handles.length;

trial_from = str2num(get(handles.edit_trial_from,'String'));
sti1_number = str2num(get(handles.edit_sti1,'String'));

basal_time = str2double(get(handles.edit_pre_sti_time,'String'));
odor_time = str2double(get(handles.edit_post_sti_time,'String'));
control_time = str2num(get(handles.edit_control_time,'String'));

offset = str2double(get(handles.edit_offset,'String'));
clims = str2num(get(handles.edit_clims,'String'));
z_score = get(handles.radiobutton_z_score,'Value');
heatmap = get(handles.checkbox_heatmap,'Value');
bin = str2double(get(handles.edit_bin,'String'));
interval = 1/str2num(get(handles.TB_SampleRate,'String'));
if bin<interval
    bin=interval;
    set(handles.edit_bin,'String',num2str(interval));
end

trialnumtemp = trialnum;
for i=1:trialnum
    if upindex(i) < basal_time*100
        upindex(i)=0;
        trialnumtemp = trialnumtemp-1;
    end
end
upindex(upindex==0)=[];
trialnum=trialnumtemp;
for i =1:trialnum
    if upindex(i)+odor_time*100>length
        upindex(i)=0;
        trialnumtemp = trialnumtemp-1;
    end
end
trialnum=trialnumtemp;
upindex(upindex==0)=[];
set(handles.edit_sti1, 'String', num2str(trialnum));

values = handles.wave;
num = floor(bin/interval);
M = mod(size(values,1),num);
values = [values;zeros(num-M,1)];
values = mean(reshape(values',num,[]),1)';
interval = bin;

trigger1_times = trigger_times_pretreatment(upindex,trial_from,sti1_number,handles.edit_sti1);
[psth1,psth1_mean,psth1_sem] = psth_wave2(trigger1_times,interval,values,basal_time,odor_time,control_time(1),control_time(2),offset,z_score);
the_title = get(handles.edit_file,'String');
times = -basal_time:interval:odor_time-interval;

figure;
if z_score==1
    drawErrorLine(times,psth1_mean,psth1_sem,'red',0.5);
else
    drawErrorLine(times,100*psth1_mean,100*psth1_sem,'red',0.5);
end
title(the_title);
xlabel('Time (s)');
       if z_score==1
       ylabel('z-score');
       else
       ylabel('deltaF/F(%)');
       end

if heatmap
    fig1 = figure;
    thres = 10; 
    if z_score==1
       heatmapPlot(psth1,interval,basal_time,21:120,1,1:size(psth1,1),0.1,fig1,clims);
    else
       heatmapPlot(100*psth1,interval,basal_time,21:120,1,1:size(psth1,1),0.1,fig1,clims);
    end
    
end

save(strrep(handles.file_path_and_name,'csv','mat'),'times','psth1','psth1_mean','psth1_sem');
assignin('base','average',[times;psth1_mean]);


function edit_trial_from_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_from as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_from as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_from_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_from (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sti1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sti1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sti1 as text
%        str2double(get(hObject,'String')) returns contents of edit_sti1 as a double


% --- Executes during object creation, after setting all properties.
function edit_sti1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sti1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_post_sti_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_post_sti_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_post_sti_time as text
%        str2double(get(hObject,'String')) returns contents of edit_post_sti_time as a double


% --- Executes during object creation, after setting all properties.
function edit_post_sti_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_post_sti_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_control_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_control_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_control_time as text
%        str2double(get(hObject,'String')) returns contents of edit_control_time as a double


% --- Executes during object creation, after setting all properties.
function edit_control_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_control_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sampling_rate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sampling_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sampling_rate as text
%        str2double(get(hObject,'String')) returns contents of edit_sampling_rate as a double


% --- Executes during object creation, after setting all properties.
function edit_sampling_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sampling_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pre_sti_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pre_sti_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pre_sti_time as text
%        str2double(get(hObject,'String')) returns contents of edit_pre_sti_time as a double


% --- Executes during object creation, after setting all properties.
function edit_pre_sti_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pre_sti_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton_z_score.
function radiobutton_z_score_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_z_score (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_z_score

set(handles.radiobutton_z_score,'Value',1);
set(handles.radiobutton_deltaF,'Value',0);


function edit_offset_Callback(hObject, eventdata, handles)
% hObject    handle to edit_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_offset as text
%        str2double(get(hObject,'String')) returns contents of edit_offset as a double


% --- Executes during object creation, after setting all properties.
function edit_offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clims_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clims as text
%        str2double(get(hObject,'String')) returns contents of edit_clims as a double


% --- Executes during object creation, after setting all properties.
function edit_clims_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_heatmap.
function checkbox_heatmap_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_heatmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_heatmap


% --- Executes on selection change in popupmenu_sort.
function popupmenu_sort_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_sort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_sort contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_sort


% --- Executes during object creation, after setting all properties.
function popupmenu_sort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_sort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_SD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SD as text
%        str2double(get(hObject,'String')) returns contents of edit_SD as a double


% --- Executes during object creation, after setting all properties.
function edit_SD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_offset as text
%        str2double(get(hObject,'String')) returns contents of edit_offset as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_deltaF.
function radiobutton_deltaF_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_deltaF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_deltaF

set(handles.radiobutton_deltaF,'Value',1);
set(handles.radiobutton_z_score,'Value',0);



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bin as text
%        str2double(get(hObject,'String')) returns contents of edit_bin as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TB_SampleRate_Callback(hObject, eventdata, handles)
% hObject    handle to TB_SampleRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TB_SampleRate as text
%        str2double(get(hObject,'String')) returns contents of TB_SampleRate as a double


% --- Executes during object creation, after setting all properties.
function TB_SampleRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TB_SampleRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_controltime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_controltime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_controltime as text
%        str2double(get(hObject,'String')) returns contents of edit_controltime as a double


% --- Executes during object creation, after setting all properties.
function edit_controltime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_controltime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_evaluationtime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_evaluationtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_evaluationtime as text
%        str2double(get(hObject,'String')) returns contents of edit_evaluationtime as a double


% --- Executes during object creation, after setting all properties.
function edit_evaluationtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_evaluationtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
offset = str2double(get(handles.edit_offset,'String'));
z_score = get(handles.radiobutton_z_score,'Value');
controltime=str2num(get(handles.edit_controltime,'String'));
evaluationtime=str2num(get(handles.edit_evaluationtime,'String'));
interval = 1/str2num(get(handles.TB_SampleRate,'String'));
bin = str2double(get(handles.edit_bin,'String'));
if bin<interval
    bin=interval;
    set(handles.edit_bin,'String',num2str(interval));
end

values = handles.wave;
num = floor(bin/interval);
M = mod(size(values,1),num);
values = [values;zeros(num-M,1)];
values = mean(reshape(values',num,[]),1)';
interval = bin;

controldata=values(round(controltime(1)/interval):round(controltime(2)/interval));
if isempty(evaluationtime)
    evaluationdata=values;
else
    evaluationdata=values(round(evaluationtime(1)/interval):round(evaluationtime(2)/interval));
end

figure;
if z_score==1
    plot(interval*(1:1:length(evaluationdata)),(evaluationdata-mean(controldata))/std(controldata));
    xlabel('Time (s)');
    ylabel('z-score');
else
    plot(interval*(1:1:length(evaluationdata)),(evaluationdata-mean(controldata))/(mean(controldata)-offset)*100);
    xlabel('Time (s)');
    ylabel('deltaF/F(%)');
end


% --- Executes on selection change in pm_cue.
function pm_cue_Callback(hObject, eventdata, handles)
% hObject    handle to pm_cue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pm_cue contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_cue
if isfield(handles,'length')
    cell=[];
    switch get(hObject,'value')
        case 1
            for i=1:handles.length-1
                if handles.data1(i)==0 && handles.data1(i+1)==1
                    cell(i+1) =1;
                else	
                    cell(i+1) =0;
                end
            end
        case 2
            for i=1:handles.length-1
                if handles.data2(i)==0 && handles.data2(i+1)==1
                	cell(i+1) =1;
                else	
                    cell(i+1) =0;
                end
            end
        case 3
            for i=1:handles.length-1
                if handles.data3(i)==0 && handles.data3(i+1)==1
                    cell(i+1) =1;
                else	
                    cell(i+1) =0;
                end
            end
    end
upindex=find(cell==1);
handles.upindex=upindex;
trialnum = size(upindex);
handles.trialnum = trialnum(2);
set(handles.edit_sti1, 'String', num2str(handles.trialnum));
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function pm_cue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_cue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
