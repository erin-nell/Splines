datasets = {
    {@sin, 'sin(x)'},
    {@(x) x.^3, 'x^3'},
    {@(x) abs(x - 5), '|x - 5|'}
};

x = linspace(0, 10, 6); % Data nodes
xq = linspace(min(x), max(x), 200); % Query points for plotting

for k = 1:length(datasets)
    f = datasets{k}{1};
    label = datasets{k}{2};
    y = f(x);

    % Call your not-a-knot cubic spline function
    [a, b, c, d] = not_a_knot_cubic_spline(x, y);
    
    % Evaluate spline at query points
    yq = zeros(size(xq));
    for i = 1:length(xq)
        xi = xq(i);
        idx = find(xi >= x, 1, 'last');
        if idx >= length(x), idx = length(x)-1; end
        dx = xi - x(idx);
        yq(i) = a(idx) + b(idx)*dx + c(idx)*dx^2 + d(idx)*dx^3;
    end

    % Plot
    figure;
    plot(x, y, 'ko', 'MarkerFaceColor','k', 'DisplayName', 'Data Points'); hold on;
    plot(xq, yq, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Not-a-Knot Spline');
    title(['Not-a-Knot Spline: ', label]);
    xlabel('x'); ylabel('y');
    legend('Location','best'); grid on;
end