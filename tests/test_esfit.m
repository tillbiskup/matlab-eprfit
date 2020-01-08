function test_esfit()

x_values = linspace(340, 350, 2^10);

[Sys, Exp, Opt] = default_easyspin_parameters(x_values);

variables = [2.0023];
simulation_parameters = struct(...
    'routine', 'pepper', ...
    'Sys', Sys, ...
    'Exp', Exp, ...
    'Opt', Opt ...
    );
simulation_parameters.vary = {'Sys.g'};

result = eprfit_simulation_function(...
    x_values, variables, simulation_parameters);
result_noisy = addnoise(result, 100);

Sys.g = 2.0045;
Vary.g = [0.01]

esfit(simulation_parameters.routine,result_noisy,Sys,Vary,Exp)

end