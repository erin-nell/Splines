% Dataset
x = linspace(0, 10, 6);
y = x.^3;  % or: sin(x), abs(x-5)

xq = linspace(min(x), max(x), 1000);  % Fine grid for interpolation

% Evaluate built-in splines
spline_builtin = spline(x, y, xq);
pchip_builtin = pchip(x, y, xq);
makima_builtin = makima(x, y, xq);

% csaps
csaps_fn = csaps(x, y);
csaps_builtin = fnval(csaps_fn, xq);

% spaps
[spaps_fn, ~] = spaps(x, y, 1e-6);
spaps_builtin = fnval(spaps_fn, xq);

% slmengine
slm = slmengine(x, y, 'plot', 'off');
slm_builtin = slmeval(xq, slm);


% Plotting
figure;
plot(x, y, 'ko', 'DisplayName', 'Data Points', 'LineWidth', 2); hold on;
plot(xq, xq.^3, 'k-', 'DisplayName', 'x^3', 'LineWidth', 2); % Actual x^3 plot
plot(xq, spline_builtin, 'r-', 'DisplayName', 'spline (built-in)', 'LineWidth', 2);
plot(xq, pchip_builtin, 'g-', 'DisplayName', 'pchip', 'LineWidth', 2);
plot(xq, makima_builtin, 'b-', 'DisplayName', 'makima', 'LineWidth', 2);
plot(xq, csaps_builtin, 'm--', 'DisplayName', 'csaps', 'LineWidth', 2);
plot(xq, spaps_builtin, 'c-', 'DisplayName', 'spaps', 'LineWidth', 2);
plot(xq, slm_builtin, 'y-', 'DisplayName', 'slmengine', 'LineWidth', 2);
xlabel('x'); ylabel('y');
title('Spline Interpolation Built-In Comparison, x^3');
legend('Location', 'northwest');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dataset
x = linspace(0, 10, 6);
y = abs(x - 5);  % Change to |x - 5|

xq = linspace(min(x), max(x), 1000);  % Fine grid for interpolation

% Evaluate built-in splines
spline_builtin = spline(x, y, xq);
pchip_builtin = pchip(x, y, xq);
makima_builtin = makima(x, y, xq);

% csaps (smoothing spline with default smoothing parameter)
csaps_fn = csaps(x, y);  % returns a fn
csaps_builtin = fnval(csaps_fn, xq);

% spaps (smoothing spline with small tolerance)
[spaps_fn, ~] = spaps(x, y, 1e-6);
spaps_builtin = fnval(spaps_fn, xq);

% slmengine (shape-preserving piecewise spline)
% Requires Curve Fitting Toolbox: download from MATLAB File Exchange if needed
slm = slmengine(x, y, 'plot', 'off');
slm_builtin = slmeval(xq, slm);

% Your custom not-a-knot spline
[a, b, c, d] = not_a_knot_cubic_spline(x, y);
yq_custom = zeros(size(xq));
for i = 1:length(xq)
    xi = xq(i);
    idx = find(xi >= x, 1, 'last');
    if idx >= length(x), idx = length(x)-1; end
    dx = xi - x(idx);
    yq_custom(i) = a(idx) + b(idx)*dx + c(idx)*dx^2 + d(idx)*dx^3;
end

% Plotting
figure;
plot(x, y, 'ko', 'DisplayName', 'Data Points', 'LineWidth', 2); hold on;
plot(xq, abs(xq - 5), 'k-', 'DisplayName', '|x - 5|', 'LineWidth', 2); 
plot(xq, spline_builtin, 'r-', 'DisplayName', 'spline (built-in)', 'LineWidth', 2);
plot(xq, pchip_builtin, 'g-', 'DisplayName', 'pchip', 'LineWidth', 2);
plot(xq, makima_builtin, 'b-', 'DisplayName', 'makima', 'LineWidth', 2);
plot(xq, csaps_builtin, 'm--', 'DisplayName', 'csaps', 'LineWidth', 2);
plot(xq, spaps_builtin, 'c--', 'DisplayName', 'spaps', 'LineWidth', 2);
plot(xq, slm_builtin, 'y-', 'DisplayName', 'slmengine', 'LineWidth', 2);
xlabel('x'); ylabel('y');
title('Spline Interpolation Methods Comparison for |x - 5|');
legend('Location', 'northwest');
grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dataset
x = linspace(0, 10, 6);
y = sin(x);  % Change to sin(x)

xq = linspace(min(x), max(x), 1000);  % Fine grid for interpolation

% Evaluate built-in splines
spline_builtin = spline(x, y, xq);
pchip_builtin = pchip(x, y, xq);
makima_builtin = makima(x, y, xq);

% csaps (smoothing spline with default smoothing parameter)
csaps_fn = csaps(x, y);  % returns a fn
csaps_builtin = fnval(csaps_fn, xq);

% spaps (smoothing spline with small tolerance)
[spaps_fn, ~] = spaps(x, y, 1e-6);
spaps_builtin = fnval(spaps_fn, xq);

% slmengine (shape-preserving piecewise spline)
% Requires Curve Fitting Toolbox: download from MATLAB File Exchange if needed
slm = slmengine(x, y, 'plot', 'off');
slm_builtin = slmeval(xq, slm);

% Your custom not-a-knot spline
[a, b, c, d] = not_a_knot_cubic_spline(x, y);
yq_custom = zeros(size(xq));
for i = 1:length(xq)
    xi = xq(i);
    idx = find(xi >= x, 1, 'last');
    if idx >= length(x), idx = length(x)-1; end
    dx = xi - x(idx);
    yq_custom(i) = a(idx) + b(idx)*dx + c(idx)*dx^2 + d(idx)*dx^3;
end

% Plotting
figure;
plot(x, y, 'ko', 'DisplayName', 'Data Points', 'LineWidth', 2); hold on;
plot(xq, spline_builtin, 'r-', 'DisplayName', 'spline (built-in)', 'LineWidth', 2);
plot(xq, pchip_builtin, 'g-', 'DisplayName', 'pchip', 'LineWidth', 2);
plot(xq, makima_builtin, 'b-', 'DisplayName', 'makima', 'LineWidth', 2);
plot(xq, csaps_builtin, 'm--', 'DisplayName', 'csaps', 'LineWidth', 2);
plot(xq, spaps_builtin, 'c--', 'DisplayName', 'spaps', 'LineWidth', 2);
plot(xq, slm_builtin, 'y-', 'DisplayName', 'slmengine', 'LineWidth', 2);
xlabel('x'); ylabel('y');
title('Spline Interpolation Methods Comparison for sin(x)');
legend('Location', 'northwest');
grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dataset
x = linspace(0, 10, 6);
y = sin(x);  % Change to sin(x)

xq = linspace(min(x), max(x), 1000);  % Fine grid for interpolation

% Evaluate built-in splines
spline_builtin = spline(x, y, xq);
pchip_builtin = pchip(x, y, xq);
makima_builtin = makima(x, y, xq);

% csaps (smoothing spline with default smoothing parameter)
csaps_fn = csaps(x, y);  % returns a fn
csaps_builtin = fnval(csaps_fn, xq);

% spaps (smoothing spline with small tolerance)
[spaps_fn, ~] = spaps(x, y, 1e-6);
spaps_builtin = fnval(spaps_fn, xq);

% slmengine (shape-preserving piecewise spline)
% Requires Curve Fitting Toolbox: download from MATLAB File Exchange if needed
slm = slmengine(x, y, 'plot', 'off');
slm_builtin = slmeval(xq, slm);

% Your custom not-a-knot spline
[a, b, c, d] = not_a_knot_cubic_spline(x, y);
yq_custom = zeros(size(xq));
for i = 1:length(xq)
    xi = xq(i);
    idx = find(xi >= x, 1, 'last');
    if idx >= length(x), idx = length(x)-1; end
    dx = xi - x(idx);
    yq_custom(i) = a(idx) + b(idx)*dx + c(idx)*dx^2 + d(idx)*dx^3;
end

% Plotting
figure;
plot(x, y, 'ko', 'DisplayName', 'Data Points', 'LineWidth', 2); hold on;
plot(xq, sin(xq), 'k-', 'DisplayName', 'sin(x)', 'LineWidth', 2);  % Actual sine plot
plot(xq, spline_builtin, 'r-', 'DisplayName', 'spline (built-in)', 'LineWidth', 2);
plot(xq, pchip_builtin, 'g-', 'DisplayName', 'pchip', 'LineWidth', 2);
plot(xq, makima_builtin, 'b-', 'DisplayName', 'makima', 'LineWidth', 2);
plot(xq, csaps_builtin, 'm--', 'DisplayName', 'csaps', 'LineWidth', 2);
plot(xq, spaps_builtin, 'c--', 'DisplayName', 'spaps', 'LineWidth', 2);
plot(xq, slm_builtin, 'y-', 'DisplayName', 'slmengine', 'LineWidth', 2);
xlabel('x'); ylabel('y');
title('Spline Interpolation Methods Comparison for sin(x)');
legend('Location', 'northwest');
grid on;
