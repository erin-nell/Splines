function [a,b,c,d] = not_a_knot_cubic_spline(x, y)
% Implements cubic spline interpolation with not-a-knot boundary conditions
n = length(x);
a = y(:);
h = diff(x);

% Set up right-hand side (b_RHS)
b_RHS = zeros(n,1);
for j = 2:n-1
    b_RHS(j) = 3/h(j)*(a(j+1) - a(j)) - 3/h(j-1)*(a(j) - a(j-1));
end

% Set up the tridiagonal matrix A
main_diag = zeros(n,1);
upper_diag = zeros(n-1,1);
lower_diag = zeros(n-1,1);

for j = 2:n-1
    main_diag(j) = 2*(h(j-1) + h(j));
    upper_diag(j) = h(j);
    lower_diag(j-1) = h(j-1);
end

% Not-a-knot conditions at first and last row
% First row (corresponds to x_1 = not-a-knot at x_2)
A = zeros(n);
A(1,1) = h(2);
A(1,2) = -(h(1)+h(2));
A(1,3) = h(1);

% Last row (not-a-knot at x_{n-1})
A(n,n) = h(n-2);
A(n,n-1) = -(h(n-1)+h(n-2));
A(n,n-2) = h(n-1);

% Fill the rest of A
for j = 2:n-1
    A(j,j-1) = h(j-1);
    A(j,j)   = 2*(h(j-1)+h(j));
    A(j,j+1) = h(j);
end

% Solve the linear system
c = A\b_RHS;

% Compute b and d coefficients
b = zeros(n-1,1); d = zeros(n-1,1);
for j = 1:n-1
    b(j) = 1/h(j)*(a(j+1) - a(j)) - h(j)/3*(2*c(j) + c(j+1));
    d(j) = (c(j+1) - c(j)) / (3*h(j));
end

% Trim a and c to match b and d
a = a(1:end-1); 
c = c(1:end-1);
