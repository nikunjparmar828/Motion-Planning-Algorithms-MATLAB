%grid based a* Algorithm for path planning of USV
clf('reset');
import Astar.*
tic

%case  -1 
input_map = false(30); 
input_map(1:4,3) = 1;
input_map(2:10,6)=1;
input_map(1:8,3) = 1;
input_map(10,3:8) = 1;
input_map(25,1:29) = 1;
input_map(20,1:20) = 1;
start_coords = [1,1];
dest_coords = [27,25];


% input_map = false(10);
% input_map(3:10,1)=1;
% input_map(1,3:10)=1;
% 
% start_coords = [1,1];
% dest_coords = [9,9];

route = Astar (input_map, start_coords, dest_coords);

toc 

%------------------------
%Notes
%------------------------

% with diagonal approach:
% 
% Number of Expanded node = 176 - case-1
% Elapsed time is 9.407219 seconds
% 
% with normal approach:
% 
% Number of Expanded node = 480 - case-1
% Elapsed time is 25.142478 seconds
%





