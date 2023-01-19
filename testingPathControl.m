function tests = testingPathControl()
    pathList = "Apps";
    numOfPaths = length(pathList);
    temp = zeros(1,numOfPaths);
    for iPath = 1:numOfPaths
        temp(iPath) = isPathForModelTest(pathList(iPath));
    end
    
%     if temp
%         tests = "A case";
%     else
%         tests = "B case";
%     end
   
   tests = "AB";
    
end    

function ForModelTestFlag = isPathForModelTest(path)
    if contains(path,"Apps") && ~(contains(path,fullfile("Should-Cost App","Functions")) || contains(path,"Electrical Steel Viewer App"))
        ForModelTestFlag = false;
    elseif contains(path,"Cluster Framework") && ~(contains(path,"+cmTools") || contains(path,"+mtrx"))
        ForModelTestFlag = false;
    elseif contains(path,fullfile("_Development space_","Cloud architect"))
        ForModelTestFlag = false;
    else 
        ForModelTestFlag = true;
    end 
end 
