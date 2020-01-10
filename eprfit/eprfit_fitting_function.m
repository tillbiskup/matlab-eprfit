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
%
% y_values : vector
%     experimental y values that should be fitted by the model
%
% variables : vector
%     variable parameters to be fitted to the data
%
% simulation_parameters : struct
%     full set of parameters used by :func:`eprfit_simulation_function` to
%     actually simulate the EPR spectrum
%
% fit_parameters : struct
%     parameters necessary for fitting, such as lower and upper boundaries
%
% fit_options : struct
%     options set for fitting algorithm
%
% Returns
% -------
% result : vector
%     parameters fitted
%
% fit_results : struct
%     further information about the fitting

result = eprfit_simulation_function(...
    x_values, variables, simulation_parameters);
residuals = y_values - result;

line_handles = plot(x_values, y_values, x_values, result,...
    x_values, residuals);
legend({'data', 'simulation', 'residuals'});
set(gca,'XLim',x_values([1, end]));
drawnow;
simulation_line_handle = line_handles(2);
residuals_line_handle = line_handles(3);

simulation_function = @(variables, x_values)eprfit_simulation_function(...
    x_values, variables, simulation_parameters, simulation_line_handle);

fit_options.OutputFcn = ...
    @(x,optimValues,state)show_residuals_iteratively(x,optimValues,state,...
    residuals_line_handle);

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

function stop = show_residuals_iteratively(~, optim_values, ~, line_handle)

stop = false;
set(line_handle, 'YData', optim_values.residual);

end