function tests = getTestsToPerform()
    lines = readlines("changed_files.txt");
    for iLine = 1:length(lines)
       disp(lines(iLine))
%     end
%     disp(input);
    tests="ans";
%     pathList = "Apps";
%     numOfPaths = length(pathList);
%     temp = zeros(1,numOfPaths);
%     for iPath = 1:numOfPaths
%         temp(iPath) = isPathForModelTest(pathList(iPath));
%     end
%     tests = all(temp);
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

% 
% function tests = testingPathControl()
%     pathList = "Apps";
%     numOfPaths = length(pathList);
%     temp = zeros(1,numOfPaths);
%     for iPath = 1:numOfPaths
%         temp(iPath) = isPathForModelTest(pathList(iPath));
%     end
%     
%     if temp
%         tests = "A case";
%     else
%         tests = "B case";
%     end
%     
% end    
% 
% function ForModelTestFlag = isPathForModelTest(path)
%     if contains(path,"Apps") && ~(contains(path,fullfile("Should-Cost App","Functions")) || contains(path,"Electrical Steel Viewer App"))
%         ForModelTestFlag = false;
%     elseif contains(path,"Cluster Framework") && ~(contains(path,"+cmTools") || contains(path,"+mtrx"))
%         ForModelTestFlag = false;
%     elseif contains(path,fullfile("_Development space_","Cloud architect"))
%         ForModelTestFlag = false;
%     else 
%         ForModelTestFlag = true;
%     end 
% end 

