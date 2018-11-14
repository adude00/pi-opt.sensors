#!/usr/bin/env python3

import sys,fcntl,os,time,struct

analog_addr = 0x68
I2C_SLAVE   = 0x0703

dev=os.open("/dev/i2c-1", os.O_RDWR)

fcntl.ioctl(dev, I2C_SLAVE, analog_addr)
    
for i in range(1,2):
        cmd=bytearray([0x80 | 0x1c | (i<<5)])
        os.write(dev, cmd)
        time.sleep(0.67)
        ret=os.read(dev, 4)
        value=struct.unpack('>l',ret)[0]
        uvolt=uvolt=(value >> 8) * 1000 / 64

        print("{}".format(round(((uvolt / 10000) - 6.0),1)))

	#print("{}".format(round(((uvolt / 10000) - 4.2),1)))
        #print("{}uV".format(uvolt))

