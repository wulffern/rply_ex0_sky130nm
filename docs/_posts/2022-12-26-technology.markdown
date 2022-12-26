---
layout: post
title: Technology
permalink: tech
categories: AIC
---

## Foundry
What the foundry needs to make an IC is a [GDSII](https://en.wikipedia.org/wiki/GDSII). This is an antiquated file format made back in the 1970's and it basically contains drawing of the different layers on a chip.

You could, if you were crazy enough, design your chip in the GDSII file format [^1], but that's too hard for almost all normal humans. So you need help, and that's where Electronic Design Automation (EDA) Tools come in. EDA tools try to assist you, more or less successfully, to create this GDSII file.

If you want to, then you can download [klayout](https://www.klayout.de) a GDSII file. 


## Electronic Design Automation (EDA)

Keep in mind that EDA software is made for a very small audience (thousands of people, not millions of people like linux, Office etc). That means that the tools might be buggy, are not necessarily easy to setup, and expensive. It's common for a IC design company to spend the same order of magntiude money on licenses for EDA tools as they do on salary. All EDA software is terrible, but some are useful.

To turn the EDA software into useful software they need to be setup for a particular technology, for example Global Foundries 130 nm BCD Lite, or Global Foundries 22 nm FDSOI (used by some of the master students at NTNU) or Skywater 130 nm.

The collection of setup files for the EDA software is usually referred to as the Process Design Kit (PDK). An interesting shift happened in 2020. Google teamed up with SkyWater (a foundry or factory) to release an open source PDK ([skywater-pdk](https://skywater-pdk.readthedocs.io/en/main/). Since then, a host of multi-project wafers have been taped out via [open_shuttle_program](https://efabless.com/open_shuttle_program). 


## Process Design Kit (PDK) 

Even the PDK can be quite daunting to use. For example, for a particular tool, Mentor Calibre Layout versus Schematic (calibre -lvs), you need to find the right setup file in the PDK , and set the options correctly for the right metal stack, and configure the file to run calibre. 

Even for an experienced person (like me) it can take me a few weeks to get the setup correct, especially since every foundry does their PDKs differently (Global Foundries versus TSMC), and I've even experienced two PDKs from the same foundary with completely different layout. This happens simply because there might be two different teams inside a behemoth like TSMC (50k+ employees) that make different technologies (65 nm vs 28 nm). 

As such, we have spent some time simplifying as much as we can and made a Technology setup that you will use to interface to the PDK, that is what the [tech_sky130B](https://github.com/wulffern/tech_sky130B). 

[^1]: Which is why I think Klayout is a bad idea for analog circuit design.