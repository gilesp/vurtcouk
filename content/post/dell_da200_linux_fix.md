+++
title = "Dell DA200 usb-c hdmi fix"
description = "How to get the Dell DA200 usb-c adapter working on linux"
tags = ["linux", "usb-c", "patch", "fix"]
date = 2017-05-30T11:54:45Z
+++

I recently upgraded to a [Dell XPS 13](http://www.dell.com/uk/p/xps-13-9360-laptop/pd?oc=cnx93618&model_id=xps-13-9360-laptop) for my development machine at work (Lovely hardware, with official Ubuntu support from Dell) and it's been great. The only fly in the ointment has been the [Dell DA200](http://accessories.euro.dell.com/sna/productdetail.aspx?c=uk&l=en&s=dhs&cs=ukdhs1&sku=470-ABRY) mini usb-c adapter that provides ethernet, USB, VGA and HDMI connectors. Due to a bug in the firmware for the adapter, the HDMI connection doesn't work under linux except at very low resolutions.

Thankfully there is a [fix available in the kernel](https://bugs.freedesktop.org/show_bug.cgi?id=93578) from 4.11 onwards, but I'm running Ubuntu 16.10 with kernel 4.8. Luckily there is a patch containing the fix that can be applied and compiled as a DKMS module. This means that I can make use of the fix now, without having to wait until I upgrade to a newer kernel. The instructions for applying the patch are outlined in the [bug report](https://bugs.freedesktop.org/show_bug.cgi?id=93578) but they're a bit disjointed, so I've collected them here to simplify the process for others.

First, open a terminal and get an interactive root shell, then install & extract the kernel sources:

```sh
sudo -i
apt-get install linux-source-4.8.0
cd /usr/src/
tar -jxf linux-source-4.8.0.tar.bz2
```

Then copy the existing i915 driver and create a DKMS configuration for it:

```sh
cp -R ./linux-source-4.8.0/drivers/gpu/drm/i915 ./i915-usbc
cd i915-usbc/
cat << EOF > dkms.conf
PACKAGE_NAME="i915"
PACKAGE_VERSION="usbc"
AUTOINSTALL=yes
REMAKE_INITRD=yes
DEST_MODULE_LOCATION="/updates"
BUILD_EXCLUSIVE_KERNEL="^4.8.*"
BUILT_MODULE_NAME[0]="i915"
EOF
sed -i 's#../../../platform/x86/intel_ips.h#../../linux-source-4.8.0/drivers/platform/x86/intel_ips.h#g' intel_pm.c
```

The last line is just adjusting the path for an include statement.

Finally download and apply the patch before building the dkms module:

```sh
wget https://patchwork.freedesktop.org/patch/145853/raw/ -O /tmp/drm-i915.patch
patch -p5 < /tmp/drm-i915.patch
dkms add -m i915 -v usbc
dkms build -m i915 -v usbc
dkms install -m i915 -v usbc
```

Then reboot and the HDMI adapter will work as intended at all resolutions.
