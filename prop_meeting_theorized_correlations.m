% add U to 5th col, add expect relation to 6th col
[row,col] = near2(Lon,Lat,rp.lon,rp.lat);
idx = sub2ind(size(Umean),row,col);
rp.u = Umean(idx);  % U wind positive is westerly
rp.expectRelation = (rp.r<0 & rp.u>0) | (rp.r>0 & rp.u<0);

% 2. add is stable wind to data
u10p_isstab = stab_wind_prop >= prop;
rp.isUStab = u10p_isstab(idx);  % U wind positive is westerly

% 3. the sites in stable and unstable wind area
rp_stable = rp(rp.isUStab>0,:);
rp_unstable = rp(rp.isUStab==0,:);

p_succeed = sum(rp_stable.expectRelation)./size(rp_stable,1).*100;
p_failed = sum(rp_unstable.expectRelation)./size(rp_unstable,1).*100;

pz = [pz; chitest(size(rp_unstable,1),sum(rp_unstable.expectRelation),size(rp_stable,1),sum(rp_stable.expectRelation))];

y = [y; p_succeed,p_failed];