
cd E:\\Calculate_data\\lmp@2D_Layer_Dynamic\\20180516-work\\tcl

##########################################################################
####                         设置工作路径目录                         ####

array set work_dir [list {1} {E:\\Calculate_data\\lmp@2D_Layer_Dynamic\\20180516-work\\20171012-Ti3C2X2-Gra-4layer-RTIL-Free-fix\\lmp-3_run_Gra_EMIM-Cl-c0-c120-10A-fix}] 

##########################################################################
####                         设置变量参数                             ####

set atom_1(1) c1w ;#计算原子种类
set atom_2(1) c1w ;

set atom_1(2) c1w ;
set atom_2(2) cl7 ;

set atom_1(3) cl7 ;
set atom_2(3) cl7 ;

##########################################################################

set regn_n(1) lft_pore ;
set regn_l(1) 35 ;#原子选择区域 [expr $i/10.0]
set regn_h(1) 85 ;

set regn_n(2) bulk ;
set regn_l(2) 95 ;
set regn_h(2) 145 ;

set regn_n(3) rgt_pore ;
set regn_l(3) 155 ;
set regn_h(3) 205 ;

##########################################################################

set frame_n(1) neutral ;
set frame_s(1) 1 ;
set frame_e(1) -1 ;

set frame_n(1) ngt_crg ;
set frame_s(2) 1 ;
set frame_e(3) -1 ;

set frame_n(3) pst_crg ;
set frame_s(3) 1 ;
set frame_e(3) -1 ;

##########################################################################

foreach work_dir_i [array names work_dir] {

#for {set work_dir_i 2} {$work_dir_i <= 35} {incr work_dir_i 1} 

cd $work_dir($work_dir_i) ;

#mol new {./all_fix_c0.lammpstrj} type {lammpstrj} first 0 last -1 step 1 waitfor all ;#加载分子模型

file mkdir rdf_out

cd rdf_out

for {set i 1} {$i < 4} {incr i} {
for {set regn_i 1} {$regn_i < 3} {incr regn_i} {
for {set frame_i 1} {$frame_i < 2} {incr frame_i} {

set outfile_set_$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i) [open rdf_$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i).dat w] ;#设置输出文件
close [append outfile_set_$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i)] ;

set outlog_set [open rdf.log w] ;#设置输出日志
close $outlog_set ;

set outfile_$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i) [open rdf_$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i).dat a] ;
set outlog [open rdf.log a] ;

puts $outlog "$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i) rdf数据计算开始时间为 [clock format [clock seconds] -format %Y-%m-%d\ %H:%M:%S]" ;

set sel1 [atomselect top "name $atom_1($i) and x >= $regn_l($regn_i) and x <= $regn_h($regn_i) and z > 20 and z < 80"] ;
set sel2 [atomselect top "name $atom_2($i)"] ;
set gr0 [measure rdf $sel1 $sel2 delta 0.1 rmax 12.0 usepbc 1 selupdate 1 first $frame_s($frame_i) last $frame_e($frame_i) step 1] ;
set r [lindex $gr0 0] ;
set gr [lindex $gr0 1] ;
set igr [lindex $gr0 2] ;

foreach j $r k $gr l $igr {
  puts [append outfile_$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i)] [format "%.4f\t%.4f\t%.4f" $j $k $l] ;
}

$sel1 delete ;#删除原子选择群，释放内存，此步骤极重要，以后写脚本谨记！
$sel2 delete ;

puts $outlog "$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i) rdf数据计算结束时间为 [clock format [clock seconds] -format %Y-%m-%d\ %H:%M:%S]" ;

close [append outfile_$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i)] ;
close $outlog ;

}
}
}

set mol_id [molinfo top] ;#删除分子模型
mol delete $mol_id ;

}

#cd .. ;#回到上级工作目录
##########################################################################
