function route = GradientBasedPlanner (f, start_coords, end_coords)


[gx, gy] = gradient (-f);
% figure;
% mesh(f);
% title('f');
% 
% figure;
% mesh(-f);
% title('-f');
% 
% figure;
% mesh(gx);
% title('gx');
% figure;
% mesh(gy);
% title('gy');

route = start_coords;
current = start_coords;

while true
    
    delta = [gx( round(current(2)), round(current(1)) ), gy( round(current(2)), round(current(1)) )];

    g = delta/norm(delta);
    current = current + [g(1) g(2)];
%     disp(current);
    route = [route; current];
    
    if(norm(end_coords - current) < 2)
        break; 
    end
%     disp("All good");

end

end
