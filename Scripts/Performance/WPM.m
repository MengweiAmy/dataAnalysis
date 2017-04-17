%% Calculation of the WPM
% T is the lenght of the entered string ,include the letters, spaces, but
% no backspaces
% S is the seconds spent on entering the whole sentences
function wpm = WPM(T,S)

wpm = (T-1)./S .* 60 .* 0.2; 