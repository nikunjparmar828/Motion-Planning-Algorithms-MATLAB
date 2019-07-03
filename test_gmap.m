[XX YY M Mcolor] = get_google_map(26.0342425, -80.1154781);
imagesc(XX,YY,M);
shading flat;
colormap(Mcolor);
xlabel('Eastings UTM');
ylabel('Northings UTM'); 
title('Sea Tech');