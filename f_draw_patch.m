function ret = f_draw_patch(x0, y0, R, a, b, theta)
% FOR EXAMPLE CALL LIKE THAT:
% x0 = 0; y0 = 0;     % circle centre
% R = 3;              % radius of the circle
% a = 1;              % width, perpedincular to the radius
% b = 5;              % length, colinear with the radius
% theta = 5*pi/4;     % "angle" of the rectangle
% clear f_draw_patch
% for theta = 0:pi/64:2*pi
%     f_draw_patch(x0, y0, R, a, b, theta);
%     pause(0.01);
% end
    
    delta_angle = 2 * asin((a/2)/R) - 2*pi;  % kąt jaki zajmuje łuk na okręgu
    
    % Arc angle from theta1 to theta2 
    theta1 = theta - delta_angle/2;
    theta2 = theta + delta_angle/2;
    
    % Calculate the circle points, 50 of them
    t_arc = linspace(theta1, theta2, 50);
    x_arc = x0 + R * cos(t_arc);
    y_arc = y0 + R * sin(t_arc);
    
    % calculate the angle of the radial vector
    radial = [cos(theta), sin(theta)];
    tangent = [-sin(theta), cos(theta)];
    
    % Calculate the intersection points with the rectangle
    P1 = [x0 + R * cos(theta1), y0 + R * sin(theta1)];
    P2 = [x0 + R * cos(theta2), y0 + R * sin(theta2)];
    
    % Calculate other two points of the rectangle
    P3 = P2 - b * radial;
    P4 = P1 - b * radial;
    
    % Build the contour, start with the arc next add points
    x_combined = [x_arc, P3(1), P4(1)];
    y_combined = [y_arc, P3(2), P4(2)];
    
    % Close the contour (final element same as the first)
    x_combined(end+1) = x_arc(1);
    y_combined(end+1) = y_arc(1);
    
    persistent fig;
    if isempty(fig)
        fig = figure; hold on; axis equal; grid on;
    end
    persistent ax;
    if isempty(ax)
        ax = patch(x_combined, y_combined, [0.8 0.2 0.2], 'FaceAlpha', 0.6);
    else
        set(ax, 'XData', x_combined, 'YData', y_combined);
    end

    % additional points
    persistent ax_pendulum_center
    if isempty(ax_pendulum_center)
        ax_pendulum_center = plot(x0, y0, 'ko', 'MarkerFaceColor', 'k');
    else
        set(ax_pendulum_center, 'XData', x0, 'YData', y0);
    end
    % plot([P1(1) P2(1)], [P1(2) P2(2)], 'go', 'MarkerFaceColor', 'g');
    % plot([P3(1) P4(1)], [P3(2) P4(2)], 'bo', 'MarkerFaceColor', 'b');
    ret = fig;

end

