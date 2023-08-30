#!/system/bin/sh
MODDIR="$(dirname "$0")"
source $MODDIR/constant.sh

log() {
  log_msg="[$(date "+%Y-%m-%d %H:%M:%S")] - $1"
  if [ -z "$2" ]; then
    echo $log_msg >>$log_file
  else
    echo $log_msg >$log_file
  fi
}
