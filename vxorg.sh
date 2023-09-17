#!/bin/bash
GPU_BOARD=$(nvidia-xconfig --query-gpu-info | grep -i 'Name' | awk -F ': ' '{print $2}')
GPU_PCI=$(nvidia-xconfig --query-gpu-info | grep BusID | awk '{print $4}')

mkdir -p /etc/X11
cat <<EOT > /etc/X11/xorg.conf
Section "Files"
		ModulePath      "/usr/lib/xorg/modules"
		ModulePath      "/usr/local/nvidia"
EndSection

Section "Device"
		Identifier     "Device0"
		Driver         "nvidia"
		VendorName     "NVIDIA Corporation"
		BoardName      "$GPU_BOARD"
		BusID          "$GPU_PCI"
EndSection

Section "Monitor"
    Identifier     "Monitor0"
    VendorName     "Unknown"
    ModelName      "Unknown"
    Option         "DPMS"
EndSection

Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth    24
    SubSection     "Display"
        Virtual     1920 1080
        Depth       24
				Modes       "1920x1080"
    EndSubSection
EndSection
EOT

Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./shared/xserver.log vt1 $DISPLAY &