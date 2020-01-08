function test_eprfit_fitting_function()

x_values = linspace(280, 410, 326);

%[Sys, Exp, Opt] = default_easyspin_parameters(x_values);
[Sys, Exp, Opt] = default_easyspin_parameters_triplet(x_values);

variables = [1200];
simulation_parameters = struct(...
    'routine', 'pepper', ...
    'Sys', Sys, ...
    'Exp', Exp, ...
    'Opt', Opt ...
    );
simulation_parameters.vary = {'Sys.D'};

result = eprfit_simulation_function(...
    x_values, variables, simulation_parameters);
result_noisy = addnoise(result, 50);

fit_parameters.lower_boundaries = [800];
fit_parameters.upper_boundaries = [1400];

fit_options = optimoptions('lsqcurvefit');
fit_options.FunctionTolerance = 1e-50;
fit_options.StepTolerance = 1e-50;
fit_options.OptimalityTolerance = 1e-50;
fit_options.MaxFunctionEvaluations = 200 * length(variables);
fit_options.CheckGradients = false;
%fit_options.FiniteDifferenceType = 'central';
fit_options.Display = 'iter';
%fit_options.Algorithm = 'levenberg-marquardt';

variables = [950];

[result_pars, fit_results] = eprfit_fitting_function(...
    x_values, result_noisy, variables, ...
    simulation_parameters, fit_parameters, fit_options);

Sys.D(1) = result_pars;
result_fitted = pepper(Sys,Exp,Opt);

plot(x_values, result_noisy, x_values, result_fitted, ...
    x_values, fit_results.residual)
legend({'noisy data', 'fitted data', 'residuals'})

end