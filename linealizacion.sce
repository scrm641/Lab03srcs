/////////////////////////////////////////////////////////////////////////////
// Linearization with xcos
/////////////////////////////////////////////////////////////////////////////
loadXcosLibs(); loadScicos();
importXcosDiagram("C:\Users\Mrcs641\Desktop\2021 - II\SCA GA\Labs\Lab03\srcs-docs/sample.xcos");
typeof(scs_m)
scs_m.props.context;
// specific context data
Ao1 = 3.1669*    0.00001
Ao2 = 1.78139*   0.00001
At1 = 1.55179*   0.001
At2 = 1.55179*   0.001
g = 9.8
kp = 3.3*        0.000001; 
k1 = kp/At1;
k2 = Ao1*sqrt(2*g)/At1;
k3 = Ao1*sqrt(2*g)/At2;
k4 = Ao2*sqrt(2*g)/At2;
// looking for the Superblock to linearize
for i=1:length(scs_m.objs)
    if typeof(scs_m.objs(i))=="Block" & scs_m.objs(i).gui=="SUPER_f" then
        scs_m = scs_m.objs(i).model.rpar;
        break;
    end
end
sys = lincos(scs_m);
