function result = eprfit_simulation_function(...
    x_values, variables, parameters)

if ~input_is_ok(variables, parameters)
    error('Some problem with input...');
end

parameters = assign_variables_to_parameters(variables, parameters);
parameters = assign_x_values_to_parameters(x_values, parameters);
simulation_routine = str2func(parameters.routine);

result = simulation_routine(...
    parameters.Sys, parameters.Exp, parameters.Opt);

plot(x_values, result);
drawnow;

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
