#! /bin/sh

mkdir -p "bullseye"

base=https://deb.debian.org/

for s in \
    debian/dists/bullseye/InRelease \
    debian/dists/bullseye/contrib/binary-i386/Packages.xz \
    debian/dists/bullseye/contrib/i18n/Translation-en.bz2 \
    debian/dists/bullseye/main/binary-i386/Packages.xz \
    debian/dists/bullseye/main/i18n/Translation-en.bz2 \
    debian/dists/bullseye/non-free/binary-i386/Packages.xz \
    debian/dists/bullseye/non-free/i18n/Translation-en.bz2 \
    debian/dists/bullseye-updates/InRelease \
    debian/dists/bullseye-updates/contrib/binary-i386/Packages.xz \
    debian/dists/bullseye-updates/contrib/i18n/Translation-en.bz2 \
    debian/dists/bullseye-updates/main/binary-i386/Packages.xz \
    debian/dists/bullseye-updates/main/i18n/Translation-en.bz2 \
    debian/dists/bullseye-updates/non-free/binary-i386/Packages.xz \
    debian/dists/bullseye-updates/non-free/i18n/Translation-en.bz2 \
    debian-security/dists/bullseye-security/InRelease \
    debian-security/dists/bullseye-security/contrib/binary-i386/Packages.xz \
    debian-security/dists/bullseye-security/contrib/i18n/Translation-en.xz \
    debian-security/dists/bullseye-security/main/binary-i386/Packages.xz \
    debian-security/dists/bullseye-security/main/i18n/Translation-en.xz \
    debian-security/dists/bullseye-security/non-free/binary-i386/Packages.xz \
    debian-security/dists/bullseye-security/non-free/i18n/Translation-en.xz; do
    u=$base$s
    p=bullseye/$(echo "$u" | sed -e 's,^https://,,' -e 's,/,_,g')
    curl -o "$p" "$u" || echo $u >>fail
done

unxz --force --verbose bullseye/*.xz
bunzip2 --force --verbose bullseye/*.bz2

find bullseye/ -size 0 -exec rm '{}' \;
