##########################################################################
####                         设置变量参数                             ####

#set atom_1(1) c1r ;#计算原子种类
#set atom_2(1) c1r ;

#set atom_1(2) c1r ;
#set atom_2(2) cl7 ;

#set atom_1(3) cl7 ;
#set atom_2(3) cl7 ;

##########################################################################

set regn_n(1) pore_lft ;
set regn_l(1) 35.0 ;#原子选择区域 [expr $i/10.0]
set regn_h(1) 85.0 ;

set regn_n(2) pore_rgt ;
set regn_l(2) 155.0 ;
set regn_h(2) 205.0 ;

##########################################################################

set frame_n(1) charge ;
set frame_s(1) 200 ;
set frame_e(1) 300 ;

##########################################################################

cd $work_dir($work_dir_i) ;

mol new {./elyt_free_cx.lammpstrj} type {lammpstrj} first 0 last 500 step 1 waitfor all ;#加载分子模型

file mkdir rdf_out

cd rdf_out

set outlog [open rdf.log w+] ;#设置输出日志

for {set i 1} {$i <= 3} {incr i} {
for {set regn_i 1} {$regn_i <= 2} {incr regn_i} {
for {set frame_i 1} {$frame_i <= 1} {incr frame_i} {

set outfile_$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i) [open rdf_$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i).dat w+] ; #设置输出文件

puts $outlog "$atom_1($i)-$atom_2($i)-$regn_n($regn_i)-$frame_n($frame_i) rdf数据计算开始时间为 [clock format [clock seconds] -format %Y-%m-%d\ %H:%M:%S]" ;

set sel1 [atomselect top "name $atom_1($i) and x >= $regn_l($regn_i) and x <= $regn_h($regn_i) and z > 20 and z < 80"] ;
set sel2 [atomselect top "name $atom_2($i)"] ;
set gr0 [measure rdf $sel1 $sel2 delta 0.1 rmax 16.0 usepbc 1 selupdate 1 first $frame_s($frame_i) last $frame_e($frame_i) step 1] ;
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

}
}
}

close $outlog ;
set mol_id [molinfo top] ;#删除分子模型
mol delete $mol_id ;


#cd .. ;#回到上级工作目录
##########################################################################
