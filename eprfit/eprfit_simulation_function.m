function result = eprfit_simulation_function(...
    x_values, variables, parameters)

if ~check_input(variables, parameters)
    error('Some problem with input...');
end

parameters = assign_variables_to_parameters(variables, parameters);
parameters = assign_xvalues_to_parameters(x_values, parameters);
simulation_routine = str2func(parameters.routine);

%parameters.Sys.D(1)

result = simulation_routine(...
    parameters.Sys, parameters.Exp, parameters.Opt);

plot(x_values, result);
drawnow;

end


function result = check_input(variables, parameters)

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


function parameters = assign_xvalues_to_parameters(xvalues, parameters)

parameters.Exp.Range = [min(xvalues), max(xvalues)];
parameters.Exp.nPoints = length(xvalues);

end
