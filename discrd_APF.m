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
