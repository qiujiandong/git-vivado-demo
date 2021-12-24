# 使用Git管理Vivado工程
## 系统环境
 - Win10
 - Vivado 2019.2
## 工程管理
 - 将用户编写的文件、build.tcl放在和Vivado工程相同的目录下
 - 从Vivado工程中导出build.tcl
   - 导出时勾选复制文件，不要选“Recreate Block Design using Tcl”
 - 导出用于生成Block Design的Tcl脚本
 - 改写build.tcl

## 需要改写的内容
 - origin_dir
   - 虽然origin_dir默认就是当前目录，但为了防止有人在别的路径执行该脚本而产生错误，需要做以下更改
```tcl
set origin_dir "."
```
&emsp;&emsp;-->
```tcl
set origin_dir [file dirname [info script]]
```
 - create_project 的路径
   - 默认的路径是当前路径，比较合理的应该改为当前脚本所在的路径，即$origin_dir
```tcl
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7vx690tffg1927-2
```
&emsp;&emsp;-->
```tcl
create_project ${_xil_proj_name_} $origin_dir/${_xil_proj_name_} -part xc7vx690tffg1927-2
```
 - 将import Block Desigin 相关的命令用source Block Design的Tcl脚本来替换
 - 如有需要的话可以用make_wrapper命令将Block Desigin打包


```tcl
# create block design
source $origin_dir/src/bd/git_vivado_demo_bd.tcl; # use your bd tcl name

# create wrapper
make_wrapper -files [get_files $design_name.bd] -top -import
```
