clf('reset');
cmap = [1 1 1; 1 0 0;0 1 1;0 0 1;0 0 0;1 0 1];
colormap(cmap);


nrows = 400;
ncols = 600;

obs = false(nrows, ncols);

[x, y] = meshgrid (1:ncols, 1:nrows);

% Generate some obstacles

% obs (1:200, 100:250) = true;
% obs (300:end, 100:250) = true;


%--------------------------------------------------------------------------
%Trapping for the local minima

% obs (1:200, 280:300) = true;
% obs (300:end, 280:300) = true;

%In this case due to the lcoal minimum value in between two meshes the
%robot will stuck into the local minimum value of the map.
% As we know in case of the voronoi's algorithm the robot stucks if the channel of the obstacle are there 
%

%--------------------------------------------------------------------------



t = ((x - 200).^2 + (y - 50).^2) < 50^2;
% disp(t);
obs(t) = true;                                                                                                                                                                                                                                                                                                                                                                                                                              

t = ((x - 400).^2 + (y - 300).^2) < 100^2;
obs(t) = true;

% figure(1);
% image(obs);
% grid on;
% axis image


%% Compute distance transform

d = bwdist(obs);

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


%% Display repulsive potential

figure;
m = mesh (repulsive);
m.FaceLighting = 'phong';
axis equal;

title ('Repulsive Potential');

%% Compute attractive force

goal = [400, 50];

xi = 1/700;

attractive = xi * ( (x - goal(1)).^2 + (y - goal(2)).^2 );

figure;
m = mesh (attractive);
m.FaceLighting = 'phong';
axis equal;

title ('Attractive Potential');

%% Display 2D configuration space

figure;
imshow(~obs);

hold on;
plot (goal(1), goal(2), 'r.', 'MarkerSize', 25);
hold off;

axis ([0 ncols 0 nrows]);
axis xy;
axis on;

xlabel ('x');
ylabel ('y');

title ('Configuration Space');

%% Combine terms

f = attractive + repulsive;

figure;
m = mesh (f);
m.FaceLighting = 'phong';
axis equal;

title ('Total Potential');


disp(attractive);
disp(repulsive);
disp(f);

%% Plan route
start = [100,250]; 

route = GradientBasedPlanner (f, start, goal);

%% Plot the energy surface

figure;
m = mesh (f);
axis equal;

%% Plot ball sliding down hill

% [sx, sy, sz] = sphere(20);
% 
% scale = 20;
% sx = scale*sx;
% sy = scale*sy;
% sz = scale*(sz+1);
% 
% hold on;
% p = mesh(sx, sy, sz);
% p.FaceColor = 'red';
% p.EdgeColor = 'none';
% p.FaceLighting = 'phong';
% hold off;
% 
% for i = 1:size(route,1)
%     P = round(route(i,:));
%     z = f(P(2), P(1));
%     
%     p.XData = sx + P(1);
%     p.YData = sy + P(2);
%     p.ZData = sz + f(P(2), P(1));
%     
%     drawnow;
%     
%     drawnow;
%     
% end

%% quiver plot
[gx, gy] = gradient (-f);
skip = 20;

figure;

xidx = 1:skip:ncols;
yidx = 1:skip:nrows;

quiver (x(yidx,xidx), y(yidx,xidx), gx(yidx,xidx), gy(yidx,xidx), 0.4);

axis ([1 ncols 1 nrows]);

hold on;

ps = plot(start(1), start(2), 'r.', 'MarkerSize', 30);
pg = plot(goal(1), goal(2), 'g.', 'MarkerSize', 30);
p3 = plot (route(:,1), route(:,2), 'r', 'LineWidth', 2);
