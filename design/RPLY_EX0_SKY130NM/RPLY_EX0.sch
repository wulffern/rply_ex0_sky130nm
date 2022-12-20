v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -180 -370 -100 -370 {
lab=IBPS_4U}
N -220 -340 -60 -340 {
lab=VSS}
N -250 -370 -220 -370 {
lab=VSS}
N -250 -370 -250 -340 {
lab=VSS}
N -250 -340 -220 -340 {
lab=VSS}
N -60 -370 -30 -370 {
lab=VSS}
N -30 -370 -30 -340 {
lab=VSS}
N -60 -340 -30 -340 {
lab=VSS}
N -370 -440 -220 -440 {
lab=IBPS_4U}
N -220 -440 -220 -400 {
lab=IBPS_4U}
N -220 -440 -170 -440 {
lab=IBPS_4U}
N -170 -440 -170 -370 {
lab=IBPS_4U}
N -370 -340 -250 -340 {
lab=VSS}
N -60 -440 10 -440 {
lab=IBNS_20U}
N -60 -440 -60 -400 {
lab=IBNS_20U}
C {cborder/border_s.sym} 520 0 0 0 {
user="wulff"
company="wulff"}
C {devices/ipin.sym} -360 -340 0 0 {name=p2 lab=VSS}
C {sky130_fd_pr/nfet_01v8.sym} -200 -370 0 1 {name=M1
L=0.36
W=3.6
nf=2 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/ipin.sym} -360 -440 0 0 {name=p3 lab=IBPS_4U}
C {sky130_fd_pr/nfet_01v8.sym} -80 -370 0 0 {name=M2[4:0]
L=0.36
W=3.6
nf=2 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {devices/ipin.sym} 0 -440 2 0 {name=p1 lab=IBNS_20U}
