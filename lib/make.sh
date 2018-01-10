from . import env

: ${MakeFile:=$ProjectDir/Makefile}
: ${MakeFlags:=PROJECT_DIR=\"$ProjectDir\" SANDBOX_DIR=\"$SandboxDir\" SYSTEM_DIR=\"$SystemDir\" --no-print-directory --no-builtin-rules}

setup_make()
{(
        from . import os

        if is_macos; then
                setup_make_for_macos "$@"
        fi
)}

setup_make_for_macos()
{(
        from . import brew

        brew_install make --with-default-names
        ## --with-default-names avoids using the 'g' prefix for make (gmake).
)}

make()
{
        eval "set -- $MakeFlags $*"

        ${MakeBin:-$(which make)} -C "$ProjectDir" -f "$MakeFile" "$@" | sed -e "s:$ProjectDir:.:g"
}