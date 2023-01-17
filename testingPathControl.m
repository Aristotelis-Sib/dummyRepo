function tests = testingPathControl(pathList)
    numOfPaths = length(pathList);
    tests = zeros(1,numOfPaths);
    for iPath = 1:numOfPaths
        tests(iPath) = isPathForModelTest(pathList(iPath));
    end
    disp(tests);
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

