datasets = {
    {@sin, 'sin(x)'},
    {@(x) x.^3, 'x^3'},
    {@(x) abs(x - 5), '|x - 5|'}
};

x_nodes = linspace(0, 10, 6);  % Interpolation points
x_fine = linspace(0, 10, 1000);  % grid for error analysis

clamped_deriv = {@(f, x) cos(x), @(f, x) 3*x.^2, @(f, x) sign(x - 5)};

for i = 1:length(datasets)
    f = datasets{i}{1};
    fname = datasets{i}{2};

    y_nodes = f(x_nodes);
    y_true = f(x_fine);

    spline_builtin = spline(x_nodes, y_nodes, x_fine);
    pchip_builtin = pchip(x_nodes, y_nodes, x_fine);
    makima_builtin = makima(x_nodes, y_nodes, x_fine);

    % csaps 
    csaps_fn = csaps(x_nodes, y_nodes);  % returns a fn
    csaps_builtin = fnval(csaps_fn, x_fine);

    % spaps
    [spaps_fn, ~] = spaps(x_nodes, y_nodes, 1e-6);
    spaps_builtin = fnval(spaps_fn, x_fine);

    % slmengine 
    slm = slmengine(x_nodes, y_nodes, 'plot', 'off');
    slm_builtin = slmeval(x_fine, slm);

    % Error analysis
    err_spline = max(abs(y_true - spline_builtin));
    err_pchip = max(abs(y_true - pchip_builtin));
    err_makima = max(abs(y_true - makima_builtin));
    err_csaps = max(abs(y_true - csaps_builtin));
    err_spaps = max(abs(y_true - spaps_builtin));
    err_slm = max(abs(y_true - slm_builtin));

    fprintf('Function: %s\n', fname);
    fprintf('  Spline (built-in) Max Error: %.3e\n', err_spline);
    fprintf('  PCHIP Max Error: %.3e\n', err_pchip);
    fprintf('  MAKIMA Max Error: %.3e\n', err_makima);
    fprintf('  CSAPS Max Error: %.3e\n', err_csaps);
    fprintf('  SPAPS Max Error: %.3e\n', err_spaps);
    fprintf('  SLM Max Error: %.3e\n\n', err_slm);
end