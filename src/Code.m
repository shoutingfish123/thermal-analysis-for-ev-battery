
%% 1. Setup Parameters
Mass = 479;          % kg (Battery Mass)
Cp = 850;            % J/kg.K (Specific Heat Capacity)
R = 0.038;           % Ohms (Internal Resistance)
UA = 1200;           % Cooling Power (W/K)
T_amb = 25;          % Ambient Temp (deg C)

% Simulation Time (30 minutes)
time = 0:60:1800;    % Steps of 60 seconds

%% 2. Define Scenarios (Current & Cooling)
% Scenario 1: Highway Cruise (Steady 55 Amps)
I_cruise = 55;       
T_cool_cruise = 25;  % Passive Cooling (Ambient)

% Scenario 2: Supercharging (Avg 350 Amps)
I_charge = 350;      
T_cool_charge = 25;  % Active Cooling (Ambient)

% Scenario 3: Track Mode (RMS 1000 Amps)
I_track = 1000;      
T_cool_track = 15;   % Active CHILLER (Sub-ambient 15C)

%% 3. Calculate Heat Generation (Q = I^2 * R)
Q_cruise = I_cruise^2 * R;
Q_charge = I_charge^2 * R;
Q_track  = I_track^2  * R;

%% 4. Simulate Temperature Rise
T_cruise_plot = zeros(size(time)); 
T_charge_plot = zeros(size(time));
T_track_plot  = zeros(size(time));

% Set starting temps
T_cruise_plot(1) = T_amb;
T_charge_plot(1) = T_amb;
T_track_plot(1)  = T_amb;

for t = 2:length(time)
    % --- Cruise ---
    Q_removed = UA * (T_cruise_plot(t-1) - T_cool_cruise);
    T_cruise_plot(t) = T_cruise_plot(t-1) + (Q_cruise - Q_removed)*60 / (Mass*Cp);
    
    % --- Charge ---
    Q_removed = UA * (T_charge_plot(t-1) - T_cool_charge);
    T_charge_plot(t) = T_charge_plot(t-1) + (Q_charge - Q_removed)*60 / (Mass*Cp);
    
    % --- Track ---
    Q_removed = UA * (T_track_plot(t-1) - T_cool_track);
    T_track_plot(t) = T_track_plot(t-1) + (Q_track - Q_removed)*60 / (Mass*Cp);
end

%% 5. Plots and Output
figure('Color','w');
plot(time/60, T_cruise_plot, 'g-', 'LineWidth', 2); hold on;
plot(time/60, T_charge_plot, 'b-', 'LineWidth', 2);
plot(time/60, T_track_plot, 'r-', 'LineWidth', 2);
yline(55, 'k--', 'Safety Limit');

xlabel('Time (Minutes)');
ylabel('Battery Temp (°C)');
title('Model S Plaid: Thermal Response by Mode');
legend('Highway Cruise', 'Supercharging', 'Track Mode', 'Location', 'NorthWest');
grid on;

% PRINT RESULTS TABLE TO COMMAND WINDOW
fprintf('------------------------------------------------------------\n');
fprintf('| Scenario       | Current (A) | Heat Gen (kW) | Max Temp (C) |\n');
fprintf('|----------------|-------------|---------------|--------------|\n');
fprintf('| Highway Cruise | %4d A      | %5.2f kW      | %5.1f C      |\n', I_cruise, Q_cruise/1000, max(T_cruise_plot));
fprintf('| Supercharging  | %4d A      | %5.2f kW      | %5.1f C      |\n', I_charge, Q_charge/1000, max(T_charge_plot));
fprintf('| Track Mode     | %4d A      | %5.2f kW      | %5.1f C      |\n', I_track,  Q_track/1000,  max(T_track_plot));
fprintf('------------------------------------------------------------\n');