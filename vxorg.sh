#!/bin/bash
GPU_BOARD=$(nvidia-xconfig --query-gpu-info | grep GPU | awk '{print $4}')
GPU_PCI=$(nvidia-xconfig --query-gpu-info | grep BusID | awk '{print $4}')
# GPU_PCI="PCI:9:0:0"

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
EOT

# Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./xserver.log vt1 $DISPLAY &