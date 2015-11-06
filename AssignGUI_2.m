function varargout = AssignGUI_2(varargin)
% ASSIGNGUI_2 MATLAB code for AssignGUI_2.fig
%      ASSIGNGUI_2, by itself, creates a new ASSIGNGUI_2 or raises the existing
%      singleton*.
%
%      H = ASSIGNGUI_2 returns the handle to a new ASSIGNGUI_2 or the handle to
%      the existing singleton*.
%
%      ASSIGNGUI_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASSIGNGUI_2.M with the given input arguments.
%
%      ASSIGNGUI_2('Property','Value',...) creates a new ASSIGNGUI_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AssignGUI_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AssignGUI_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AssignGUI_2

% Last Modified by GUIDE v2.5 29-Oct-2015 15:34:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AssignGUI_2_OpeningFcn, ...
                   'gui_OutputFcn',  @AssignGUI_2_OutputFcn, ...
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


% --- Executes just before AssignGUI_2 is made visible.
function AssignGUI_2_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AssignGUI_2 (see VARARGIN)

% Choose default command line output for AssignGUI_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AssignGUI_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AssignGUI_2_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SelectA.
function SelectA_Callback(~, ~, handles)
% hObject    handle to SelectA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[File_Name, Path_Name] = uigetfile('PATHNAME');
axes(handles.axes2);
I=imread([Path_Name,File_Name]);
imshow(uint8(I),[]);


% --- Executes on button press in selectB.
function selectB_Callback(~, ~, handles)
% hObject    handle to selectB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[File_Name, Path_Name] = uigetfile('PATHNAME');
axes(handles.axes3);
I=imread([Path_Name,File_Name]);
imshow(uint8(I),[]);

% --- Executes on button press in HitAndMiss.
function HitAndMiss_Callback(~, ~, handles)
% hObject    handle to HitAndMiss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I1 = getimage(handles.axes2);
I2 = getimage(handles.axes3);
A=I1(:,:,1)/255;
[ra,ca]=size(A);
B=I2(:,:,1)/255;
[rb,cb]=size(B);


if ra>rb && ca>cb
Ac=1-A;
Bc=1-B;

s=(rb-1)/2;
t=(cb-1)/2;
rc=ra+rb-1;
cc=ca+cb-1;

I_padded=zeros(rc,cc);
I_paddedc=zeros(rc,cc);
I_padded(1+s:(rc-s),1+t:(cc-t))=A;
I_paddedc(1+s:(rc-s),1+t:(cc-t))=Ac;
I_f=zeros(rc,cc);

%--------------Computing the Gradient inverse for the entire image---------
for i=1+s:(rc-s)
    for j=1+t:(cc-t)
        %Compute the gradient inverse coefficients 
           match_fore=CalcMatch(I_padded(i-s:i+s,j-t:j+t),B);
           match_back= CalcMatch(I_paddedc(i-s:i+s,j-t:j+t) , Bc);
           if(match_fore && match_back )
               I_f(i,j)=255;
           end
    end
end
for i=1:rc
    for j=1:cc
        if(I_f(i,j)==255)
            I_f(i-s:i+s,j-t:j+t)=B;
        end
    end
end
axes(handles.axes4);

imshow(uint8(I_f(1+s:(rc-s),1+t:(cc-t))),[]);

else
     h = msgbox('Size of the object to be detected must be smaller than input image');
end
