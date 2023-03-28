function isUserCancelled = restartMatlabAndExecute(function2Exec, varargin)

p = inputParser;
p.addParameter('gitPullAfterRestart', false, @islogical);
parse(p, varargin{:});
gitPullAfterRestart = p.Results.gitPullAfterRestart; % Optional: pull from remote after restart and before adding folders to the path

TIME_COUNTDOWN = 1; % in seconds

% Start countdown
hWait  = waitbar(1, sprintf('\nMATLAB will restart in 10 seconds and then will resume execution.\nPlease do not manually close MATLAB!\n'), ...
                    'Name', 'Counting down for restart...', ...
                    'CreateCancelBtn', 'setappdata(gcbf, ''canceling'', 1)');
hWait.Position(1:2) = [10 40];          % make to bottom left to ensure it is visible in case centered Apps are open
hWait.Color         = [0.94 0.85 0.75]; % highlight using light orange color

setappdata(hWait, 'canceling', 0);

moreGranularCountdown = 10*TIME_COUNTDOWN;
for iT = 1:moreGranularCountdown
    % Check for clicked Cancel button
    isCancelPressed = getappdata(hWait, 'canceling');
    if isCancelPressed
        break
    end
    
    pause(0.1) % 0.1sec for quick response to 'Cancel' button press
    waitbar((moreGranularCountdown-iT)/moreGranularCountdown, hWait, ...
            sprintf('\nMATLAB will restart in 10 seconds and then will resume execution.\nPlease do not manually close MATLAB!\n'), ...
            'Name', 'Counting down for restart...');
    figure(hWait) % bring waitbar to the foreground
end

if isCancelPressed
    % Disable Cancel button
    hBtn = findobj(hWait, 'Type', 'uicontrol');
    hBtn.Enable = 'off';
    drawnow
    
    % Change message of waitbar to notify user and then return execution
    hAx = findobj(hWait, 'Type', 'axes');
    hAx.Title.String = {'', 'MATLAB restart process has been cancelled!', ''};
    
    pause(2)
    delete(hWait)
    isUserCancelled = true;
    return
else
    % Close waitbar and then proceed with MATLAB restart
    pause(0.5)
    close(hWait)
    isUserCancelled = false;
end

% If requested, pull current branch from remote after restart (occurs in fixpath BEFORE adding branch folders to the path)
if gitPullAfterRestart
    fixpathCommand = "fixpath -p";
else
    fixpathCommand = "fixpath";
end

% Open new MATLAB session
matlabExePath = fullfile(matlabroot, 'bin', 'matlab.exe'); % full path of .exe of current version of MATLAB
initialWorkingFolder = pwd;
if usejava('desktop')
    systemCmd     = sprintf('"%s" -sd "%s" -r "%s"', matlabExePath, initialWorkingFolder, function2Exec);
else
    systemCmd     = sprintf('"%s" -sd "%s" -softwareopengl -batch "%s"', matlabExePath, initialWorkingFolder, function2Exec);
end
    
system(systemCmd);

% -sd folder   : Set the MATLAB folder to folder, specified as a string.
% -r statement : Execute the MATLAB statement.
%
% For more info:
%   >> doc('matlab (Windows)')

% Close current session
pause(2) % extra delay to avoid one session closing while the other is opening; this could lead to a corrupted Toolbox Path Cache
         % (which is not any big issue - just trying to avoid the relevant warning)
quit force

