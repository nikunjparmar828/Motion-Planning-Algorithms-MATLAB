clf('reset');

cmap = [1 1 1;0 0 0;0 1 0;0 0 1;1 0 0;0.8 0.8 0.8];
colormap(cmap);


nrows = 3000;
ncols = 3000;

map = false(nrows, ncols);
[x, y] = meshgrid (1:ncols, 1:nrows);

% Generate some obstacles

% map (150:200, 200:250) = true;
% % map (300:end, 100:250) = true;
 map(2000:2500,1500:2000 ) = true;

%--------------------------------------------------------------------------
%Trapping for the local minima

% map (1:200, 280:300) = true;
% map (300:end, 280:300) = true;

%In this case due to the lcoal minimum value in between two meshes the
%robot will stuck into the local minimum value of the map.
% As we know in case of the voronoi's algorithm the robot stucks if the channel of the obstacle are there 
%

%--------------------------------------------------------------------------







d = bwdist(map);

% Rescale and transform distances

d2 = (d/100) + 1;

d0 = 2;
nu = 800;

repulsive = nu*((1./d2 - 1/d0).^2);



% figure(2);
% image(repulsive);
% grid on;
% axis image;


repulsive (d2 > d0) = 0;

% figure(3);
% image(repulsive);
% grid on;
% axis image;
% 


% figure;
% m = mesh (repulsive);
% m.FaceLighting = 'phong';
% axis equal;
% 
% title ('Repulsive Potential');

goal = [3500,5000];

xi = 1/700;

attractive = xi * ( (x - goal(1)).^2 + (y - goal(2)).^2 );

% figure;
% m = mesh (attractive);
% m.FaceLighting = 'phong';
% axis equal;
% 
% title ('Attractive Potential');


% figure;
% imshow(~obs);
% 
% hold on;
% plot (goal(1), goal(2), 'r.', 'MarkerSize', 25);
% hold off;
% 
% axis ([0 ncols 0 nrows]);
% axis xy;
% axis on;
% 
% xlabel ('x');
% ylabel ('y');
% 
% title ('Configuration Space');


f = attractive + repulsive;
% figure;
% m = mesh (f);
% m.FaceLighting = 'phong';
% axis equal;
% 
% title ('Total Potential');


% disp(attractive);
% disp(repulsive);
% disp(f);

start = [100,250]; 

route = GradientBasedPlanner (f, start, goal);

% disp(route);
% 
% image(1.5,1.5,map);
% axis image;
% axis xy;
% grid on;


[a,b] = size(route);

disp(route(1,:));

for k=2:a-1
%     rt_coords = route(k,:);
% %     disp(rt_coords(1));
% %     disp(rt_coords(2));
%     ind = sub2ind(size(map),floor(rt_coords(1)), floor(rt_coords(2)));
%     map(ind)=5;
%     image(1.5,1.5,map);
%     axis([0 nrows 0 ncols]);
%     grid on;
%     axis image;
% 
%     drawnow;
    
    figure;
    imshow(map);

    hold on;
    plot (rt_coords(1), rt_coords(2), 'r.', 'MarkerSize', 250);
    hold off;

    axis ([0 ncols 0 nrows]);
    axis xy;
    axis on;

    xlabel ('x');
    ylabel ('y');

    title ('Configuration Space');

end


