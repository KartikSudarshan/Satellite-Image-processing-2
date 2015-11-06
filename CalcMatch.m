function [ Flag ] = CalcMatch( I1,I2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
Flag=1;
[r,c]=size(I1);
for i=1:r
    for j=1:c
        if (I1(i,j) && I2(i,j)~=1)
            Flag=0;
            break;
           
        end
    end
end

end

