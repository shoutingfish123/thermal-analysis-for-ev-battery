# Thermal Analysis & Cooling Strategy for Tesla Model S Plaid Battery Pack
![MATLAB](https://img.shields.io/badge/MATLAB-R2024b-orange)

## Brief Overview
This mini project evaluates the thermal behavior of the 2022-23 Tesla Model S Plaid battery pack under various driving conditions, namely: highway cruise, charging and track mode. The vehicle utilizes an architecture of 7,920 Panasonic 18650 cells arranged in a 110S72P configuration to deliver a peak power of 1,020 hp. 
Using MATLAB, a lumped heat capacitance model was developed to simulate and compute the heat generated and therefore design a liquid cooling strategy capable of preventing thermal throttling during extreme track conditions. This mini project was done in fulfilment of ME F317: Engines, Motors and Mobility, a course offered at BITS Pilani.

## Methodology
The thermal response of the 479 kg battery pack was simulated using a lumped heat capacitance model. This approach assumes a uniform temperature distribution throughout the battery pack. The primary source of heat generation was modeled as Joule heating originating from the internal resistance of the cells ($Q_{gen}=I^{2}\cdot R_{internal. Heat rejection was governed by Newton's law of cooling ($Q_{cooling}=UA\cdot(T_{pack}-T_{coolant})$). The fundamental energy balance equation states that the rate of change of internal energy is equal to the net heat generation minus heat removal:

$$m\cdot C_{p}\cdot\frac{dT}{dt}=Q_{gen}-Q_{cooling}$$ 

## Simulation
The MATLAB simulation evaluated the cumulative effect of heat generation versus heat rejection over a 30-minute drive cycle across three distinct drive conditions by plotting a temperature vs time graph using the following discretized equation:

$$T_{new} = T_{old} + \frac{(Q_{gen} - Q_{cooling}) \cdot dt}{m \cdot C_p}$$

### Parameters
| Parameter | Symbol | Value | Unit | Source |
| :--- | :--- | :--- | :--- | :--- |
| **Pack Mass** | $m$ | 479 | kg | Verified from parts catalog (Cells + Modules) |
| **Specific Heat** | $C_p$ | 850 | J/kg·K | Weighted average for NCA cylindrical cells |
| **Pack Resistance** | $R$ | 0.038 | Ω | Derived from cell configuration: (0.025 × 110) / 72 |
| **Cooling Coefficient** | $UA$ | 1200 | W/K | Estimated heat transfer capability |
| **Initial Temperature** | $T_{0}$ | 25 | °C | Assumed initial temperature |

### Results
* **Highway Cruise (120 kph):** At a constant 55 A load (assumed a constant), heat generation was 115 W. This resulted in a negligible temperature rise to 25.1°C.
* **Charging (250 kW Peak):** Pulling 350 A generated a significant 4.66 kW of heat. This requires adequate heat rejection to prevent significant heating, reaching 28.9°C in the simulation.
* **Track Mode (Agressive driving):** Operating at an estimated 1,000 A RMS, the pack generated 38.00 kW of heat. Since this drive mode generates the most amount of heat, it is the critical desgin case for the cooling system.

<p align="center">
  <img src="images/Temp vs Time.jpg" width="700">
  <br>
  <em>Figure 1: The temperatures for all drive modes saturate after some time thereby achieving steady state</em>
</p>

## Proposed Thermal Management System
To effectively counteract the 38 kW of heat generated in Track Mode, an active liquid cooling approach is proposed. 

* **Coolant:** A 50/50 Ethylene Glycol and Water (EGW) mixture was selected over forced air or direct refrigerant expansion.
* **Architecture:** The system utilizes vertical cooling ribbons in contact with each individual 18650 cell. This geometry provides a large surface area for heat transfer and exploits the radial thermal conductivity of cylindrical cells.
* **Flow Layout:** Parallel manifolds are utilized instead of a series configuration to ensure every module gets fresh EGW coolant at the same temperature.
* **Flow Rate:** To keep the temperature difference across the pack low (assume 5°C), the required mass flow rate of the EGW coolant was calculated to be 2.21 kg/s.

## Repository Structure

```text
tesla-battery-thermal-analysis/
│
├── README.md                
├── docs/
│   └── ProblemStatement.pdf  # ME F317 problem statement and context 
│   └── ProjectReport.pdf     # Mini project report
├── src/
│   └── thermal_simulation.m  # MATLAB script for heat generation and temperature simulation
└── images/
    ├── Temp vs Time.png      # Temperature vs Time MATLAB plot
