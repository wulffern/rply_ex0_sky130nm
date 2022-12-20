
# RPLY_EX0_SKY130NM

# Who
Carsten Wulff

# Why
Example of flow
 

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

 
# What

| What      | Lib/Folder        | Cell/Name    |
|:----------|:-----------------:|:------------:|
| Schematic | RPLY_EX0_SKY130NM | RPLY_EX0.sch |
| Symbol    | RPLY_EX0_SKY130NM | RPLY_EX0.sym |
| Layout    | RPLY_EX0_SKY130NM | RPLY_EX0.mag |



# Changelog/Plan
| Version | Status | Comment|
| :-| :-| :-|
|0.1.0 | :x: | Fix readme |
|0.2.0 | :x: | Made schematic |
|0.3.0 | :x: | Made simulation |
|0.4.0 | :x: | Made layout |
|0.5.0 | :x: | DRC/LVS clean|
|0.6.0 | :x: | Extracted parasitics|
|0.7.0 | :x: | Simulated parasitics |
|0.8.0 | :x: | Updated README with simulation results|
|1.0.0 | :x: | All done|


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
