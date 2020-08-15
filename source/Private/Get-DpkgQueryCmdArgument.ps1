# Usage: dpkg-query [<option> ...] <command>

# Commands:
#   -s|--status <package> ...        Display package status details.
#   -p|--print-avail <package> ...   Display available version details.
#   -L|--listfiles <package> ...     List files 'owned' by package(s).
#   -l|--list [<pattern> ...]        List packages concisely.
#   -W|--show [<pattern> ...]        Show information on package(s).
#   -S|--search <pattern> ...        Find package(s) owning file(s).
#      --control-list <package>      Print the package control file list.
#      --control-show <package> <file>
#                                    Show the package control file.
#   -c|--control-path <package> [<file>]
#                                    Print path for package control file.

#   -?, --help                       Show this help message.
#       --version                    Show the version.

# Options:
#   --admindir=<directory>           Use <directory> instead of /var/lib/dpkg.
#   --load-avail                     Use available file on --show and --list.
#   -f|--showformat=<format>         Use alternative format for --show.

# Format syntax:
#   A format is a string that will be output for each package. The format
#   can include the standard escape sequences \n (newline), \r (carriage
#   return) or \\ (plain backslash). Package information can be included
#   by inserting variable references to package fields using the ${var[;width]}
#   syntax. Fields will be right-aligned unless the width is negative in which
#   case left alignment will be used.

function Get-DpkgQueryCmdArgument
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        $Show,

        [Parameter()]
        $List,

        [Parameter()]
        $ListFiles
    )

    $dpkgOption = switch ($PSBoundParameters.Keys)
    {
        'AdminDir' { throw 'Not Implemented Yet.' }
    }

    $dpkgCommand = switch ($PSBoundParameters.Keys)
    {
#   -s|--status <package> ...        Display package status details.
#   -p|--print-avail <package> ...   Display available version details.

#   -L|--listfiles <package> ...     List files 'owned' by package(s).
        'ListFiles' {"-L '$ListFiles"}
#   -l|--list [<pattern> ...]        List packages concisely.
        'List' { "-l $List"}
#   -W|--show [<pattern> ...]        Show information on package(s).
        'Show' { "-W '$($Show -join "' '")'"}

#   -S|--search <pattern> ...        Find package(s) owning file(s).
#      --control-list <package>      Print the package control file list.
#      --control-show <package> <file>
#                                    Show the package control file.
#   -c|--control-path <package> [<file>]
#                                    Print path for package control file.

#   -?, --help                       Show this help message.
#       --version                    Show the version.
    }

    return ($dpkgOption + $dpkgCommand)
}
