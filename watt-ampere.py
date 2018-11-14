#!/usr/bin/env python3

import sys,fcntl,os,time,struct,math

analog_addr = 0x68
I2C_SLAVE   = 0x0703
SAMPLES = 240

if len(sys.argv) < 2:
        line = 0
else:
        line = int(sys.argv[1])

dev=os.open("/dev/i2c-1", os.O_RDWR)

fcntl.ioctl(dev, I2C_SLAVE, analog_addr)

cmd=bytearray([0x80 | 0x10 | (line<<5)])
os.write(dev, cmd)
sqsum=0
for j in range(SAMPLES):
        time.sleep(0.004167)
        ret=os.read(dev, 2)
        value=struct.unpack('>h',ret)[0]
        sqsum += (value * value)

current = math.sqrt(sqsum/SAMPLES)*30/1000
print("{:7.4f}A {:6.3f}W".format(current,current * 225))
