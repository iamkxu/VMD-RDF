%%
%clc;clear;

%% load the data

cd('rdf_out');

n_eld = system_info.electrode{1,i_eld};
n_cat = system_info.cation{1,i_cat};
n_ani = system_info.anion{1,i_ani};

if strcmp(n_cat,'EMIM')
    com_cat = 'c1w';
end

if strcmp(n_ani,'Cl')
    com_ani = 'cl7';
elseif strcmp(n_ani,'BF4')
    com_ani = 'b6b';
elseif strcmp(n_ani,'OTF')
    com_ani = 's4o';
elseif strcmp(n_ani,'FSI')
    com_ani = 'n5f';
elseif strcmp(n_ani,'TFSI')
    com_ani = 'n2t';
end
            
rdf.CationCationBulkNeutral =   load(strcat('rdf_',com_cat,'-',com_cat,'-bulk-neutral.dat'));        
rdf.CationCationPoreNeutral =   load(strcat('rdf_',com_cat,'-',com_cat,'-pore-neutral.dat'));        
rdf.CationCationPorelftCharge = load(strcat('rdf_',com_cat,'-',com_cat,'-pore_lft-charge.dat'));  
rdf.CationCationPorergtCharge = load(strcat('rdf_',com_cat,'-',com_cat,'-pore_rgt-charge.dat'));  
rdf.CationAnionBulkNeutral =    load(strcat('rdf_',com_cat,'-',com_ani,'-bulk-neutral.dat'));   
rdf.CationAnionPoreNeutral =    load(strcat('rdf_',com_cat,'-',com_ani,'-pore-neutral.dat'));
rdf.CationAnionPorelftCharge =  load(strcat('rdf_',com_cat,'-',com_ani,'-pore_lft-charge.dat')); 
rdf.CationAnionPorergtCharge =  load(strcat('rdf_',com_cat,'-',com_ani,'-pore_rgt-charge.dat')); 
rdf.AnionAnionBulkNeutral =     load(strcat('rdf_',com_ani,'-',com_ani,'-bulk-neutral.dat')); 
rdf.AnionAnionPoreNeutral =     load(strcat('rdf_',com_ani,'-',com_ani,'-pore-neutral.dat'));
rdf.AnionAnionPorelftCharge =   load(strcat('rdf_',com_ani,'-',com_ani,'-pore_lft-charge.dat'));  
rdf.AnionAnionPorergtCharge =   load(strcat('rdf_',com_ani,'-',com_ani,'-pore_rgt-charge.dat'));  

%% plot the figure

figure_CC = figure;

plot(rdf.CationCationBulkNeutral(:,1),rdf.CationCationBulkNeutral(:,2),'DisplayName',strcat(n_cat,'-',n_cat,'-bulk-neutral'));
hold on
plot(rdf.CationCationPoreNeutral(:,1),rdf.CationCationPoreNeutral(:,2),'DisplayName',strcat(n_cat,'-',n_cat,'-pore-neutral'));
plot(rdf.CationCationPorelftCharge(:,1),rdf.CationCationPorelftCharge(:,2),'DisplayName',strcat(n_cat,'-',n_cat,'-pore-negaitve-charge'));
plot(rdf.CationCationPorergtCharge(:,1),rdf.CationCationPorergtCharge(:,2),'DisplayName',strcat(n_cat,'-',n_cat,'-pore-positive-charge'));

title(strcat('rdf-',n_eld,'-','Cation-Cation'));
ylabel('g(r)');
xlabel('r / Ang');
legend('show');

savefig(figure_CC,strcat('m_rdf_',n_eld,'-',n_cat,n_ani,'Cation-Cation','.fig'));
print(figure_CC,'-dpng',strcat('m_rdf_',n_eld,'-',n_cat,n_ani,'Cation-Cation','.png'));

%%

figure_CA = figure;

plot(rdf.CationAnionBulkNeutral(:,1),rdf.CationAnionBulkNeutral(:,2),'DisplayName',strcat(n_cat,'-',n_ani,'-bulk-neutral'));
hold on
plot(rdf.CationAnionPoreNeutral(:,1),rdf.CationAnionPoreNeutral(:,2),'DisplayName',strcat(n_cat,'-',n_ani,'-pore-neutral'));
plot(rdf.CationAnionPorelftCharge(:,1),rdf.CationAnionPorelftCharge(:,2),'DisplayName',strcat(n_cat,'-',n_ani,'-pore-negaitve-charge'));
plot(rdf.CationAnionPorergtCharge(:,1),rdf.CationAnionPorergtCharge(:,2),'DisplayName',strcat(n_cat,'-',n_ani,'-pore-positive-charge'));

title(strcat('rdf-',n_eld,'-','Cation-Anion'));
ylabel('g(r)');
xlabel('r / Ang');
legend('show');

savefig(figure_CA,strcat('m_rdf_',n_eld,'-',n_cat,n_ani,'Cation-Anion','.fig'));
print(figure_CA,'-dpng',strcat('m_rdf_',n_eld,'-',n_cat,n_ani,'Cation-Anion','.png'));

%%
figure_AA = figure;

plot(rdf.AnionAnionBulkNeutral(:,1),rdf.AnionAnionBulkNeutral(:,2),'DisplayName',strcat(n_ani,'-',n_ani,'-bulk-neutral'));
hold on
plot(rdf.AnionAnionPoreNeutral(:,1),rdf.AnionAnionPoreNeutral(:,2),'DisplayName',strcat(n_ani,'-',n_ani,'-pore-neutral'));
plot(rdf.AnionAnionPorelftCharge(:,1),rdf.AnionAnionPorelftCharge(:,2),'DisplayName',strcat(n_ani,'-',n_ani,'-pore-negaitve-charge'));
plot(rdf.AnionAnionPorergtCharge(:,1),rdf.AnionAnionPorergtCharge(:,2),'DisplayName',strcat(n_ani,'-',n_ani,'-pore-positive-charge'));

title(strcat('rdf-',n_eld,'-','Anion-Anion'));
ylabel('g(r)');
xlabel('r / Ang');
legend('show');

savefig(figure_AA,strcat('m_rdf_',n_eld,'-',n_cat,n_ani,'Anion-Anion','.fig'));
print(figure_AA,'-dpng',strcat('m_rdf_',n_eld,'-',n_cat,n_ani,'Anion-Anion','.png'));

cd ..
%%




