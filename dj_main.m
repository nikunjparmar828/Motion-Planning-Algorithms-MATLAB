%grid based Dijkstra's Algorithm for path planning of USV

clf('reset');
% import Dijkstra.*

 


%case  -1 
input_map = false(100); 
start_coords = [2,2];
dest_coords = [90,90];
% flag = 0;

%case - 2
% input_map = false(5);
% start_coords = [5,1];
% dest_coords = [1,5];

ox = dest_coords(1)-1;
oy = dest_coords(2)-1;

while (start_coords ~= dest_coords)
    
    clf('reset');
    input_map = false(100);
    input_map(1:50,35:70) = 1;
%     ox = randi(100);
%     oy = randi(100);
%     
%     if( (ox<100 && oy<100) && ((ox~=start_coords(1) && oy~=start_coords(2)) && (ox~=dest_coords(1) && oy~=dest_coords(2))) && ((ox+1~=start_coords(1) && oy~=start_coords(2)) && (ox+1~=dest_coords(1) && oy~=dest_coords(2))) && ((ox~=start_coords(1) && oy+1~=start_coords(2)) && (ox~=dest_coords(1) && oy+1~=dest_coords(2))) && ((ox+1~=start_coords(1) && oy+1~=start_coords(2)) && (ox+1~=dest_coords(1) && oy+1~=dest_coords(2))))
%         input_map(ox,oy) = 1;
%         input_map(ox+1,oy) = 1;
%         input_map(ox,oy+1) = 1;
%         input_map(ox+1,oy+1) = 1;
%     end
%     
    %----------------------------------------------------------------------
    %Code to check collission avoidance while moving exactly in the
    %opposite direction of the robot or the boat 
    

    
    
%     if( ox>=35 && oy>=35 && ox~=start_coords(1) && oy~=start_coords(2) && ox~=dest_coords(1) && oy~=dest_coords(2) && ox+1~=start_coords(1) && oy~=start_coords(2) && ox+1~=dest_coords(1) && oy~=dest_coords(2) && ox-1~=start_coords(1) && oy~=start_coords(2) && ox-1~=dest_coords(1) && oy~=dest_coords(2) && ox~=start_coords(1) && oy-1~=start_coords(2) && ox~=dest_coords(1) && oy-1~=dest_coords(2)  && ox-1~=start_coords(1) && oy-1~=start_coords(2) && ox-1~=dest_coords(1) && oy+1~=dest_coords(2))
%         
%         input_map(ox,oy) = 1;
%         input_map(ox,oy-1) = 1;
%         input_map(ox-1,oy) = 1;
%         input_map(ox-1,oy-1) = 1;        
%         input_map(ox+1,oy-1) = 1;
%         input_map(ox+1,oy) = 1;
%         
% %     else 
% % TEsting arena for the changing of the color of the obstacles at the time of collision  
% %         input_map(ox,oy) = 0.5;
% %         input_map(ox,oy-1) = 0.5;
% %         input_map(ox-1,oy) = 0.5;
% %         input_map(ox-1,oy-1) = 0.5;        
% %         input_map(ox+1,oy-1) = 0.5;
% %         input_map(ox+1,oy) = 0.5;
%     end
% 
%     ox = ox-1;
%     oy = oy-1;
    
    
    
    %----------------------------------------------------------------------
    route = Dijkstra (input_map, start_coords, dest_coords);
    
    [i,j] = ind2sub(size(input_map), route(2));
    start_coords = [i,j];
    input_map(sub2ind(size(input_map),i,j)) = 0.5;
    

end

% route = Dijkstra (input_map, start_coords, dest_coords);
%------------------------
%Notes
%------------------------

% with diagonal approach:
% 
% Number of Expanded node = 498 - case-1
% Elapsed time is 35.078593
% 
% with normal approach
% 
% Number of Expanded node = 609 - case-1
% Elapsed time is 45.304830
% 