% this function is meant to detect the start of exercise
function [position,isterminal,direction] = myEventsFcn(t,y,tstart)
  position = t-tstart; % The value that we want to be zero
  isterminal = 0;  % Do not halt integration 
  direction = 0;   % The zero can be approached from either direction
end