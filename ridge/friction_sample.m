clc
n=1000;

%%%%%%%%%%%% damping training data %%%%%%%%%%%%%
v=linspace(10,10,n); % velocity [m/s]
b=rand(1,n); % damping coefficient [Ns/m]
f_damping=b.*v.^3; % friction force from damping [N]
f_damping_noise=f_damping+0.02*f_damping.*randn(size(f_damping)); % damping with 2% noise

%%%%%%%%%%%% belt pulley friction training data %%%%%%%%%%
a=linspace(pi,pi,n); % angle [rad]
coef_u=rand(); % random coefficient of friction between surface and belt
u=linspace(coef_u,coef_u,n); % constant coefficient of friction between surface and belt
e=linspace(2.718,2.718,n); % euler's number
t1=linspace(20,20,n); % smaller tension force (20 is randomly chosen)
t2=t1.*e.^(u.*a); % larger tension
f_tension=t2-t1; % friction force from belt pulley

f_total=f_damping+f_tension; % combined friction force
f_total_n=f_total+0.02*f_total.*randn(size(f_total)); % with 2% noise

T=table(b(:),v(:),f_damping(:),f_damping_noise(:),a(:),u(:),e(:),t1(:),t2(:),f_tension(:),f_total(:),f_total_n(:));
T.Properties.VariableNames(1:12) = {'damping_coef','velocity','force_damping','force_damping_noise','angle','pulley_coeff','euler_num','tension_small','tension_large','force_tension','force_total','force_total_noise'};
writetable(T,'friction_sample.csv')

%%%%%%%%%%%% damping generalized data %%%%%%%%%%%
g=n/10;
v_g=linspace(10,10,g); % velocity [m/s]
b_g=rand(1,g); % damping coefficient [Ns/m]
f_damping_g=b_g.*v_g.^3; % damping force [N]
f_damping_noise_g=f_damping_g+0.02*f_damping_g.*randn(size(f_damping_g)); % damping with 2% noise

%%%%%%%%%%%% belt pulley friction generalized data %%%%%%%%%%
a_g=linspace(pi,pi,g); % angle [rad]
coef_u_g=coef_u; % random coefficient of friction between surface and belt , same as from test data
u_g=linspace(coef_u_g,coef_u_g,g); % constant coefficient of friction between surface and belt
e_g=linspace(2.718,2.718,g); % euler's number
t1_g=linspace(20,20,g); % smaller tension force (20 is randomly chosen)
t2_g=t1_g.*e_g.^(u_g.*a_g); % larger tension
f_tension_g=t2_g-t1_g; % friction force from belt pulley

f_total_g=f_damping_g+f_tension_g; % combined friction force
f_total_n_g=f_total_g+0.02*f_total_g.*randn(size(f_total_g)); % with 2% noise

T=table(b_g(:),v_g(:),f_damping_g(:),f_damping_noise_g(:),a_g(:),u_g(:),e_g(:),t1_g(:),t2_g(:),f_tension_g(:),f_total_g(:),f_total_n_g(:));
T.Properties.VariableNames(1:12) = {'damping_coef','velocity','force_damping','force_damping_noise','angle','pulley_coeff','euler_num','tension_small','tension_large','force_tension','force_total','force_total_noise'};
writetable(T,'friction_sample_gen.csv')
