# Thermal Analysis & Cooling Strategy for Tesla Model S Plaid Battery Pack

## Brief Overview
This project evaluates the thermal behavior of the 2022-23 Tesla Model S Plaid battery pack under various driving conditions, namely: highway cruise, supercharging and track mode. The vehicle utilizes an architecture of 7,920 Panasonic 18650 cells arranged in a 110S72P configuration to deliver a peak power of 1,020 hp. 
Using MATLAB, a lumped heat capacitance model was developed to simulate and compute the heat generated and therefore design a liquid cooling strategy capable of preventing thermal throttling during extreme track conditions.

## Methodology
The thermal response of the 479 kg battery pack was simulated using a lumped heat capacitance model. This approach assumes a uniform temperature distribution throughout the battery pack. START The primary source of heat generation was modeled as Joule heating originating from the internal resistance of the cells ($Q_{gen}=I^{2}\cdot R_{internal}$)[cite: 46, 47]. [cite_start]Heat rejection was governed by Newton's law of cooling ($Q_{cooling}=UA\cdot(T_{pack}-T_{coolant})$)[cite: 48, 49]. [cite_start]The fundamental energy balance equation states that the rate of change of internal energy is equal to the net heat generation minus heat removal[cite: 50]:

[cite_start]$$m\cdot C_{p}\cdot\frac{dT}{dt}=Q_{gen}-Q_{cooling}$$ [cite: 51]

## Simulation Results: Drive Modes
[cite_start]The MATLAB simulation evaluated the cumulative effect of heat generation versus heat rejection over a 30-minute drive cycle across three distinct scenarios[cite: 57, 66]:

* [cite_start]**Highway Cruise (120 kph):** At a constant 55 A load, heat generation was 115 W[cite: 69, 71, 72]. [cite_start]This resulted in a negligible temperature rise to 25.1°C[cite: 74, 111].
* [cite_start]**Supercharging (250 kW Peak):** Pulling 350 A generated a significant 4.66 kW of heat[cite: 77, 78, 79]. [cite_start]This requires adequate heat rejection to prevent significant heating, reaching 28.9°C in the simulation[cite: 80, 111].
* [cite_start]**Track Mode (Repeated Launches):** Operating at an estimated 1,000 A RMS, the pack generated 38.00 kW of waste heat[cite: 83, 84, 85]. [cite_start]Without adequate cooling, the pack rapidly approaches the thermal throttling limit of roughly 55°C[cite: 88].

*(Insert your MATLAB plot `thermal_plot.png` here)*


## Proposed Thermal Management System
[cite_start]To effectively counteract the 38 kW of heat generated in Track Mode, an active liquid cooling approach is proposed[cite: 116, 117]. 

* [cite_start]**Coolant:** A 50/50 Ethylene Glycol and Water (EGW) mixture was selected over forced air or direct refrigerant expansion[cite: 117, 120, 121].
* [cite_start]**Architecture:** The system utilizes vertical cooling ribbons in contact with each individual 18650 cell[cite: 133]. [cite_start]This geometry provides a large surface area for heat transfer and exploits the radial thermal conductivity of cylindrical cells[cite: 134, 135].
* [cite_start]**Flow Layout:** Parallel manifolds are utilized instead of a series configuration to ensure every module gets fresh EGW coolant at the same temperature[cite: 138, 139, 140].
* [cite_start]**Flow Rate:** To keep the temperature difference across the pack low (assumed 5°C), the required mass flow rate of the EGW coolant was calculated to be 2.21 kg/s (approximately 126 Liters/minute)[cite: 145, 146, 147].



## Files Included
* [cite_start]`docs/ProjectReport.pdf`: Comprehensive thermodynamic analysis and design strategy[cite: 5, 7].
* [cite_start]`src/thermal_simulation.m`: The MATLAB script utilized to calculate heat generation and plot the temperature vs time plot during different drive modes[cite: 59, 218].
