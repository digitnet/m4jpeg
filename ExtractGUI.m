function varargout = ExtractGUI(varargin)
% EXTRACTGUI MATLAB code for ExtractGUI.fig
%      EXTRACTGUI, by itself, creates a new EXTRACTGUI or raises the existing
%      singleton*.
%
%      H = EXTRACTGUI returns the handle to a new EXTRACTGUI or the handle to
%      the existing singleton*.
%
%      EXTRACTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACTGUI.M with the given input arguments.
%
%      EXTRACTGUI('Property','Value',...) creates a new EXTRACTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ExtractGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ExtractGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ExtractGUI

% Last Modified by GUIDE v2.5 20-May-2013 07:57:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ExtractGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ExtractGUI_OutputFcn, ...
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


% --- Executes just before ExtractGUI is made visible.
function ExtractGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ExtractGUI (see VARARGIN)

% Choose default command line output for ExtractGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ExtractGUI wait for user response (see UIRESUME)
% uiwait(handles.fig_extract);
 
global NewPosition;
x_value = NewPosition(1);
y_value = NewPosition(2);
set(handles.fig_extract,'Position',[x_value,y_value,120,30]); 
% Five components within the main window
set(handles.pnl_extract,'Position', [10,6,100,20]);
set(handles.btn_next,'Position', [95,3,15,2]);
set(handles.btn_back,'Position', [80,3,15,2]);
set(handles.btn_exit,'Position', [65,3,15,2]);
set(handles.btn_about,'Position', [10,3,15,2]);
 
%%%% Five components within the internal panel
set(handles.btn_selectjpeg,'Position', [5,16,30,2]);
set(handles.edit_stegofile,'Position', [5,13,90,1.7]);
set(handles.txt_stegofile,'Position', [5,10,90,1.35]);
set(handles.btn_extraction,'Position', [5,1.3,30,2]);
set(handles.btn_clear,'Position', [35,1.3,15,2]);
%%%%

% --- Outputs from this function are returned to the command line.
function varargout = ExtractGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_selectjpeg.
function btn_selectjpeg_Callback(hObject, eventdata, handles)
% hObject    handle to btn_selectjpeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global StegoIm;
global extension;

M4=[1 1 1 1];

[filename, pathname] = ...
   uigetfile({'*.JPG';'*.*'},'Select the steganographed JPEG file');
StegoIm_tmp=[pathname,filename]; 
tf = ischar(StegoIm_tmp); % returns 1 (true) if StegoIm_tmp is a character array 
                          % and 0 (false) otherwise.
if (tf==1) % StegoIm_tmp is a string.
   StegoIm=StegoIm_tmp;
   set(handles.txt_stegofile,'ForeGroundColor',[0 0 0]); %Black. 
   set(handles.txt_stegofile,'String','.. Testing .. Please wait ..');
   
   set(handles.edit_stegofile,'String',StegoIm);
   msgbox('The entered JPEG file is being tested .. Please wait ..','Information','modal');
   %%%%

   % Reading Stego JPG File.
   JPG=jpeg_read(StegoIm);            %OK  
   %%%%
   % Reading Matrix3 in order to test the existence of hidden data.
   mat3=JPG.coef_arrays{3};           %OK
   GQCBuff3=mat2GQCs(mat3);           %OK
   ValidBuff3=ValidTest(GQCBuff3,M4); %OK
   %%%%  
   siz=size(mat3);            % Size of matrix2
   NbGQCs3=(siz(1)*siz(2))/4;  % Tolal number of GQCs
   stream = RandStream('mt19937ar','seed',3533130573);
   RandStream.setGlobalStream(stream);
   index=randperm(NbGQCs3);          % Gives Permutation.  
   %%%%   
   GQCBuff3 = GQCBuff3(index);        % 3533130573-scrambling.
   ValidBuff3 = ValidBuff3(index);    % 3533130573-scrambling.
   %%%%   
   block = ExtractFrmMat(24,GQCBuff3,ValidBuff3,0,'');
   clear GQCBuff3 ValidBuff3 index mat3;

   block1=[0,0,0,0,0,0,0,0,0,0,0,0];
   for i = 1:12
      block1(i)=block(i);
   end
   
   block2=[0,0,0,0,0,0,0,0,0,0,0,0];
   for i = 13:24
      block2(i-12)=block(i);
   end

   extn1 = buildextn(block1);
   extn2 = buildextn(block2);
   extension=char(extn1);
   singature=char(extn2);
   comp=strcmp(singature,'JPG');
   %%%%
   
   if(comp == 1)
     %The tested JPG file is steganographed.
     Selctstr=['Selected JPEG is steganographed and contains a ',extension,' file'];
     set(handles.txt_stegofile,'String',Selctstr);
     set(handles.txt_stegofile,'ForeGroundColor',[0 0.6 0]); %Green.
     set(handles.btn_extraction,'Enable','on');              %Enabled.  
   else
     %The tested JPG file is NOT steganographed.
     Selctstr='Selected JPEG is NOT steganographed by JPEG File Hider';
     set(handles.txt_stegofile,'String',Selctstr);
     set(handles.txt_stegofile,'ForeGroundColor',[1 0 0]);   %Red.
     set(handles.btn_extraction,'Enable','of');              %Disabled.
   end  
   
   msgbox('The test is complete .. Press OK to continue','Information','modal'); 
   uiwait;
end

function edit_stegofile_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stegofile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stegofile as text
%        str2double(get(hObject,'String')) returns contents of edit_stegofile as a double


% --- Executes during object creation, after setting all properties.
function edit_stegofile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stegofile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_extraction.
function btn_extraction_Callback(hObject, eventdata, handles)
% hObject    handle to btn_extraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global StegoIm;
global extension;

M4=[1 1 1 1];

cmpp=0;
while (cmpp == 0)
  prompt = {'Enter the KEY:',...
            'Re-enter the KEY:' };
  dlg_title = 'THE KEY';
  answer = inputdlg(prompt,dlg_title,1);
  AnswerDim=size(answer);
  % *** Cancel Button ******************
  if(AnswerDim == [0,0]) 
     cntinu=0;
     cmpp=1;
  end
  % *** OK Button **********************
  if(AnswerDim==[2,1]) 
     cmpp=strcmp(answer(1,1),answer(2,1)); % Comparing between answers
     if(cmpp == 1)
        strgkey=answer{1,1};
        StrgDim = size(strgkey);  % Gives size matrix.
        keyleng=StrgDim(1,2);     % keyleng is the length of key.
        if(keyleng < 12)
           msgbox('The key must be at least 12 characters','KEY ERROR!','error','modal');
           uiwait;
           cmpp=0;     
        else
           cntinu=1;
        end
     else
        msgbox('The keys entered are not the same, please re-enter them again.','KEY ERROR!','error','modal');
        uiwait;
     end
  end
  %**************************************
end
%%%%%%%%%%%%%
if(cntinu==1)
 
   choice = questdlg('In case of WRONG key, the extracted file will be UNREADABLE. Do you want to continue with the entered key:', ...
   '!! Warning !!', ...
   'Yes','No','Yes');
   switch choice
       case 'Yes'
          cntinu=1; %  cntinu stays true   : continue extracting.
       case 'No'
          cntinu=0; %  cntinu becomes false: cancel extracting. 
   end
end
%%%%%%%%%%%%%
if(cntinu==1)
   
   Outfile=['Extracted.',extension];
   savestrg=['Save extracted ',extension,' file as:'];
   [filename,pathname] = uiputfile(Outfile,savestrg);
   Outfile = [pathname,filename];
    
   tf = ischar(Outfile); % returns 1 (true) if Outfile is a character array 
                         % and 0 (false) otherwise.
   if (tf==1) % Outfile is a string.
     msgbox('The extracting process is being done .. Please wait ..','Information','modal'); 
     %%%%
     strgkey=answer{1,1};        % The entered string Key.
     key32b=HashKeyStr(strgkey);
     %%%%
     % Reading Stego JPEG File.
     JPG=jpeg_read(StegoIm);            %OK
     %%%%
     mat2=JPG.coef_arrays{2};           %OK
     GQCBuff2=mat2GQCs(mat2);           %OK
     ValidBuff2=ValidTest(GQCBuff2,M4); %OK
     %%%%
     siz=size(mat2);             % Size of matrix2
     NbGQCs2=(siz(1)*siz(2))/4;  % Tolal number of GQCs.
     stream = RandStream('mt19937ar','seed',3533130573);
     RandStream.setGlobalStream(stream);
     index=randperm(NbGQCs2);          % Gives Permutation.  
     %%%%
     GQCBuff2 = GQCBuff2(index);        % 3533130573-scrambling.
     ValidBuff2 = ValidBuff2(index);    % 3533130573-scrambling.
     %%%%
     block = ExtractFrmMat(10,GQCBuff2,ValidBuff2,0,'');
     clear GQCBuff2 ValidBuff2 index mat2;
   
     Embededata=0; % in bits
     for k=1:10
       Embededata = bitshift(Embededata, +2);   
       Embededata = bitor(Embededata,block(11-k));   
     end
     UsedGQCs1=Embededata/2; % Used GQCs in matrix1.
     %%%%   
     mat1=JPG.coef_arrays{1};            %OK
     GQCBuff1=mat2GQCs(mat1);            %OK
     ValidBuff1=ValidTest(GQCBuff1,M4);  %OK
     %%%%
     siz=size(mat1);            % Size of matrix1
     NbGQCs1=(siz(1)*siz(2))/4;  % Tolal number of GQCs.
     stream = RandStream('mt19937ar','seed',key32b);
     RandStream.setGlobalStream(stream);
     index=randperm(NbGQCs1);          % Gives Permutation.  
     %%%%
     GQCBuff1 = GQCBuff1(index);        % key32b-scrambling.
     ValidBuff1 = ValidBuff1(index);    % key32b-scrambling.
     %%%%
     % Extracting Hidden Secret File from matrix1
     block = ExtractFrmMat(UsedGQCs1,GQCBuff1,ValidBuff1,1,Outfile);
     clear GQCBuff1 ValidBuff1 index mat1;
     %%%%
     outstr=['Based on the entered key, an hidden ',extension,' file has been extracted and put on the specified location successfully.'];
     msgbox(outstr,'Information','modal'); 
     uiwait;
   end
else % Case of cntinu=0.
   msgbox('The extracting process has been canceled ..!','Canceled ..!','warn','modal');
   uiwait;
end
% --- Executes on button press in btn_clear.
function btn_clear_Callback(hObject, eventdata, handles)
% hObject    handle to btn_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global StegoIm;
global extension;

extension='';
StegoIm='';

set(handles.edit_stegofile,'String','  No JPEG file selected');
set(handles.txt_stegofile,'String','  No JPEG file selected');
set(handles.btn_extraction,'Enable','of');
set(handles.txt_stegofile,'ForeGroundColor',[0 0 0]); %Black.


% --- Executes on button press in btn_next.
function btn_next_Callback(hObject, eventdata, handles)
% hObject    handle to btn_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_back.
function btn_back_Callback(hObject, eventdata, handles)
% hObject    handle to btn_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global NewPosition;
NewPosition=get(handles.fig_extract,'Position');
close(ExtractGUI);
run('StartGUI');     

% --- Executes on button press in btn_exit.
function btn_exit_Callback(hObject, eventdata, handles)
% hObject    handle to btn_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(ExtractGUI);

% --- Executes on button press in btn_about.
function btn_about_Callback(hObject, eventdata, handles)
% hObject    handle to btn_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

run('About');
