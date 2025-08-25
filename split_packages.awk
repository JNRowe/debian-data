BEGIN {
    RS = "\n\n"
    FS = "\n"
    OFS = "\n"

    if (!output_dir) {
        output_dir = "output"
    }
}

{
    # Find the section line and extract its value
    for (i = 1; i <= NF; i++) {
        if ($i ~ /^Section: /) {
            sub(/.*: /, "", $i)
            section = $i
            break
        }
    }
    if (!section) {
        print "Something went wrong:" $0 >> "/dev/stderr"
        exit 1
    }

    target_dir = output_dir

    # Check if section contains a component
    if (section ~ /\//) {
        split(section, comps, /\//)
        target_dir = output_dir "/" comps[1]
        target_file = comps[2] ".pkgs"
    } else {
        target_dir = output_dir "/main"
        target_file = section ".pkgs"
    }

    # Check if we've already created directory, without this runtime
    # explodes because of the system() call
    if (!(target_dir in created_dirs)) {
        system("mkdir -p " target_dir)
        created_dirs[target_dir] = 1
    }
    full_path = target_dir "/" target_file

    # Truncate file when we have new data to prevent duplication
    if (!(full_path in created_files)) {
        printf "" > full_path
        created_files[full_path] = 1
    }
    print $0 "\n" >> full_path
}
