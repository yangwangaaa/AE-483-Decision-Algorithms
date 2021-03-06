function [x_des, y_des, z_des, yaw_des] = planner(x,t)
%% Planner
% current = [x(1); x(2); x(3)];
% goal = [2;0;-1];
% tgoal = 3;
% for i = 1:3
%     if abs(current(i)-goal(i))>0.5
%         des(i) = current(i)+(goal(i)-current(i))*(t/tgoal);
%     else
%         des(i)= goal(i);
%     end
% end
% x_des = des(1);
% y_des = des(2);
% z_des = des(3);
% yaw_des = 0;

% x_des = 2;
% y_des = 0;
% z_des = -1;

%% Set parameters
dt = 0.01;
param.katt = 100;
param.batt = 1;
param.dt = dt;

param.kdescent = 1;
param.bdescent = 1;
% Set goal position
goal.q = [2; 0; -1];
obst = {};
p = [1 0 -.8]';
s = .1;

obst = AddObstacle_Sphere(obst,p,s);

drone.r = .2;
param.krep = 1;
param.brep = .2;




%% Attractive Function
drone.q = x(1:3);
gradf = GetGradient(drone,goal,obst,param);
dq = -param.dt*param.kdescent*gradf;
dqnorm = norm(dq);
if (dqnorm>param.bdescent)
    dq = -param.bdescent*(gradf/norm(gradf));
end

x_nom = x(1:3) + dq';

x_des = x_nom(1);
y_des = x_nom(2);
z_des = x_nom(3);
yaw_des = 0;

end

function obst = AddObstacle_Sphere(obst,p,s)
onew.type = 1;
onew.p = p;
onew.s = s;
onew.v = [0;0;0];
obst{end+1}=onew;
end