#!/usr/bin/env bash

set -e

echo "binaries: $BINARIES_DIR"
echo "host: $HOST_DIR"
echo "staging: $STAGING_DIR"
echo "target: $TARGET_DIR"
echo "build: $BUILD_DIR"
mkdir -p $BINARIES_DIR/uconsole
cp $BUILD_DIR/linux-custom/arch/arm/boot/dts/overlays/devterm-bt.dtbo $BINARIES_DIR/uconsole/
cp $BUILD_DIR/linux-custom/arch/arm/boot/dts/overlays/devterm-panel-uc.dtbo $BINARIES_DIR/uconsole/
cp $BUILD_DIR/linux-custom/arch/arm/boot/dts/overlays/devterm-misc.dtbo $BINARIES_DIR/uconsole/
cp $BUILD_DIR/linux-custom/arch/arm/boot/dts/overlays/devterm-pmu.dtbo $BINARIES_DIR/uconsole/
cp $BUILD_DIR/linux-custom/arch/arm/boot/dts/overlays/devterm-panel.dtbo $BINARIES_DIR/uconsole/
cp $BUILD_DIR/linux-custom/arch/arm/boot/dts/overlays/devterm-wifi.dtbo $BINARIES_DIR/uconsole/

# Create the fwup ops script to handling MicroSD/eMMC operations at runtime
# NOTE: revert.fw is the previous, more limited version of this. ops.fw is
#       backwards compatible.
mkdir -p $TARGET_DIR/usr/share/fwup
$HOST_DIR/usr/bin/fwup -c -f $NERVES_DEFCONFIG_DIR/fwup-ops.conf -o $TARGET_DIR/usr/share/fwup/ops.fw
ln -sf ops.fw $TARGET_DIR/usr/share/fwup/revert.fw

# Copy the fwup includes to the images dir
cp -rf $NERVES_DEFCONFIG_DIR/fwup_include $BINARIES_DIR
