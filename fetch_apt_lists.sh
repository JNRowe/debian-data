#! /bin/sh

mkdir --parents "bullseye"
mkdir --parents ".etags"

base=https://deb.debian.org/

for location in \
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
    url=$base$location
    safename=$(echo "$url" | sed -e 's,^https://,,' -e 's,/,_,g')
    filename=bullseye/$safename
    output=$(echo "$filename" | sed -e 's,\.\(bz2\|xz\)$,,')
    etagname=.etags/$safename
    [ -f "$output" ] && ref_time="$output" || ref_time="2004 Nov 13"
    # More recent versions of curl don't fail on missing etag file
    [ -f "$etagname" ] && ref_etag="$etagname" || ref_etag=/dev/null
    echo "--- $url"
    # Once a more recent version of curl is available in actions
    # --etag-{compare,save} can return to using the same file.
    curl --connect-timeout 5 --max-time 30 \
        --etag-compare "$ref_etag" \
        --etag-save "$etagname.tmp" \
        --verbose \
        --time-cond "$ref_time" --output "$filename" "$url"
    if [ -s "$etagname.tmp" ]; then
        mv "$etagname.tmp" "$etagname"
    else
        rm "$etagname.tmp"
    fi
done

unxz --force --verbose bullseye/*.xz
bunzip2 --force --verbose bullseye/*.bz2

find bullseye/ -size 0 -exec rm '{}' \;
