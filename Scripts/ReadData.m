function r = ReadData(filePath,colu)
fid = fopen(filePath,'r');
colusSize = '%s'
for c=2:colu
    colusSize = strcat(colusSize,'%s')
end
%C2 = textscan(fid,'%s%s%s%s%s%s%s%s%s%s%s%s', 'CollectOutput',1);
C2 = textscan(fid,colusSize, 'CollectOutput',1);
fclose(fid);
r = C2{1,1};

