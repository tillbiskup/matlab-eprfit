function test_eprfit_fitting_function()

%x_values = linspace(280, 410, 326);
x_values = linspace(340, 350, 2^10);

[Sys, Exp, Opt] = default_easyspin_parameters(x_values);
%[Sys, Exp, Opt] = default_easyspin_parameters_triplet(x_values);

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
result_noisy = addnoise(result, 50);

%fit_parameters.lower_boundaries = [800];
%fit_parameters.upper_boundaries = [1400];
fit_parameters.lower_boundaries = [2.00];
fit_parameters.upper_boundaries = [2.01];

fit_options = optimoptions('lsqcurvefit');
fit_options.FunctionTolerance = 1e-50;
fit_options.StepTolerance = 1e-50;
fit_options.OptimalityTolerance = 1e-50;
fit_options.MaxFunctionEvaluations = 200 * length(variables);
fit_options.CheckGradients = false;
%fit_options.FiniteDifferenceType = 'central';
fit_options.Display = 'iter';
%fit_options.Algorithm = 'levenberg-marquardt';

%variables = [950];
variables = [2.0041];

[result_pars, fit_results] = eprfit_fitting_function(...
    x_values, result_noisy, variables, ...
    simulation_parameters, fit_parameters, fit_options);

%Sys.D(1) = result_pars;
Sys.g = result_pars;
result_fitted = pepper(Sys,Exp,Opt);

plot(x_values, result_noisy, x_values, result_fitted, ...
    x_values, fit_results.residual)
set(gca,'XLim',x_values([1, end]));
legend({'data', 'simulation', 'residuals'})

end