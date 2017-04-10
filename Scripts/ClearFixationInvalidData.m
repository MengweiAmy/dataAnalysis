%%Clear the invaild fixation data
% EyeFound == 0
%% FixationIndex = -1

function r = ClearFixationInvalidData(fixaDoul)
%remove eye found zero rows
zeroId = (fixaDoul(:,2) == 1);
zeroLine = fixaDoul(zeroId,:);

%remove non-fixation (-1) rows
nonFixId = (zeroLine(:,12) ~= -1);
r = zeroLine(nonFixId,:);