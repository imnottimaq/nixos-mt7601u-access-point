{ pkgs
, lib
, kernel ? pkgs.linuxPackages_zen.kernel
}:

pkgs.stdenv.mkDerivation {
  pname = "mt7601u-kernel-module";
  inherit (kernel) src version postPatch nativeBuildInputs;

  kernel_dev = kernel.dev;
  kernelVersion = kernel.modDirVersion;

  patches = [ ./access-point.patch ];

  modulePath = "drivers/net/wireless/mediatek/mt7601u";

  buildPhase = ''
    BUILT_KERNEL=$kernel_dev/lib/modules/$kernelVersion/build

    cp $BUILT_KERNEL/Module.symvers .
    cp $BUILT_KERNEL/.config        .
    cp $kernel_dev/vmlinux          .

    make "-j$NIX_BUILD_CORES" modules_prepare
    make "-j$NIX_BUILD_CORES" M=$modulePath modules
  '';

  installPhase = ''
    make INSTALL_MOD_PATH="$out" XZ="xz -T$NIX_BUILD_CORES" M="$modulePath" modules_install
  '';

  meta = {
    description = "MediaTek MT7601U kernel module with access-point patch";
    license = lib.licenses.gpl2;
  };
}

