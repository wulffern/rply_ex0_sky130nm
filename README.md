
# RPLY_EX0_SKY130NM

# Who
Carsten Wulff

# Why
Example of flow with a current mirror

# Changelog/Plan
| Version | Status | Comment|
| :-| :-| :-|
|0.1.0 | :x: | Fix readme |
|0.2.0 | :x: | Made schematic |
|0.3.0 | :x: | Typical simulation |
|0.3.1 | :x: | Made simulation |
|0.4.0 | :x: | Made layout |
|0.5.0 | :x: | DRC/LVS clean|
|0.6.0 | :x: | Extracted parasitics|
|0.7.0 | :x: | Simulated parasitics |
|0.8.0 | :x: | Updated README with simulation results|
|1.0.0 | :x: | All done|


# How

## Initialize new IP 

``` bash
cicconf newip ex0

```

## Add remote

Create a repository with the same name on your choosen git vendor (for example [github](https://github.com))


``` bash
git remote add origin git@github.com:wulffern/rply_ex0_sky130nm.git
git branch -M main
git push -u origin main
```

## Fix README 

Open README.md in your favorite text editor and make necessary changes 


## Familiarize yourself with the Makefile and make

``` bash
cd work 
make 
```

## Draw schematic 

All commands (except simulation) must be started from work/

```
make xview
```

### Add Ports 
Add IBPS_4U and IBPS_20U ports, the P and N in the name signifies what
transistor the current comes from. So IBPS must go into a diode connected NMOS,
and N will be our output, and go into a diode connected PMOS somewhere else


### Add transistors 

Use 'Shift-I' to open the library manager. Use the "sky130B/libs.tech/xschem"
path. Open the "sky130_fd_pr" library. Find nfet_01v8.sym and place in your
schematic.


Select the transistor by clicking on it, press 'q' to bring up the properties. 
Set L=0.36, W=3.6, nf=2 and press OK.

Select the transistor and press 'c' to copy it, while dragging, press 'shift-f'
to flip the transistor so our current mirror looks nice. 'shift-r' rotates the
transistor, but we don't want that now. 

Press ESC to deselect everything 

Select ports, and use 'm' to move the ports close to the transistors.

Press 'w' to route wires.

Use 'shift-z' and z, to zoom in and out 

Use 'f' to zoom full screen 
 
Remember to save the schematic 


### Netlist schematic 

Check that the netlist looks OK 

In work/

``` bash
make xsch 
cat xsch/RPLY_EX0.spice
```


## Run simulation 
I've made [cicsim](https://github.com/wulffern/cicsim) that I use to run simulations (ngspice) and extract
results

## Setup simulation environment 
Navigate to the rply_ex0_sky130nm/sim/ directory.

Make a new simulation folder 

``` bash
cicsim simcell  RPLY_EX0_SKY130NM RPLY_EX0 ../tech/cicsim/simcell_template.yaml
```

## Familiarize yourself with the simulation folder 

I've added quite a few options to cicsim, and it might be confusing. For
reference, these are what the files are used for

| File         | Description                                       |
|--------------|---------------------------------------------------|
| Makefile     | Simulation commands                               |
| cicsim.yaml  | Setup for cicsim                                  |
| summary.yaml | Generate a README with simulation results         |
| tran.meas    | Measurement to be done after simulation           |
| tran.py      | Optional python script to run for each simulation |
| tran.spi     | Transient testbench                               |
| tran.yaml    | What measurements to summarize                                                   |


The default setup should run, so 

``` bash
cd RPLY_EX0
make typical
```

## Modify default testbench (tran.spi)

Delete the VDD source

Add a current source of 4uA, and a voltage source of 1V to IBNS_20U 

``` spice
IBP 0 IBPS_4U dc 4u
V0  IBNS_20U 0 dc 1
```

Add the current in V0 to the plots

## Modify measurements (tran.meas)

Add measurement of the current and VGS

``` spice
let ibn = -i(v0)
meas tran ibns_20u find ibn at=5n
meas tran vgs_m1 find v(ibps_4u) at=5n
```

Run simulation `make typical` and check that the output looks okish.

Often, it's the measurement that I get wrong, so instead of rerunning simulation every time 
I've added a "--no-run" option to cicsim. For example `make typical OPT="--no-run`, will skip the 
simulation, and rerun only the measurement. This is why you should split the testbench and the 
measurement. Simulations can run for days, but measurement takes seconds. 


You should notice that the current is not 20uA. We need to fix the schematic to make that happen.
Change the instance name of M2 to "M2[4:0]", and rerun typical simulation. Remember to save the schematic.

## Modify result specification (tran.yaml)

Add the result specifications, for example 

``` yaml
ibn:
  src:
    - ibns_20u
  name: Output current
  min: -20%
  typ: 20
  max: 20%
  scale: 1e6
  digits: 3
  unit: uA

vgs:
  src:
    - vgs_m1
  name: Gate-Source voltage
  typ: 0.6
  min: 0.3
  max: 0.7
  scale: 1
  digits: 3
  unit: V
```

Re-run the measurement and result generation `make typical OPT="--no-run"`

Open the result/tran_Sch_typical.html


## Check waveforms

Start Ngspice 

``` bash
ngspice 
```

Load the results, and view the vgs 

``` bash
load output_tran/tran_SchGtAttTtVt.raw
plot v(ibps_4u)
plot i(v0)
```

Based on the waveform we can see that maybe the voltage and current is not completely settled at 5 ns.

Change the measurement to 9.5ns





 
# What

| What      | Lib/Folder        | Cell/Name    |
|:----------|:-----------------:|:------------:|
| Schematic | RPLY_EX0_SKY130NM | RPLY_EX0.sch |
| Symbol    | RPLY_EX0_SKY130NM | RPLY_EX0.sym |
| Layout    | RPLY_EX0_SKY130NM | RPLY_EX0.mag |





# Signal interface
| Signal   | Direction | Domain  | Description        |
|:---------|:---------:|:-------:|:-------------------|
| IBPS_4U  | Input     | VDD_1V8 | Input bias current |
| IBNS_20U | Output    | VDD_1V8 | Output current     |
| VSS      | Input     | Ground  |                    |


# Key parameters
| Parameter   | Min | Typ             | Max | Unit |
|:------------|:---:|:---------------:|:---:|:----:|
| Technology  |     | Skywater 130 nm |     |      |
| AVDD        | 1.7 | 1.8             | 1.9 | V    |
| IBPS_20U    |     |                 |     | uA   |
| Temperature | -40 | 27              | 125 | C    |


# Status

| Stage                       | TYPE | Status | Comment                        |
| :---                        | :-:  | :---:  | :--:                           |
| Specification               | DOC  | :x:    |                                |
| Schematic                   | VIEW | :x:    |                                |
| Schematic simulation        | VER  | N/A    |                                |
| Layout                      | VIEW | :x:    |                                |
| Layout parasitic extraction | VIEW | :x:    |                                |
| LPE simulation              | VER  | :x:    |                                |
| LVS                         | VER  | :x:    |                                |
| DRC                         | VER  | :x:    |                                |
| ERC                         | VER  | :x:    |                                |
| ANT                         | VER  | :x:    |                                |
