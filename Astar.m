%grid based a* Algorithm for path planning of USV

function route = Astar (input_map, start_coords, dest_coords)

% Create a color map
cmap = [1   1   1;0   0   0;1   0   0;0   0   1;0   1   0;1   1   0;0.5 0.5 0.5];
colormap(cmap);                    

[nrows, ncols] = size(input_map);  


map = zeros(nrows,ncols);           
map(~input_map) = 1;                
map(input_map) = 2;                 
start_node = sub2ind(size(map), start_coords(1), start_coords(2));      
dest_node = sub2ind(size(map), dest_coords(1), dest_coords(2));         
map(start_node) = 5;                
map(dest_node) = 6;      

numExpanded = 0;

distanceFromStart = Inf(nrows,ncols);   
distanceFromEnd = Inf(nrows,ncols);     

parent = zeros(nrows, ncols);           

distanceFromStart(start_node) = 0;  % distance of start node from start is zero
distanceFromEnd(dest_node) = 0;     % distance of end node from end is zero

% Update the values of all grid pixels for distance from end
[X, Y] = meshgrid(1:ncols, 1:nrows);
xd = dest_coords(1);
yd = dest_coords(2);
distanceFromEnd = abs(X - yd) + abs(Y - xd);

image(1.5, 1.5, map);
grid on;                        
axis image;                     
drawnow;                        % Update figure

drawMapEveryTime = true;            % To see how nodes expand on the grid

while true                              % Create an infinite loop
    map(start_node) = 5;                % Mark start node on map
    map(dest_node) = 6;                 % Mark destination node on map
    
    if (drawMapEveryTime)
        image(1.5, 1.5, map);
        grid on;                       
        axis image;                     
        drawnow;                        
    end
    
    
    heuristicDist = distanceFromStart + distanceFromEnd;
    
    [min_dist, current] = min(heuristicDist(:));
    
    % Compute row, column coordinates of current node from linear index
    [i, j] = ind2sub(size(heuristicDist), current);
    
    % Create an exit condition for the infinite loop to end
    if ((current == dest_node) || isinf(min_dist))
        break
    end
    
    %----------------------------------------------------------------------
    %Diagonal approach, jump start/point search
    
    if ( ( i+1 <= nrows && j-1>=1 )&& distanceFromStart(i+1, j-1) > distanceFromStart(i,j) + 1)
        if (parent(i+1, j-1) == 0 && input_map(i+1,j-1)~=1 && parent(current)~= sub2ind(size(map), i+1, j-1))
            distanceFromStart(i+1, j-1) = distanceFromStart(i,j) + 1;
            map(sub2ind(size(map), i+1, j-1)) = 4;    % Mark the neighbour of current as processing
            parent(i+1, j-1)= current;
        end
    end
    
    if ( ( i+1 <= nrows && j+1<=ncols ) && distanceFromStart(i+1, j+1) > distanceFromStart(i,j) + 1)
        if (parent(i+1, j+1) == 0 && input_map(i+1,j+1)~=1 && parent(current)~= sub2ind(size(map), i+1, j+1))
            distanceFromStart(i+1, j+1) = distanceFromStart(i,j) + 1;
            map(sub2ind(size(map), i+1, j+1)) = 4;    % Mark the neighbour of current as processing
            parent(i+1, j+1)= current;
        end
    end
    
    if ( ( i-1 >= 1 && j-1>=1 )&& distanceFromStart(i-1, j-1) > distanceFromStart(i,j) + 1)
        if (parent(i-1, j-1) == 0 && input_map(i-1,j-1)~=1 && parent(current)~= sub2ind(size(map), i-1, j-1))
            distanceFromStart(i-1, j-1) = distanceFromStart(i,j) + 1;
            map(sub2ind(size(map), i-1, j-1)) = 4;    % Mark the neighbour of current as processing
            parent(i-1, j-1)= current;
        end
    end
    
    if ( ( i-1 >= 1 && j+1 <= ncols )&& distanceFromStart(i-1, j+1) > distanceFromStart(i,j) + 1)
        if (parent(i-1, j+1) == 0 && input_map(i-1,j+1)~=1 && parent(current)~= sub2ind(size(map), i-1, j+1))
            distanceFromStart(i-1, j+1) = distanceFromStart(i,j) + 1;
            map(sub2ind(size(map), i-1, j+1)) = 4;    % Mark the neighbour of current as processing
            parent(i-1, j+1)= current;
        end
    end
    
    
    
    %----------------------------------------------------------------------
    %Normal method 
    
    if (i+1 <= nrows && distanceFromStart(i+1, j) > distanceFromStart(i,j) + 1)
        if (parent(i+1, j) == 0 && input_map(i+1,j)~=1 && parent(current)~= sub2ind(size(map), i+1, j))
            distanceFromStart(i+1, j) = distanceFromStart(i,j) + 1;
            map(sub2ind(size(map), i+1, j)) = 4;    % Mark the neighbour of current as processing
            parent(i+1, j)= current;
        end
    end
    
    
    if (i-1 >= 1 && distanceFromStart(i-1, j) > distanceFromStart(i,j) + 1)
        if (parent(i-1, j) == 0 && input_map(i-1,j)~=1 && parent(current)~= sub2ind(size(map), i-1, j))
            distanceFromStart(i-1, j) = distanceFromStart(i,j) + 1;
            map(sub2ind(size(map), i-1, j)) = 4;    % Mark the neighbour of current as processing
            parent(i-1, j)= current;
        end
    end
    
    
    if (j-1 >= 1 && distanceFromStart(i, j-1) > distanceFromStart(i,j) + 1)
        if (parent(i, j-1) == 0 && input_map(i,j-1)~=1 && parent(current)~= sub2ind(size(map), i, j-1))
            distanceFromStart(i, j-1) = distanceFromStart(i,j) + 1;
            map(sub2ind(size(map), i, j-1)) = 4;    % Mark the neighbour of current as processing
            parent(i, j-1)= current;
        end
    end
    
  
    if (j+1 <= ncols && distanceFromStart(i, j+1) > distanceFromStart(i,j) + 1)
        if (parent(i, j+1) == 0 && input_map(i,j+1)~=1 && parent(current)~= sub2ind(size(map), i, j+1))
            distanceFromStart(i, j+1) = distanceFromStart(i,j) + 1;
            map(sub2ind(size(map), i, j+1)) = 4;    % Mark the neighbour of current as processing
            parent(i, j+1)= current;
        end
    end
    
    %----------------------------------------------------------------------
    
    distanceFromStart(current) = inf;   
    map(current) = 3;       
    numExpanded = numExpanded+1;
end

disp(numExpanded);

if (isinf(distanceFromStart(dest_node))) route = [];    
else route = [dest_node];                               
    while (parent(route(1)) ~= 0)                       % check front of route for start node
        route = [parent(route(1)), route];              % add parent of current node to front of route
    end
    
    for k = 2:length(route) - 1         
        map(route(k)) = 7;
        pause(0.1);                   
        image(1.5, 1.5, map);
        grid on;                        
        axis image;                     
    end
end
end