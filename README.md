
# RPLY\_EX0\_SKY130NM

# Who
Carsten Wulff

# Why
Example of flow with a current mirror

# Changelog/Plan
| Version | Status | Comment|
| :-| :-| :-|
|0.1.0 | :white_check_mark: | Fix readme |
|0.2.0 | :white_check_mark: | Made schematic |
|0.3.0 | :white_check_mark: | Typical simulation |
|0.4.0 | :white_check_mark: | Corner simulation |
|0.5.0 | :x: | Made layout |
|0.6.0 | :x: | DRC/LVS clean|
|0.7.0 | :x: | Extracted parasitics|
|0.8.0 | :x: | Simulated parasitics |
|0.9.0 | :x: | Updated README with simulation results|
|1.0.0 | :x: | All done|

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
| IBPS_20U    | 15  | 21              | 30  | uA   |
| Temperature | -40 | 27              | 125 | C    |


# Status

| Stage                       | TYPE | Status             | Comment |
|:----------------------------|:----:|:------------------:|:-------:|
| Specification               | DOC  | :white_check_mark: |         |
| Schematic                   | VIEW | :white_check_mark: |         |
| Schematic simulation        | VER  | :white_check_mark: |         |
| Layout                      | VIEW | :x:                |         |
| Layout parasitic extraction | VIEW | :x:                |         |
| LPE simulation              | VER  | :x:                |         |
| LVS                         | VER  | :x:                |         |
| DRC                         | VER  | :x:                |         |
| ERC                         | VER  | :x:                |         |
| ANT                         | VER  | :x:                |         |



# Getting Started 

## Initialize new IP 

``` bash
cd aicex/ip
cicconf newip ex0

```

## Add remote

Create a repository with the same name on your choosen git vendor (for example [github](https://github.com))


``` bash
cd rply_ex0_sky130nm
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

# Draw schematic 

All commands (except simulation) must be started from work/

```
cd work/
make xview
```

## Add Ports 
Add IBPS_4U and IBPS_20U ports, the P and N in the name signifies what
transistor the current comes from. So IBPS must go into a diode connected NMOS,
and N will be our output, and go into a diode connected PMOS somewhere else


## Add transistors 

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

![](documents/RPLY_EX0.svg)

## Netlist schematic 

Check that the netlist looks OK 

In work/

``` bash
make xsch 
cat xsch/RPLY_EX0.spice
```

# Run typical simulation 
I've made [cicsim](https://github.com/wulffern/cicsim) that I use to run simulations (ngspice) and extract
results

## Setup simulation environment 
Navigate to the rply_ex0_sky130nm/sim/ directory.

Make a new simulation folder 

``` bash
cicsim simcell  RPLY_EX0_SKY130NM RPLY_EX0 ../tech/cicsim/simcell_template.yaml
```

I would recommend you have a look at simcell_template.yaml file to understand what happens.

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

Run simulation

``` bash
make typical 
```
 and check that the output looks okish.

Often, it's the measurement that I get wrong, so instead of rerunning simulation every time 
I've added a "--no-run" option to cicsim. For example 

``` bash
make typical OPT="--no-run"
```


will skip the 
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

Re-run the measurement and result generation

``` bash
make typical OPT="--no-run"
```

Open  [result/tran_Sch_typical.html]([sim/RPLY_EX0/result/tran_Sch_typical.html])


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

Change the measurement to occur at 9.5ns

# Run Corner simulation 

All commands should be run in sim/RPLY_EX0

Analog circuits must be simulated for all physical conditions, we call them corners. 
We must check high and low temperature, high and low voltage, all process corners, and device-to-device mismatch.

For the current mirror we don't need to vary voltage, since we don't have a VDD. 

## Remove Vh and Vl corners (Makefile)
Open Makefile in your favorite text editor.

Change all instances of "Vt,Vl,Vh" and "Vl,Vh" to Vt


## Run all corners 
To simulate all corners do 

``` bash
make typical etc mc
```

where etc is extreme test condition and mc is monte-carlo.

Wait for simulations to complete.

## Modify measurements to check settling

Let's say we want to check if the current has settled in our transient. We could extract the current at 9.0 ns
and check that it's roughly the same. 

Add the following line to `tran.meas`

``` bash
meas tran ibns_20u_9n find ibn at=9n
```

And add the parameter to `tran.yaml`

``` yaml
ibn:
  src:
    - ibns_20u
    - ibns_20u_9n
```

Now, as you saw, the simulations take quite a while, so we don't want to rerun that.
Instead do

``` yaml
make typical etc mc OPT="--no-run"
```

## Get creative with python
If you're lazy, like me, then you don't want to spend time checking all the 9.5 ns numbers versus the 
9 ns numbers. I'd much rather tell the computer how to do that. 

It might be possible to do in ngspice, but sometimes a more complex tool is easier.

Open `tran.py` in your favorite editor, try to read and understand it.

The `name` parameter is the corner currently running, for example `tran_SchGtAmcttTtVt`.

The measured outputs from ngspice will be added to `tran_SchGtAmcttTtVt.yaml`

Delete the "return" line.

Add the following line 

``` yaml
# Do something to parameters
obj["ibn_settl_err"] = obj["ibns_20u"] - obj["ibns_20u_9n"]
```


Add the error to the result spec `tran.yaml`

``` yaml
err:
  src:
    - ibn_settl_err
  name: Current settling error
  typ: 0
  min: -2
  max: 2
  scale: 1e9
  digits: 3
  unit: nA
  
```

Re-run measurements to check the python code

``` yaml
make typical etc mc OPT="--no-run"
```

## Generate summary 

Run 

``` bash
make summary
```

Install [pandoc](https://pandoc.org) if you don't have it

Run

``` bash
pandoc -s  -t slidy README.md -o README.html
```

to generate a HTML slideshow that you can open in browser. Open the HTML file.


## Think about the results

From the corner and mismatch simulation, we can observe a few things.

- The typical value is not 20 uA. This is likely because we have a M2 VDS of 1 V, which is not the same
  as the VDS of M1. As such, the current will not be the same.
- The statistics from 30 corners show that when we add or subtract 3 standard deviation from the mean,
  the resulting current is outside our specification of +- 20 %. I'll leave it up to you to fix it.
 
 

 
 

