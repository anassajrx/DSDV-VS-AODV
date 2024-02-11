BEGIN {
    seqno = -1; 
    receivedPackets = 0;
}

{
    
    if($4 == "AGT" && $1 == "s" && seqno < $6) {
        seqno = $6;SS
    } else if(($4 == "AGT") && ($1 == "r")) {
        receivedPackets++;
    } 
}
END { 
    
    print "\n";
    print "GeneratedPackets = " seqno+1;
    print "ReceivedPackets = " receivedPackets;
    print "perdu = " (seqno+1)- receivedPackets;
    print "\n";
}

