function gradf = GetGradient(drone,goal,obst,param)
gradf = GetAttractiveGradient(drone,goal,param)+GetRepulsiveGradient(drone,obst,param);

