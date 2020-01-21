function varargout = HideGUI(varargin)
% HIDEGUI MATLAB code for HideGUI.fig
%      HIDEGUI, by itself, creates a new HIDEGUI or raises the existing
%      singleton*.
%
%      H = HIDEGUI returns the handle to a new HIDEGUI or the handle to
%      the existing singleton*.
%
%      HIDEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HIDEGUI.M with the given input arguments.
%
%      HIDEGUI('Property','Value',...) creates a new HIDEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HideGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HideGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HideGUI

% Last Modified by GUIDE v2.5 16-May-2013 09:51:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HideGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @HideGUI_OutputFcn, ...
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


% --- Executes just before HideGUI is made visible.
function HideGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HideGUI (see VARARGIN)

% Choose default command line output for HideGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HideGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global NewPosition;
x_value = NewPosition(1);
y_value = NewPosition(2);
set(handles.figure1,'Position',[x_value,y_value,120,30]); 
% Five components within the main window
set(handles.uipanel1,'Position', [10,6,100,20]);
set(handles.btn_next,'Position', [95,3,15,2]);
set(handles.btn_back,'Position', [80,3,15,2]);
set(handles.btn_exit,'Position', [65,3,15,2]);
set(handles.btn_about,'Position', [10,3,15,2]);
%%%% Eight components within the internal panel
set(handles.pushbutton1,'Position', [5,16,30,2]);
set(handles.text1,'Position', [37.5,16.2,57.5,1.35]);
set(handles.edit2,'Position', [5.0,13.0,90.0,1.7]);
set(handles.pushbutton2,'Position', [5.0,10.0,30.0,2.0]);
set(handles.text3,'Position', [37.5,10.2,57.5,1.35]);
set(handles.edit4,'Position', [5.0,7.0,90.0,1.7]);
set(handles.pushbutton3,'Position', [5.0,1.3,30.0,2.0]);
set(handles.pushbutton4,'Position', [35.0,1.3,15.0,2.0]);
%%%%

% --- Outputs from this function are returned to the command line.
function varargout = HideGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Selecting Jpeg Cover File:  M4(F1,F2,t1,t2).

M4=[1 1 1 1];
global Cap; global MsgBytes;
global OrignIm;

[filename, pathname] = ...
   uigetfile({'*.JPG';'*.*'},'Select the JPEG cover file');
OrignIm_tmp=[pathname,filename];

tf = ischar(OrignIm_tmp); % returns 1 (true) if OrignIm is a character array 
                          % and 0 (false) otherwise.
if (tf==1) % OrignIm_tmp is a string.
  OrignIm = OrignIm_tmp;
  set(handles.text1,'ForeGroundColor',[0 0 0]); %Black.
  set(handles.text1,'String','.. Testing .. Please Wait ..');
  set(handles.edit2,'String',OrignIm);
  msgbox('The entered JPEG file is being tested .. Please wait ..','Information','modal');
 
  [Error Cap]= CoverJpegTest(OrignIm,M4);
  
  if(Error==0)  % Accepted JPEG : There are No errors.
     Capstr=dec2base(Cap, 10); % Converts to String.
     Capstr=['ACCEPTED, Capacity: ',Capstr,' bytes'];
     set(handles.text1,'ForeGroundColor',[0 0.6 0]); %Green.
     set(handles.text1,'String',Capstr);
     
     set(hObject,'UserData','y'); % Indicates to accepted JPEG file.
     Msgselect = get(handles.pushbutton2,'UserData');
     
     if(Msgselect == 'y')
        if(MsgBytes <= Cap)
        %  Message file can be hidden in selected Jpeg.    
           set(handles.text3,'ForeGroundColor',[0 0.6 0]); %Green.
           set(handles.pushbutton3,'Enable','on');       %Enabled.  
        else
        %  Message file can NOT be hidden in selected Jpeg.   
           set(handles.text3,'ForeGroundColor',[1 0 0]); %Red.
           set(handles.pushbutton3,'Enable','of');       %Disabled.
        end  
     end
     
     msgbox('The entered JPEG file has been tested .. Press OK to continue','Information','modal'); 
     uiwait;
  elseif (Error==1) || (Error==2) || (Error==3) || (Error==4)
     % Rejected JPEG : There is an error.
     Errorchar=dec2base(Error, 10); % Converts to String.  
     Errorstr=['REJECTED, Error: ',Errorchar];
     set(handles.text1,'ForeGroundColor',[1 0 0]); %Red.
     set(handles.text1,'String',Errorstr);
     %%%%
     set(hObject,'UserData','');    % Indicates to non accepted JPEG file.
     set(handles.text3,'ForeGroundColor',[0 0 0]); %Black.
     set(handles.pushbutton3,'Enable','of');
     %%%%
     msgstr=['Selected JPEG can NOT be used, Error',Errorchar,' .. Press OK to continue'];   
     msgbox(msgstr,'Information','modal'); 
     uiwait;  
  
  elseif(Error==5)
     % Rejected JPEG : JPEG is too large.
     Errorstr='REJECTED, too large, Error: 5';
     set(handles.text1,'ForeGroundColor',[1 0 0]); %Red.
     set(handles.text1,'String',Errorstr);
     %%%%
     set(hObject,'UserData','');    % Indicates to non accepted JPEG file.
     set(handles.text3,'ForeGroundColor',[0 0 0]); %Black.
     set(handles.pushbutton3,'Enable','of');
     %%%%
     msgbox('Selected JPEG is too large, Error5 .. Press OK to continue','Information','modal'); 
     uiwait;
 end
end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Selecting Message File which will be hidden.

global Cap; global MsgBytes;
global msgfile;global extension;

[filename, pathname] = ...
   uigetfile({'*.*'},'Select the file that you want to hide');
msgfile_tmp=[pathname,filename];
tf = ischar(msgfile_tmp); % returns 1 (true) if msgfile_tmp is a character array 
                          % and 0 (false) otherwise.
if (tf==1) % msgfile_tmp is a string.
  msgfile = msgfile_tmp;
  namesize=size(filename);
  extension='000';
  for k=1:3
      extension(k)=filename(namesize(2)-3+k);
  end
  % Calculating the needed number of GQC blocks to embed the file.
  Msgbits=Msgsize(msgfile);    %OK
  MsgBytes=Msgbits/8;          % Size of file to be hidden (in Bytes).

  Msgstr=dec2base(MsgBytes, 10); % Converts to String.
  Msgstr=['Selected file size is ',Msgstr,' bytes'];
  set(handles.text3,'ForeGroundColor',[0 0 0]); %Black.
  set(handles.text3,'String',Msgstr);
  set(handles.edit4,'String',msgfile);
  

  set(hObject,'UserData','y'); % Indicates to selected secret file.
  jpgselect = get(handles.pushbutton1,'UserData');

  if(jpgselect == 'y')
     if(MsgBytes <= Cap)
     %  Message file can be hidden in selected Jpeg.    
        set(handles.text3,'ForeGroundColor',[0 0.6 0]);  %Green.
        set(handles.pushbutton3,'Enable','on');          %Enabled.  
     else
     %  Message file can NOT be hidden in selected Jpeg.
        set(handles.text3,'ForeGroundColor',[1 0 0]);    %Red.
        set(handles.pushbutton3,'Enable','of');          %Disabled.
     end    
  end
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hiding Selected Secret File inside Selected JPEG.

M4=[1 1 1 1];
global OrignIm;                   % Selected JPEG File.
global msgfile; global extension; % Selected Secret File and its extension.

[filename,pathname] = ...
    uiputfile('Stego.JPG','Save steganographed JPEG file as:');
StegoIm =[pathname,filename];
tf = ischar(StegoIm); % returns 1 (true) if StegoIm is a character array 
                      % and 0 (false) otherwise.
if (tf==1) % StegoIm is a string.
   cmpp=0;
   while (cmpp == 0)
     prompt = {'Enter the KEY:',...
               'Re-enter the KEY:' };
     dlg_title = 'THE KEY';
     answer = inputdlg(prompt,dlg_title,1);
     AnswerDim=size(answer);
     % *** Cancel Button ******************
     if(AnswerDim==[0,0]) 
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
           msgbox('The keys entered are NOT the same, please re-enter them again.','KEY ERROR!','error','modal');
           uiwait;
        end
     end
     %**************************************
   end

   if(cntinu==1)
   
      msgbox('The hiding process is being done .. Please wait ..','Information','modal');
      %%%%
   
      strgkey=answer{1,1};       % The entered string Key.
      key32b=HashKeyStr(strgkey);
      % Reading Cover JPEG.
      JPG=jpeg_read(OrignIm);      %OK
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      % Reading Matrix3 in order to hide Secret File Extension.
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      mat3=JPG.coef_arrays{3};     %OK
      GQCBuff3=mat2GQCs(mat3);      %OK
      ValidBuff3=ValidTest(GQCBuff3,M4);  %OK
      VldNb3=ValidNb(ValidBuff3);    %OK
      %%%%
      extn1=double(extension);
      block1 = BuildBlock(extn1);
      extn2=double('JPG');
      block2 = BuildBlock(extn2);
      block=[block1,block2];
      %%%%
      siz=size(mat3);             % Size of matrix3
      NbGQCs3=(siz(1)*siz(2))/4;  % Tolal number of GQCs
      stream = RandStream('mt19937ar','seed',3533130573);
      RandStream.setGlobalStream(stream);
      index=randperm(NbGQCs3);    % Gives permutation.
      %%%%
      GQCBuff3 = GQCBuff3(index);       % 3533130573-scrambling.
      ValidBuff3 = ValidBuff3(index);   % 3533130573-scrambling.

      % NGQCBuff=Embed_mat(GQCBuff,ValidBuff,msgfile,block,NeedGQCs,fileflag,M4)
      NGQCBuff3=Embed_mat(GQCBuff3,ValidBuff3,'',block,24,0,M4);%Embeding Process.
      clear GQCBuff3 ValidBuff3;
      NGQCBuff3(index) = NGQCBuff3;     % De-scrambling.
      clear index;
      %%%%
      Nmat3=GQCs2mat(NGQCBuff3,size(mat3));   
      JPG.coef_arrays{3}=Nmat3;         % Writing New matrix3 to JPG structure.
      clear NGQCBuff3 Nmat3 mat3;
   
      % Secret File extension and signature have been embedded inside matrix3.
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      % Reading Matrix2 in order to hide Secret File Size.
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      mat2=JPG.coef_arrays{2};      %OK
      GQCBuff2=mat2GQCs(mat2);      %OK
      ValidBuff2=ValidTest(GQCBuff2,M4);  %OK
      VldNb2=ValidNb(ValidBuff2);    %OK
      %%%%
      Msgbits=Msgsize(msgfile);    %OK: Secret file Size //bits//
      % Decomposition of Msgbits:
      a=Msgbits; % File to be hidden SIZE <= 1048575 bits size,
                 % represented by 20 bits.
      block=[0,0,0,0,0,0,0,0,0,0];
      for k=1:10
         block(k) = bitand(a, 3);
         a = bitshift(a, -2);
      end
      %%%%    
      siz=size(mat2);             % Size of matrix2
      NbGQCs2=(siz(1)*siz(2))/4;  % Tolal number of GQCs
      stream = RandStream('mt19937ar','seed',3533130573);
      RandStream.setGlobalStream(stream);
      index=randperm(NbGQCs2);    % Gives permutation.
   
      GQCBuff2 = GQCBuff2(index);        % 3533130573-scrambling.
      ValidBuff2 = ValidBuff2(index);    % 3533130573-scrambling.
      % NGQCBuff=Embed_mat(GQCBuff,ValidBuff,msgfile,block,NeedGQCs,fileflag,M4)  
      NGQCBuff2=Embed_mat(GQCBuff2,ValidBuff2,'',block,10,0,M4);%Embeding Process.
      clear GQCBuff2 ValidBuff2;
      NGQCBuff2(index) = NGQCBuff2;      % De-scrambling.
      clear index;
      %%%%
      Nmat2=GQCs2mat(NGQCBuff2,size(mat2));
      JPG.coef_arrays{2}=Nmat2;          % Writing New matrix2 to JPG structure.
      clear NGQCBuff2 Nmat2 mat2;
      % File Size has been embedded inside matrix2.
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      % Reading matrix1 in order to hide the Secret File.
  
      mat1=JPG.coef_arrays{1};    %OK
      GQCBuff1=mat2GQCs(mat1);    %OK
      ValidBuff1=ValidTest(GQCBuff1,M4);  %OK
      VldNb1=ValidNb(ValidBuff1);    %OK
      %%%%
      Cap=VldNb1*2;                % Real Capacity   //Bits//.
      Cap=(Cap-mod(Cap,8))/8;      % Real Capacity   //Bytes//.
      % Calculating the needed number of GQC blocks.
      Msgbits=Msgsize(msgfile);    %OK 
      NeedGQCs=Msgbits/2;
      MsgBytes=Msgbits/8;          % Secret File Size //Bytes//.
      %%%%
      if(MsgBytes <= Cap)
         siz=size(mat1);             % Size of matrix1
         NbGQCs1=(siz(1)*siz(2))/4;  % Tolal number of GQCs
         stream = RandStream('mt19937ar','seed',key32b);
         RandStream.setGlobalStream(stream);
         index=randperm(NbGQCs1);
         %%%%
         GQCBuff1 = GQCBuff1(index);        % key32bit-scrambling.
         ValidBuff1 = ValidBuff1(index);    % key32bit-scrambling.
 
         % NGQCBuff=Embed_mat(GQCBuff,ValidBuff,msgfile,block,NeedGQCs,fileflag,M4)    
         % Embeding Process.
         NGQCBuff1=Embed_mat(GQCBuff1,ValidBuff1,msgfile,0,NeedGQCs,1,M4);
         clear GQCBuff1 ValidBuff1;
         NGQCBuff1(index) = NGQCBuff1;      % De-scrambling.
         clear index;
         %%%%
         Nmat1=GQCs2mat(NGQCBuff1,size(mat1));
         JPG.coef_arrays{1}=Nmat1;  % Writing New matrix1 to JPG structure.
         clear NGQCBuff1 Nmat1 mat1;
         % Secret File has been embedded inside matrix1.
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         jpeg_write(JPG,StegoIm); % Writing New DCT matrices to stego JPG File.
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
         %%%%
         outstr=['Secret file has been hidden within ',filename,' file successfully'];
         msgbox(outstr,'Information','modal'); 
         uiwait;
      end
      %%%%
   else % The case of cntinu=0
      msgbox('The hiding process has been canceled','Canceled ..!!','warn','modal');
      uiwait;
   end
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Clear Button.

global OrignIm; global Cap;
global msgfile; global extension; global MsgBytes;

OrignIm=''; Cap=0;
msgfile=''; extension=''; MsgBytes=0;

set(handles.pushbutton1,'UserData','');
set(handles.pushbutton2,'UserData','');

set(handles.text1,'String','');
set(handles.edit2,'String','  No JPEG file selected');
set(handles.text3,'String','');
set(handles.edit4,'String','  No secret file selected');

set(handles.text1,'ForeGroundColor',[0 0 0]); %Black.
set(handles.text3,'ForeGroundColor',[0 0 0]); %Black.
set(handles.pushbutton3,'Enable','of');

% --- Executes on button press in btn_about.
function btn_about_Callback(hObject, eventdata, handles)
% hObject    handle to btn_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

run('About');

% --- Executes on button press in btn_exit.
function btn_exit_Callback(hObject, eventdata, handles)
% hObject    handle to btn_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(HideGUI);


% --- Executes on button press in btn_back.
function btn_back_Callback(hObject, eventdata, handles)
% hObject    handle to btn_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global NewPosition;
NewPosition=get(handles.figure1,'Position');
 
close(HideGUI);
run('StartGUI');

% --- Executes on button press in btn_next.
function btn_next_Callback(hObject, eventdata, handles)
% hObject    handle to btn_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
