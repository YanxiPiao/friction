clc
clear all

%%%%%%%%%%%initialization%%%%%%%%
n=80; %number of data points

%entry_tension_min=10;  %minimum entry tension [kN]
%entry_tension_max=100;    %maximum entry tension
%entry_tension=entry_tension_min+(entry_tension_max-entry_tension_min)*rand(n,1);
entry_tension=linspace(10,100,n)';

friction_coeff_min=0.5; %minimum friction coefficient
friction_coeff_max=0.55; %maximum friction coefficient
friction_coeff=friction_coeff_min+(friction_coeff_max-friction_coeff_min)*rand(n,1);
friction_coeff=linspace(0.5,0.5,n)';


pulley_r=[30*ones(n,1)];

envelop_angle=linspace(30,30,n)';
%envelop_angle=envelop_angle';

%pulley_bearing_r=randi([30,40],n,1);
pulley_bearing_r=30;

exit_tension=entry_tension.*(1+2*friction_coeff.*(pulley_bearing_r./pulley_r).*sin(envelop_angle./2));

col_header={'entry_tension','friction_coefficient','radius_of_pulley','envelop_angle','exit_tension'};
xlswrite('data.xlsx',col_header,'Sheet1','A1');
xlswrite('data.xlsx',[entry_tension(:),friction_coeff(:),pulley_r(:),envelop_angle(:),exit_tension(:)],'Sheet1','A2');

%variation in input and output graph
%python data analysis pipeline

figure
plot(envelop_angle,exit_tension)
title('entry vs exit tension')
xlabel('entry tension')
ylabel('exit tension')
