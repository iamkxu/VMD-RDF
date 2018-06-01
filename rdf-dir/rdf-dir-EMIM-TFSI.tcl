
set tcl_path C:/Users/RTS-Kui/Documents/GitHub/VMD-RDF

##########################################################################
####                         ���ù���·��Ŀ¼                         ####

array set work_dir [list {1} {E:/Calculate_data/lmp@2D_Layer_Dynamic/20180516-work/20171012-Ti3C2X2-Gra-4layer-RTIL-Free-fix/lmp-3_run_Gra_EMIM-TFSI-c0-c120-10A-fix} \
                         {2} {E:/Calculate_data/lmp@2D_Layer_Dynamic/20180516-work/20171012-Ti3C2X2-Gra-4layer-RTIL-Free-fix/lmp-3_run_Ti3C2F2_EMIM-TFSI-c0-c120-10A-fix} \
                         {3} {E:/Calculate_data/lmp@2D_Layer_Dynamic/20180516-work/20171012-Ti3C2X2-Gra-4layer-RTIL-Free-fix/lmp-3_run_Ti3C2O2_EMIM-TFSI-c0-c120-10A-fix} \
                         {4} {E:/Calculate_data/lmp@2D_Layer_Dynamic/20180516-work/20171012-Ti3C2X2-Gra-4layer-RTIL-Free-fix/lmp-3_run_Ti3C2OH2_EMIM-TFSI-c0-c120-10A-fix} ] 

##########################################################################
####                         ���ñ�������                             ####

set atom_1(1) c1r ;#����ԭ������
set atom_2(1) c1r ;

set atom_1(2) c1r ;
set atom_2(2) n2t ;

set atom_1(3) n2t ;
set atom_2(3) n2t ;

##########################################################################

foreach work_dir_i [array names work_dir] {
#for {set work_dir_i 2} {$work_dir_i <= 35} {incr work_dir_i 1} 

cd $tcl_path
source rdf-charge.tcl

cd $tcl_path
source rdf-neutral.tcl

}