vid = videoinput('linuxvideo', 1);
%set(vid,'FramesPerTrigger',1);
%set(vid,'TriggerRepeat',Inf);
%set(vid,'ReturnedColorSpace','rgb')
%vidRes = get(vid, 'VideoResolution');
%nBands = get(vid, 'NumberOfBands');
frame = getsnapshot(vid);
delete(vid);
