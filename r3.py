#!/usr/bin/env python3

import sys,fcntl,os,time,struct

analog_addr = 0x68
I2C_SLAVE   = 0x0703

dev=os.open("/dev/i2c-1", os.O_RDWR)

fcntl.ioctl(dev, I2C_SLAVE, analog_addr)
    
for i in range(2,3):
        cmd=bytearray([0x80 | 0x1c | (i<<5)])
        os.write(dev, cmd)
        time.sleep(0.67)
        ret=os.read(dev, 4)
        value=struct.unpack('>l',ret)[0]
        uvolt=uvolt=(value >> 8) * 1000 / 64

	# Regolato a -4 07/2017 termometro ikea como
	# Regolato a -6 05/2018 termometro ikea como
        print("{}".format(round(((uvolt / 10000) - 6.2),1)))

	#print("{}".format(round(((uvolt / 10000) - 8.6),1)))
	#print("{}'C".format(uvolt * 100))

