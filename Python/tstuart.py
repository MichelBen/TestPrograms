#test
from serial import Serial
import time
bauddft = 9600 
baud    = 9600
while baud != 10 :
    baud = int(input("baud : "))
    if baud == 0 :
        baud    = bauddft 
        bauddft = baud
        print "set to " , baud
        print " "
    serialPort = Serial("/dev/ttyAMA0", baud, timeout=2)
    serialPort.close() 
    serialPort.open()
    if (serialPort.isOpen() == False):
        print "ERROR : can't open the port"
        print
    
    print "Empty buffer"
    serialPort.flushInput()
    serialPort.flushOutput()

    outStr = ""
    while outStr != "end" :
        inStr  = ""
        outStr = raw_input('Out :' )
        print '    out "' ,  outStr , '"'
        if (outStr != ""):
            print "  output '" , outStr ,  "'"
            serialPort.write(outStr)
            print "         done"
        print 
        resp = raw_input('continuer')
        print 'read inStr'
        inStr = serialPort.read(serialPort.inWaiting())
        print 'inStr =  ' + inStr
        print "----"

serialPort.close()
