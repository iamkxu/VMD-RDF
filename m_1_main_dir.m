%%
%clc;clear;

%% load the data

system_info.data_path = 'E:\Calculate_data\lmp@2D_Layer_Dynamic\20180516-work\20171012-Ti3C2X2-Gra-4layer-RTIL-Free-fix'; 

cd(system_info.data_path);
system_info.dir_name = cellstr(ls);

system_info.electrode = {'Gra','Ti3C2F2','Ti3C2O2','Ti3C2OH2'};
system_info.cation    = {'EMIM'};
system_info.anion     = {'Cl','BF4','OTF','FSI','TFSI'};

n_eld = size(system_info.electrode,2);
n_cat = size(system_info.cation,2); 
n_ani = size(system_info.anion,2);

for i_eld = 1:n_eld
for i_cat = 1:n_cat
for i_ani = 1:n_ani
    
    dir_name_pattern = ['[\w-]*',system_info.electrode{i_eld,1},'[_-]',system_info.cation{i_cat,1},'[_-]',system_info.anion{i_ani,1},'[\w-]*','(?<!out)$'];                    
    dir_name_regexp  = regexp(dir_name,dir_name_pattern,'match');
    dir_length = size(dir_name_regexp,1);

    for i_length = 1:dir_length
        if  ~isempty(dir_name_regexp{i_length,1}) && isdir(dir_name_regexp{i_length,1}{1,1})
            disp(dir_name_regexp{i_length,1}{1,1});
            cd(dir_name_regexp{i_length,1}{1,1});            
            m_2_plot_rdf_figure;
        end
    end 
end
end
end
    


system_info.data_out  = strcat(system_info.data_path,'_out'); 
cd(system_info.data_out);

load m_data_out-c0.mat -regexp '^(?!system)...';



cd(system_info.data_path);
