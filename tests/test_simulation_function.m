function test_simulation_function()

x_values = linspace(340, 350, 2^10);

[Sys, Exp, Opt] = default_easyspin_parameters(x_values);

variables = [2.0023];
parameters = struct(...
    'routine', 'pepper', ...
    'Sys', Sys, ...
    'Exp', Exp, ...
    'Opt', Opt ...
    );
parameters.vary = {'Sys.g'};

simulation_function = @(x_values)eprfit.simulation_function(...
    x_values, variables, parameters);

result = simulation_function(x_values);

plot(x_values, result)

end