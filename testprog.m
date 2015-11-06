clc;
clear all;
close all;
I=imread('original_2.png');
A=I(:,:,1)/255;
[ra,ca]=size(A);
I=imread('obj2_5.png');
B=I(:,:,1)/255;
[rb,cb]=size(B);

Ac=1-A;
Bc=1-B;
temp1=0;

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
               I_f(i-s,j-t)=1;
           end
    end
end
for i=1:rc
    for j=1:cc
        if(I_f(i,j)==1)
            I_f(i-s:i+s,j-t:j+t)=B;
        end
    end
end