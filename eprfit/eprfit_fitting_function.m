function [result, fit_results] = eprfit_fitting_function(...
    x_values, y_values, variables, simulation_parameters, fit_parameters, ...
    fit_options)
% Fit epr spectrum using :func:`eprfit_simulation_function` and a
% gradient-based approach.
%
% Parameters
% ----------
% x_values : vector
%     x values
% y_values : vector
%     experimental y values that should be fitted by the model
% variables : vector
%     variable parameters to be fitted to the data
% simulation_parameters : struct
%     parameters used by :func:`eprfit_simulation_function` to actually
%     simulate the EPR spectrum
% fit_parameters : struct
%     ...
% fit_options : struct
%     ...
%
% Returns
% -------
% result : vector
%     parameters fitted
% fit_results : struct
%     further information about the fitting

simulation_function = @(variables, x_values)eprfit_simulation_function(...
    x_values, variables, simulation_parameters);

result = simulation_function(variables, x_values);

plot(x_values, result)

[result, resnorm, residual, exitflag, output, lambda, jacobian] = ...
    lsqcurvefit(simulation_function, variables, x_values, y_values, ...
    fit_parameters.lower_boundaries, fit_parameters.upper_boundaries, ...
    fit_options);

fit_results = struct(...
    'resnorm', resnorm, ...
    'residual', residual, ...
    'exitflag', exitflag, ...
    'output', output, ...
    'lambda', lambda, ...
    'jacobian', jacobian ...
    );

end