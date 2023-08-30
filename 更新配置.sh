#!/system/bin/sh

user_config_dir="/data/media/0/Android/Xzhi/custom-dir-mount"
config_file="$user_config_dir/目录挂载.conf"
log_file="$user_config_dir/run.log"
mount_record_file="$user_config_dir/.勿删除勿修改"

mount_dir() {
  log "^_^ 开始更新配置 ^_^"
  if [[ -f "$config_file" ]]; then
    # 读取配置文件
    while IFS= read -r line || [[ -n "$line" ]]; do
      # 去除行两端的空格
      line=$(echo "$line" | awk '{$1=$1};1')
      # 忽略没有内容的一行
      if [ -z "$line" ]; then
        continue
      fi
      # 检查行末尾是否有换行符
      if ! echo "$line" | grep -q $'\n'; then
        line="$line"$'\n'
      fi
      # 忽略以 "#" 开头的注释行
      if [[ $line != \#* ]]; then
        # 分割行为源路径和目标路径
        source_path=$(echo "$line" | awk '{print $1}')
        target_path=$(echo "$line" | awk '{print $2}')
        #去除路径中的双引号
        source_path=$(sed 's/"//g' <<<"$source_path")
        target_path=$(sed 's/"//g' <<<"$target_path")
        [[ ! -d $target_path ]] && mkdir -p "$target_path"
        if [[ -d $source_path ]]; then
          #查询该源目录是否曾挂载成功过
          source_path_mount_record="${source_path%/}"
          source_path_exist=$(grep "$source_path_mount_record" "$mount_record_file")
          if [[ -z $source_path_exist ]]; then
            mount -o make,private,gid=9997,uid=9997,bind,rw "$source_path" "$target_path"
            chcon u:object_r:media_rw_data_file:s0 "$source_path"
            chown media_rw:media_rw "$target_path"
            # chmod -R 2777 "$target_path"
            echo $source_path_mount_record >>$mount_record_file
            log "更新成功，源路径：$source_path >>> 目标路径：$target_path"
          else
            log "源路径：$source_path （包含子目录或父目录）已经挂载成功无需更新"
          fi
        else
          log "(T_T) 挂载失败，源路径：$source_path 不存在该目录 (T_T)"
        fi
      fi
    done <"$config_file"
  else
    log "(T_T) 配置文件$config_file 读取失败 (T_T)"
  fi
  log "^_^ 更新配置结束 ^_^"
}

log() {
  echo "[$(date "+%Y-%m-%d %H:%M:%S")] - $1" >>$log_file
}

mount_dir
