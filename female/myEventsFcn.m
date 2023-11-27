function [position,isterminal,direction] = myEventsFcn(t,y)
  position = t-10; % The value that we want to be zero
  isterminal = 0;  % Do not halt integration 
  direction = 0;   % The zero can be approached from either direction
end