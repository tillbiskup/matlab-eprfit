function result = simulation_function(...
    x_values, variables, parameters, line_handle)
% Calculate EPR spectrum using EasySpin routines and providing an interface
% compatible to MATLAB Optimization Toolbox\ |trade| lsqcurvefit and alike.
% 
% Usage::
%
%   result = eprfit.simulation_function(x_values, variables, parameters)
%
%   result = eprfit-simulation_function(x_values, variables, parameters,...
%                                       line_handle)
%
% Parameters
% ----------
% x_values : vector
%     x values to calculate function values :math:`y = f(x)` for
%
% variables : vector
%     Variable parameters returned from optimisation routine
%
% parameters : struct
%    Full parameter set necessary for simulating the EPR spectrum
%    The parameters contained in the variables vector will be used 
%    accordingly.
%
% line_handle : handle
%    Optional parameter with handle for graphics object (line) whose ydata
%    should be replaced by the current simulation results. Plotting is only
%    done in case this parameter is supplied.
%
% Returns
% -------
% result : vector
%     function values :math:`y = f(x)`

% TODO: Perform input check on a higher level for speeding up
if ~input_is_ok(variables, parameters)
    error('Some problem with input...');
end

parameters = assign_variables_to_parameters(variables, parameters);
parameters = assign_x_values_to_parameters(x_values, parameters);
simulation_routine = str2func(parameters.routine);

result = simulation_routine(...
    parameters.Sys, parameters.Exp, parameters.Opt);

% In case fourth parameter is supplied, handled as line handle
if nargin > 3
    set(line_handle, 'YData', result);
    drawnow;
end

end


function result = input_is_ok(variables, parameters)

result = true;

if length(variables) ~= length(parameters.vary)
    result = false;
end

end


function parameters = assign_variables_to_parameters(variables, parameters)

for k = 1:length(variables)
    parameter_name = parameters.vary{k};
    parts = split(parameter_name, '.');
    if isscalar(parameters.(parts{1}).(parts{2}))
        parameters.(parts{1}).(parts{2}) = variables(k);
    else
        parameters.(parts{1}).(parts{2})(1) = variables(k);
    end
end

end


function parameters = assign_x_values_to_parameters(x_values, parameters)

parameters.Exp.Range = [min(x_values), max(x_values)];
parameters.Exp.nPoints = length(x_values);

end
