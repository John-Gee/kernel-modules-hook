# Maintainer: Artoria Pendragon <saber-nyan@ya.ru>
# Hooks: https://www.reddit.com/r/archlinux/comments/4zrsc3/keep_your_system_fully_functional_after_a_kernel/d6yin0r/
pkgname=kernel-modules-hook
pkgver=0.1.8.2
pkgrel=1
pkgdesc="Keeps your system fully functional after a kernel upgrade"
arch=('any')
url="https://github.com/john-gee/kernel-modules-hook"
license=('UNLICENSE')
install="${pkgname}.install"
source=("cleanup-old-modules.sh"
        "cleanup-old-modules.conf"
        "linux-modules-cleanup.conf"
		"linux-modules-cleanup.service"
		"10-linux-modules-post.hook"
		"10-linux-modules-pre.hook"
		"UNLICENSE")
sha256sums=('088aa7062f2ee1e8a3777fa4bd74fd0ee98d61b3b708e676b5e940ec4a2d6998'
            '0d935e50f055aeecad5cfb554a2d8e45fcedd4f60788dde1df20fd51bb501ad5'
            '4169b44c297ddb7aad2220c6eba7c7942e3396f92528c59617955ab5560cb4cf'
            '30e63a535a9d410810a2121ba6ac6a439226554c3f097064df87d3c78ec7bb19'
            '10d0b17c3e1cea447be547d617c13b5fc9aaaeae84b34573294dd5fe54acce68'
            '7c3380580323b615023bd4ca0669f63d0af0a4fea83ba8c0892701d759de591a'
            '7e12e5df4bae12cb21581ba157ced20e1986a0508dd10d0e8a4ab9a4cf94e85c')

package() {
    install -Dm755 'cleanup-old-modules.sh' "${pkgdir}/usr/bin/cleanup-old-modules.sh"
    install -Dm644 'cleanup-old-modules.conf' "${pkgdir}/usr/share/doc/kernel-modules-hook/cleanup-old-modules.conf"
	install -Dm644 'linux-modules-cleanup.conf' "${pkgdir}/usr/lib/tmpfiles.d/linux-modules-cleanup.conf"
	install -Dm644 'linux-modules-cleanup.service' "${pkgdir}/usr/lib/systemd/system/linux-modules-cleanup.service"
	install -Dm644 '10-linux-modules-post.hook' "${pkgdir}/usr/share/libalpm/hooks/10-linux-modules-post.hook"
	install -Dm644 '10-linux-modules-pre.hook' "${pkgdir}/usr/share/libalpm/hooks/10-linux-modules-pre.hook"
	install -Dm644 'UNLICENSE' "${pkgdir}/usr/share/licenses/${pkgname}/UNLICENSE"
}
