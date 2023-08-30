#!/system/bin/sh
MODDIR=${0%/*}
source $MODDIR/log.sh

system_init_check() {
  until [[ $(getprop sys.boot_completed) -eq 1 ]]; do
    sleep 2
  done

  local test_file="/sdcard/Android/.test_file_Xzhi"
  touch $test_file
  while [[ ! -f $test_file ]]; do
    touch $test_file
    sleep 1
  done
  rm $test_file
}

call_mount_dir() {
  log "^_^ 开启自定义目录挂载 ^_^" "清空历史日志"
  chown root:root $MODDIR/mount_dir.sh
  chmod 777 $MODDIR/mount_dir.sh
  /system/bin/sh $MODDIR/mount_dir.sh &>/dev/null &
}

system_init_check
call_mount_dir

exit 0
