function test=captureReturn(arg1)
    disp(arg1);
    temp = strsplit(arg1,',');
    disp(temp);
    test=42;
end 
