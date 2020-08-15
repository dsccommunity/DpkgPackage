# Usage: dpkg [<option> ...] <command>

# Commands:
#   -i|--install       <.deb file name> ... | -R|--recursive <directory> ...
#   --unpack           <.deb file name> ... | -R|--recursive <directory> ...
#   -A|--record-avail  <.deb file name> ... | -R|--recursive <directory> ...
#   --configure        <package> ... | -a|--pending
#   --triggers-only    <package> ... | -a|--pending
#   -r|--remove        <package> ... | -a|--pending
#   -P|--purge         <package> ... | -a|--pending
#   -V|--verify <package> ...        Verify the integrity of package(s).
#   --get-selections [<pattern> ...] Get list of selections to stdout.
#   --set-selections                 Set package selections from stdin.
#   --clear-selections               Deselect every non-essential package.
#   --update-avail [<Packages-file>] Replace available packages info.
#   --merge-avail [<Packages-file>]  Merge with info from file.
#   --clear-avail                    Erase existing available info.
#   --forget-old-unavail             Forget uninstalled unavailable pkgs.
#   -s|--status <package> ...        Display package status details.
#   -p|--print-avail <package> ...   Display available version details.
#   -L|--listfiles <package> ...     List files 'owned' by package(s).
#   -l|--list [<pattern> ...]        List packages concisely.
#   -S|--search <pattern> ...        Find package(s) owning file(s).
#   -C|--audit [<package> ...]       Check for broken package(s).
#   --yet-to-unpack                  Print packages selected for installation.
#   --predep-package                 Print pre-dependencies to unpack.
#   --add-architecture <arch>        Add <arch> to the list of architectures.
#   --remove-architecture <arch>     Remove <arch> from the list of architectures.
#   --print-architecture             Print dpkg architecture.
#   --print-foreign-architectures    Print allowed foreign architectures.
#   --assert-<feature>               Assert support for the specified feature.
#   --validate-<thing> <string>      Validate a <thing>'s <string>.
#   --compare-versions <a> <op> <b>  Compare version numbers - see below.
#   --force-help                     Show help on forcing.
#   -Dh|--debug=help                 Show help on debugging.

#   -?, --help                       Show this help message.
#       --version                    Show the version.

# Assertable features: support-predepends, working-epoch, long-filenames,
#   multi-conrep, multi-arch, versioned-provides.

# Validatable things: pkgname, archname, trigname, version.

# Use dpkg with -b, --build, -c, --contents, -e, --control, -I, --info,
#   -f, --field, -x, --extract, -X, --vextract, --ctrl-tarfile, --fsys-tarfile
# on archives (type dpkg-deb --help).

# Options:
#   --admindir=<directory>     Use <directory> instead of /var/lib/dpkg.
#   --root=<directory>         Install on a different root directory.
#   --instdir=<directory>      Change installation dir without changing admin dir.
#   --path-exclude=<pattern>   Do not install paths which match a shell pattern.
#   --path-include=<pattern>   Re-include a pattern after a previous exclusion.
#   -O|--selected-only         Skip packages not selected for install/upgrade.
#   -E|--skip-same-version     Skip packages whose same version is installed.
#   -G|--refuse-downgrade      Skip packages with earlier version than installed.
#   -B|--auto-deconfigure      Install even if it would break some other package.
#   --[no-]triggers            Skip or force consequential trigger processing.
#   --verify-format=<format>   Verify output format (supported: 'rpm').
#   --no-debsig                Do not try to verify package signatures.
#   --no-act|--dry-run|--simulate
#                              Just say what we would do - don't do it.
#   -D|--debug=<octal>         Enable debugging (see -Dhelp or --debug=help).
#   --status-fd <n>            Send status change updates to file descriptor <n>.
#   --status-logger=<command>  Send status change updates to <command>'s stdin.
#   --log=<filename>           Log status changes and actions to <filename>.
#   --ignore-depends=<package>,...
#                              Ignore dependencies involving <package>.
#   --force-...                Override problems (see --force-help).
#   --no-force-...|--refuse-...
#                              Stop when problems encountered.

function Get-DpkgCmdArgument
{
    [CmdletBinding()]
    param
    (
        #Commands
        [Parameter()]
        $Info,

        [Parameter()]
        $Install,

        [Parameter()]
        $Unpack,

        [Parameter()]
        $RecordAvailble,

        [Parameter()]
        $Configure,

        [Parameter()]
        $TriggersOnly,

        [Parameter()]
        $Remove,

        [Parameter()]
        $Purge,

        [Parameter()]
        $Verify,

        [Parameter()]
        $GetSelections,

        [Parameter()]
        $SetSelections,

        [Parameter()]
        $UpdateAvailable,

        [Parameter()]
        $MergeAvailable,

        [Parameter()]
        $ClearAvailable,

        [Parameter()]
        $ForgetOldUnavailable,

        [Parameter()]
        [AllowNull()]
        [string]
        $Status,

        [Parameter()]
        $PrintAvailable,

        [Parameter()]
        $ListFiles,


        [Parameter()]
        [AllowNull()]
        [String]
        $List,

        [Parameter()]
        $Search,

        [Parameter()]
        $Audit,

        [Parameter()]
        $YetToUnpack,

        [Parameter()]
        $Predependencies,

        [Parameter()]
        $AddArchitecture,

        [Parameter()]
        $RemoveArchitecture,

        [Parameter()]
        $PrintArchitecture,

        [Parameter()]
        $PrintForeignArchitecture,

        [Parameter()]
        $Assert,

        [Parameter()]
        $Validate,

        [Parameter()]
        $CompareVersion,

        [Parameter()]
        $ForceHelp,

        [Parameter()]
        $DebugHelp,

        [Parameter()]
        $Help,


        # options

        [Parameter()]
        $AdminDir,

        [Parameter()]
        $RootDir,

        [Parameter()]
        $InstallDir,

        [Parameter()]
        $PathExclude,

        [Parameter()]
        $PathInclude,

        [Parameter()]
        $SelectedOnly,

        [Parameter()]
        $SkipSameVersion,

        [Parameter()]
        $RefuseDowngrade,

        [Parameter()]
        $AutoDeconfigure,

        [Parameter()]
        $NoTriggers,

        [Parameter()]
        $Triggers,

        [Parameter()]
        $VerifyFormat,

        [Parameter()]
        $NoDebsig,

        #WhatIf == --dry-run
        [Parameter()]
        $StatusFileDescriptor,

        [Parameter()]
        $StatusLogger,

        [Parameter()]
        $Log,

        [Parameter()]
        $IgnoreDepends,

        [Parameter()]
        $Force
        # Refuse / --no-force -eq ErrorAction Stop
    )

    $dpkgOption = switch ($PSBoundParameters.Keys)
    {
        'AdminDir'             { throw 'Not Implemented Yet.' }
        'RootDir'              { throw 'Not Implemented Yet.' }
        'InstallDir'           { throw 'Not Implemented Yet.' }
        'PathExclude'          { throw 'Not Implemented Yet.' }
        'PathInclude'          { throw 'Not Implemented Yet.' }
        'SelectedOnly'         { throw 'Not Implemented Yet.' }
        'SkipSameVersion'      { throw 'Not Implemented Yet.' }
        'RefuseDowngrade'      { throw 'Not Implemented Yet.' }
        'AutoDeconfigure'      { throw 'Not Implemented Yet.' }
        'NoTriggers'           { throw 'Not Implemented Yet.' }
        'Triggers'             { throw 'Not Implemented Yet.' }
        'VerifyFormat'         { throw 'Not Implemented Yet.' }
        'NoDebsig'             { throw 'Not Implemented Yet.' }
        # WhatIf == --dry-run  { throw 'Not Implemented Yet.' }
        'StatusFileDescriptor' { throw 'Not Implemented Yet.' }
        'StatusLogger'         { throw 'Not Implemented Yet.' }
        'Log'                  { throw 'Not Implemented Yet.' }
        'IgnoreDepends'        { throw 'Not Implemented Yet.' }
        'Force'                { throw 'Not Implemented Yet.' }
        # Refuse / --no-force -eq ErrorAction Stop
    }

    $dpkgCommand = switch ($PSBoundParameters.Keys)
    {
        'Info'                     { "--info '$($Info -join "'")'" }
        'Install'                  { throw 'Not Implemented Yet.'}
        'Unpack'                   { throw 'Not Implemented Yet.'}
        'RecordAvailble'           { throw 'Not Implemented Yet.'}
        'Configure'                { throw 'Not Implemented Yet.'}
        'TriggersOnly'             { throw 'Not Implemented Yet.'}
        'Remove'                   { throw 'Not Implemented Yet.'}
        'Purge'                    { throw 'Not Implemented Yet.'}
        'Verify'                   { throw 'Not Implemented Yet.'}
        'GetSelections'            { throw 'Not Implemented Yet.'}
        'SetSelections'            { throw 'Not Implemented Yet.'}
        'UpdateAvailable'          { throw 'Not Implemented Yet.'}
        'MergeAvailable'           { throw 'Not Implemented Yet.'}
        'ClearAvailable'           { throw 'Not Implemented Yet.'}
        'ForgetOldUnavailable'     { throw 'Not Implemented Yet.'}
        'Status'                   { "-s$(if ($Status) {" '$Status'"})"}
        'PrintAvailable'           { throw 'Not Implemented Yet.'}
        'ListFiles'                { throw 'Not Implemented Yet.'}
        'List'                     { "-l $List" }
        'Search'                   { throw 'Not Implemented Yet.'}
        'Audit'                    { throw 'Not Implemented Yet.'}
        'YetToUnpack'              { throw 'Not Implemented Yet.'}
        'Predependencies'          { throw 'Not Implemented Yet.'}
        'AddArchitecture'          { throw 'Not Implemented Yet.'}
        'RemoveArchitecture'       { throw 'Not Implemented Yet.'}
        'PrintArchitecture'        { throw 'Not Implemented Yet.'}
        'PrintForeignArchitecture' { throw 'Not Implemented Yet.'}
        'Assert'                   { throw 'Not Implemented Yet.'}
        'Validate'                 { throw 'Not Implemented Yet.'}
        'CompareVersion'           { throw 'Not Implemented Yet.'}
        'ForceHelp'                { throw 'Not Implemented Yet.'}
        'DebugHelp'                { throw 'Not Implemented Yet.'}
        'Help'                     { throw 'Not Implemented Yet.'}
    }

    return ($dpkgOption + $dpkgCommand)
}
