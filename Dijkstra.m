
function route = Dijkstra(input_map, start_coords, dest_coords)

%It'll set the color map for configuration space 

cmap = [1 1 1;0 0 0;0 1 0;0 0 1;1 0 0;0.8 0.8 0.8];
colormap(cmap);

[nrows, ncols] = size(input_map);

%--------------------------------------------------------------------------
map = zeros(nrows,ncols);

map(~input_map) = 1;  % Mark free cells
map(input_map)  = 2;  % Mark obstacle cells

% Converts coordinates of matrixes into indices of matrices 
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

%--------------------------------------------------------------------------

% Initialize distance array
dist_from_start = Inf(nrows,ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows,ncols);

dist_from_start(start_node) = 0;

    image(1.5, 1.5, map);
    grid on;
    axis image;
    drawnow;

% Main Loop
while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
%     image(1.5, 1.5, map);
%     grid on;
%     axis image;
%     drawnow;
    
    
    [min_dist, current] = min(dist_from_start(:));
    
    if ((current == dest_node) || isinf(min_dist))
        break;
    end;
    
   
    map(current) = 3;         
    dist_from_start(current) = Inf; 
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(dist_from_start), current);
    
    
    d = min_dist+1;
    p =current;

    %-------------------------------------------------------------------------
    %Testing for diagonal approach, jump start/point search 
    
    if i-1<1 || j-1<1
        amend(i,j,d,p);
    else
        amend(i-1,j-1,d,p);
    end
    
    if i+1>nrows || j+1>ncols
        amend(i,j,d,p);
    else
        amend(i+1,j+1,d,p);
    end
    
    if i-1<1 || j+1>ncols
        amend(i,j,d,p);
    else
        amend(i-1,j+1,d,p);
    end
    
    if i+1>nrows || j-1<1
        amend(i,j,d,p);
    else
        amend(i+1,j-1,d,p);
    end
    
    %-------------------------------------------------------------------------
    %Normal 
    
    if i-1<1
        amend(i,j,d,p);
    else
        amend(i-1,j,d,p);
    end
    
    if i+1>ncols
        amend(i,j,d,p);
    else
        amend(i+1,j,d,p);
    end
    
    if j-1<1
        
        amend(i,j,d,p);
    else
        amend(i,j-1,d,p);
    end
    
    if j+1>nrows
        
        amend(i,j,d,p);
    else
        amend(i,j+1,d,p);
    end 
   
    %----------------------------------------------------------------------
end



%Route display-------------------------------------------------------------
if (isinf(dist_from_start(dest_node)))
    route = [];
else
    route = [dest_node];
    
    while (parent(route(1)) ~= 0)
        
        route = [parent(route(1)), route];
        
    end
end


[a,b] = size(route);

for k=2:b-1
        map(route(k))=5;
        
        image(1.5,1.5,map);
        grid on;
        axis image;
        
end

%--------------------------------------------------------------------------
function amend (i,j,d,p)
    if ( (map(i,j) ~= 2) && (map(i,j) ~= 3) && (map(i,j) ~= 5) && (dist_from_start(i,j) > d) )
        dist_from_start(i,j) = d;
        map(i,j) = 4;
        parent(i,j) = p;
    end
end

end