% Define the parameters
b = 10;
c = (b^2)/4;
Theta = 1;
% Define the exact solution
exact_solution = @(t) exp(-b*t/2) .* (1 + (b/2)*t);

% Define the system of first-order ODEs
f = @(t, y, u) u;
g = @(t, y, u) -b*u - c*y;

% Define the time steps for the Theta method
steps = [0.5, 0.05, 0.005];

% Loop over each time step and plot the solutions
for i = 1:3
    h = steps(i);
    t = 0:h:1;
    N = length(t);
    
    % Initialize arrays for the solutions
    y = zeros(1, N);
    u = zeros(1, N);
    
    % Set the initial conditions
    y(1) = 1;
    u(1) = 0;
    
    % Implement Theta method
    for n = 1:N-1
        y(n+1) = y(n) + h*(Theta*f(t(n), y(n), u(n))+(1-Theta)*f(t(n), y(n), u(n)));
        u(n+1) = u(n) + h*(Theta*g(t(n), y(n), u(n))+(1-Theta)*g(t(n), y(n), u(n)));
    end
    
    % Plot the numerical and exact solutions
    figure(i);
    plot(t, y, 'r', 'LineWidth', 1.5); % Numerical solution (red line)
    hold on;
    plot(t, exact_solution(t), 'b--', 'LineWidth', 1.5); % Exact solution (blue dashed line)
    xlabel('t');
    ylabel('y');
    legend('Numerical solution', 'Exact solution');
    title(['Theta method 0.5 with h = ', num2str(h)]);
    grid on;
    hold off;
end