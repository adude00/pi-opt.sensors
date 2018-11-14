#!/usr/bin/env python3

import sys,fcntl,os,time,struct

analog_addr = 0x68
I2C_SLAVE   = 0x0703
SENSORE     = 2

dev=os.open("/dev/i2c-1", os.O_RDWR)

if len(sys.argv) < 2:
        line = 0
else:
        line = int(sys.argv[1])

print("INPUT N°:",line)

fcntl.ioctl(dev, I2C_SLAVE, analog_addr)
    
cmd=bytearray([0x80 | 0x1c | (line<<5)])
os.write(dev, cmd)
time.sleep(0.67)
ret=os.read(dev, 4)
value=struct.unpack('>l',ret)[0]
uvolt=uvolt=(value >> 8) * 1000 / 64

print("{}".format(round(((uvolt / 10000) - 0),1)))

print("{}uV".format(uvolt))

