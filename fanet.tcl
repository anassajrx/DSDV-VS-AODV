# Fanet.tcl

# Copyright (c) 1997 Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#      This product includes software developed by the Computer Systems
#      Engineering Group at Lawrence Berkeley Laboratory.
# 4. Neither the name of the University nor of the Laboratory may be used
#    to endorse or promote products derived from this software without
#    specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $Header: /cvsroot/nsnam/ns-2/tcl/ex/wireless-mitf.tcl,v 1.2 41TIME_VALUE_PLACEHOLDER8/30 00:10:45 haoboy Exp $
#
# Simple demo script for the new APIs to support multi-interface for 
# wireless node.
#
# Define options
# Please note: 
# 1. you can still specify "channelType" in node-config right now:
# set val(chan)           Channel/WirelessChannel
# $ns_ node-config ...
#      -channelType $val(chan)
#                  ...
# But we recommend you to use node-config in the way shown in this script
# for your future simulations.  
# 
# 2. Because the ad-hoc routing agents do not support multiple interfaces
#    currently, this script can't generate anything interesting if you config
#    the interfaces of node 1 and 2 on different channels
#   
#     --Xuan Chen, USC/ISI, July 21, 4500
set val(chan)           Channel/WirelessChannel    ; #Channel Type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         50                         ;# max packet in ifq
set val(nn)             7                          ;# number of mobilenodes
set val(rp)             DSDV                       ;# routing protocol
set val(x)		700
set val(y)		700
Phy/WirelessPhy set Pt_ 0.115421 

# Initialize Global Variables

set ns_		[new Simulator]
set tracefd     [open fanet.tr w]
$ns_ trace-all $tracefd

set namtrace [open fanet.nam w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)

# Set up topography object

set topo       [new Topography]

$topo load_flatgrid $val(x) $val(y)

# Create God

create-god $val(nn)

# New API to config node: 
# 1. Create channel (or multiple-channels);
# 2. Specify channel in node-config (instead of channelType);
# 3. Create nodes for simulations.

set chan_ [new $val(chan)]

# Configure node, please note the change below.

$ns_ node-config -adhocRouting $val(rp) \
		-llType $val(ll) \
		-macType $val(mac) \
		-ifqType $val(ifq) \
		-ifqLen $val(ifqlen) \
		-antType $val(ant) \
		-propType $val(prop) \
		-phyType $val(netif) \
		-topoInstance $topo \
		-agentTrace ON \
		-routerTrace ON \
		-macTrace ON \
		-movementTrace OFF \
		-channel $chan_

set node_(0) [$ns_ node]
set node_(1) [$ns_ node]
set node_(2) [$ns_ node]
set node_(3) [$ns_ node]
set node_(4) [$ns_ node]
set node_(5) [$ns_ node]
set node_(6) [$ns_ node]

$node_(0) random-motion 0
$node_(1) random-motion 0
$node_(2) random-motion 0
$node_(3) random-motion 0
$node_(4) random-motion 0
$node_(5) random-motion 0
$node_(6) random-motion 0

for {set i 0} {$i < $val(nn)} {incr i} {
	$ns_ initial_node_pos $node_($i) 20
}

# Provide initial (X,Y, for now Z=0) co-ordinates for mobilenodes


$node_(0) set X_ 5.0

$node_(0) set Y_ 2.0

$node_(0) set Z_ 10.0   ;# Changed Z coordinate



$node_(1) set X_ 5.0

$node_(1) set Y_ 204.0

$node_(1) set Z_ 10.0   ;# Changed Z coordinate



$node_(2) set X_ 155.0

$node_(2) set Y_ 103.0

$node_(2) set Z_ 10.0   ;# Changed Z coordinate



$node_(3) set X_ 255.0

$node_(3) set Y_ 103.0

$node_(3) set Z_ 10.0   ;# Changed Z coordinate



$node_(4) set X_ 355.0

$node_(4) set Y_ 103.0

$node_(4) set Z_ 10.0   ;# Changed Z coordinate



$node_(5) set X_ 455.0

$node_(5) set Y_ 2.0

$node_(5) set Z_ 10.0   ;# Changed Z coordinate



$node_(6) set X_ 455.0

$node_(6) set Y_ 204.0

$node_(6) set Z_ 10.0   ;# Changed Z coordinate

$ns_ at 3.0 "$node_(0) setdest 1.0 300.0 0.0"
$ns_ at 3.0 "$node_(1) setdest 1.0 50.0 0.0"
$ns_ at 3.0 "$node_(2) setdest 150.0 170.0 0.0"
$ns_ at 3.0 "$node_(3) setdest 250.0 170.0 0.0"
$ns_ at 3.0 "$node_(4) setdest 350.0 170.0 0.0"
$ns_ at 3.0 "$node_(5) setdest 500.0 300.0 0.0"
$ns_ at 3.0 "$node_(6) setdest 500.0 50.0 0.0"

# Setup traffic flow between nodes

set tcp0 [new Agent/TCP]
$tcp0 set class_ 1
set sink0 [new Agent/TCPSink]
$ns_ attach-agent $node_(0) $tcp0
$ns_ attach-agent $node_(5) $sink0
$ns_ connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns_ at 3.0 "$ftp0 start"

set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
set sink1 [new Agent/TCPSink]
$ns_ attach-agent $node_(1) $tcp1
$ns_ attach-agent $node_(6) $sink1
$ns_ connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns_ at 3.0 "$ftp1 start" 


# Tell nodes when the simulation ends
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns_ at 30.0 "$node_($i) reset"
}
$ns_ at 30.0 "stop"
$ns_ at 30.01 "puts \"NS EXITING...\" ; $ns_ halt"

# Stop procedure
proc stop {} {
    global ns_ tracefd
    $ns_ flush-trace
    close $tracefd
}

puts "Starting Simulation..."
$ns_ run

