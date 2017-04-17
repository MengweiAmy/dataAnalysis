%%Calculate the KSPS(Key stroke per minute)
%%Which consider about all the key strokes, also including the backspaces
% IS is the input stream
% S is the seconds spent on entering the whole sentences
function ksps = KSPS(IS,S)
ksps = (IS-1)./S