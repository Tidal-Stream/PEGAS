initSimulation
SpaceShuttle

site = createLaunchSite('Kennedy');

alt = 100;
inc = 51.65;
[lan, azm, target] = launchTargeting(site, alt, inc, 2.0);

stage1 = struct('type', 0, 'p', 8.5, 'v', 50, 'a', azm);

STS = flightManager(vehicle, site, target, 0.2, stage1, 2, 0);

telemetry(STS.powered, STS.coast, 1);
dbgIntegrals(STS.powered(2:STS.n), 2);
trajectory(STS.powered, STS.coast, target, 2, 1, 3);

fprintf('injection at t+%.1f into %.1fx%.1fkm orbit\n', max(STS.powered(STS.n).Plots.t), STS.powered(STS.n).Apoapsis, STS.powered(STS.n).Periapsis);
fprintf('angle %d\tecc %d\talt %d\n', planeError(STS, target), STS.powered(STS.n).Orbit.ECC, abs(alt-STS.powered(STS.n).Altitude));

clearvars site alt inc lan azm target stage1