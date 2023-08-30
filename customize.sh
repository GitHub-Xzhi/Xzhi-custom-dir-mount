ui_print "
*****************************************************************
* [Xzhi-自定义目录挂载]模块的配置文件路径：
/storage/emulated/0/Android/Xzhi/custom-dir-mount/目录挂载.conf
或
/data/media/0/Android/Xzhi/custom-dir-mount/目录挂载.conf

* 如果是第一次安装，请在配置文件里添加需要挂载目录的路径。
*****************************************************************
"

source $MODPATH/constant.sh

mkdir -p "$user_config_dir"
[[ ! -f "$config_file" ]] && echo '#使用说明：
#如果要添加注释，第一个字符一定加上#这个符号，否则模块可能出现异常
#格式（注意有空格）："源目录路径" "目标目录路径"，例子：
#应用双开-阿里云盘目录挂载
#"/data/media/999/AliYunPan" "/data/media/0/_Xzhi/目录挂载/阿里云盘"' >"$config_file"
cp -f "$MODPATH/更新配置.sh" "$user_config_dir/更新配置.sh"
