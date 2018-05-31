
set tcl_path C:/Users/RTS-Kui/Documents/GitHub/VMD-RDF

##########################################################################
####                         设置工作路径目录                         ####

array set work_dir [list {1} {E:/Calculate_data/lmp@2D_Layer_Dynamic/20180516-work/20171012-Ti3C2X2-Gra-4layer-RTIL-Free-fix/lmp-3_run_Gra_EMIM-OTF-c0-c120-10A-fix} \
                         {2} {E:/Calculate_data/lmp@2D_Layer_Dynamic/20180516-work/20171012-Ti3C2X2-Gra-4layer-RTIL-Free-fix/lmp-3_run_Ti3C2F2_EMIM-OTF-c0-c120-10A-fix} \
                         {3} {E:/Calculate_data/lmp@2D_Layer_Dynamic/20180516-work/20171012-Ti3C2X2-Gra-4layer-RTIL-Free-fix/lmp-3_run_Ti3C2O2_EMIM-OTF-c0-c120-10A-fix} \
                         {4} {E:/Calculate_data/lmp@2D_Layer_Dynamic/20180516-work/20171012-Ti3C2X2-Gra-4layer-RTIL-Free-fix/lmp-3_run_Ti3C2OH2_EMIM-OTF-c0-c120-10A-fix} ] 

##########################################################################
####                         设置变量参数                             ####

set atom_1(1) c1w ;#计算原子种类
set atom_2(1) c1w ;

set atom_1(2) c1w ;
set atom_2(2) s4o ;

set atom_1(3) s4o ;
set atom_2(3) s4o ;

##########################################################################

foreach work_dir_i [array names work_dir] {
#for {set work_dir_i 2} {$work_dir_i <= 35} {incr work_dir_i 1} 

cd $tcl_path
source rdf-charge.tcl

cd $tcl_path
source rdf-neutral.tcl

}