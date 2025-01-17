# Copyright 1999-2024 Gentoo Authors and Alex313031
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit toolchain-funcs

MY_P="broadcom-wl-${PV}"

DESCRIPTION="broadcom firmware for b43 LP PHY and >=linux-3.2"
HOMEPAGE="http://linuxwireless.org/en/users/Drivers/b43"
SRC_URI="http://www.lwfinger.com/b43-firmware/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="Broadcom"
SLOT="b43"
KEYWORDS="amd64 ~arm64 ppc x86"
RESTRICT="binchecks bindist strip"

RDEPEND="
	net-wireless/b43-fwcutter
	sys-kernel/linux-firmware
"
BDEPEND="net-wireless/b43-fwcutter"

src_compile() {
	mkdir ebuild-output || die
	b43-fwcutter -w ebuild-output linux/wl_apsta.o || die
}

src_install() {
	insinto /lib/firmware
	doins -r ebuild-output/.
}
