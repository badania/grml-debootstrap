# -*- shell-script -*-

#
# shell script command line parameter-processing for:
#
# grml-debootstrap - wrapper around debootstrap for installing plain Debian via
# grml
#
# @Author:  Tong SUN
# @Release: $Revision: 1.2 $, under the BSD license
# @HomeURL: http://xpt.sourceforge.net/
#

# @WARNING: Do NOT modify this file without prior contacting the author.
# This script is use for the command line *logic* processing. It should be
# as dumb as possible. I.e., it should NOT be more complicated than
# copy-paste-and-rename from existing code. All *business-logic* processing
# should be handled in the main script, where it belongs.



_opt_temp=`getopt --name grml-debootstrap -o +m:i:r:t:p:d:c:hv --long \
    mirror:,iso:,release:,target:,mntpoint:,debopt:,interactive,confdir:,config:,packages::,debconf::,keep_src_list,hostname:,password:,bootappend:,groot:,grub:,help,version \
  -- "$@"`
if [ $? != 0 ]; then
  eerror "Try `grml-debootstrap --help' for more information."; eend 1; exit 1
fi
eval set -- "$_opt_temp"

while :; do
  case "$1" in

  # == Bootstrap options
  --mirror|-m)         # Mirror which should be used for apt-get/aptitude.
    shift; _opt_mirror="$1"
    ;;
  --iso|-i)            # Mountpoint where a Debian ISO is mounted to, for use instead
    shift; _opt_iso="$1"
    ;;
  --release|-r)        # Release of new Debian system (default: stable).
    shift; _opt_release="$1"
    ;;
  --target|-t)         # Target partition (/dev/...) or directory.
    shift; _opt_target="$1"
    ;;
  --mntpoint|-p)       # Mountpoint used for mounting the target system.
    shift; _opt_mntpoint="$1"
    ;;
  --debopt)            # Extra parameters passed to the debootstrap.
    shift; _opt_debopt="$1"
    ;;
  --interactive)       # Use interactive mode (frontend).
    _opt_interactive=T
    ;;
  #

  # == Configuration options
  --confdir|-d)        # Place of config files for debootstrap, defaults to /etc/debo
    shift; _opt_confdir="$1"
    ;;
  --config|-c)         # Use specified configuration file, defaults to <confdir>/conf
    shift; _opt_config="$1"
    ;;
  --packages)          # Install packages defined in <confdir>/packages. Option arg:
    shift; _opt_packages="$1"
    _opt_packages_set=T
    ;;
  --debconf)           # Pre-seed packages using <confdir>/debconf-selections. Option
    shift; _opt_debconf="$1"
    _opt_debconf_set=T
    ;;
  --keep_src_list)     # Do not overwrite user provided apt sources.list.
    _opt_keep_src_list=T
    ;;
  --hostname)          # Hostname of Debian system.
    shift; _opt_hostname="$1"
    ;;
  --password)          # Use specified password as password for user root.
    shift; _opt_password="$1"
    ;;
  #
  --bootappend)        # Add specified appendline to kernel whilst booting.
    shift; _opt_bootappend="$1"
    ;;
  --groot)             # Root device for usage in grub, corresponds with $TARGET in g
    shift; _opt_groot="$1"
    ;;
  --grub)              # Target for grub installation. Use grub syntax for specifying
    shift; _opt_grub="$1"
    ;;

  # == Other options
  --help|-h)           # Print this usage information and exit.
    _opt_help=T
    ;;
  --version|-v)        # Show summary of options and exit.
    _opt_version=T
    ;;
  --)
    shift; break
    ;;
  *)
    eerror "Internal getopt error!"; eend 1 ; exit 1
    ;;
  esac
  shift
done


# End
