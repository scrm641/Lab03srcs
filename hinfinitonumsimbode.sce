
A=[-136.41096,90.350266 ;0,-90.350266 ]

B=[0;0.0021266]

C=[1,0]

D=[0]


s = poly(0, "s");
P= syslin('c',0.1921367 + 2.842D-14*s, 12324.766 + 266.76122*s + s^2);
P1= syslin('c',1, s^2+2*s+1);
Pkc= P*P1;

// Rendimiento
a=0.0002; m=2; wb=100;
wp_n=((1/m)*s+wb);
wp_d=(s+wb*a);
wp = syslin('c',wp_n,wp_d);
wt_d=2*(s/1000 + 1);
wt_n=s/300+1;
wt = syslin('c',wt_n,wt_d);

// Funcion de Ponderacion
figure(1);
subplot(211), gainplot(1/wp);
ylabel('Magnitud(dB)');
title('Peso - S');
subplot(212), gainplot(1/wt);
ylabel('Magnitud (dB)');
title('Peso - S');

//////////////////////////////////////

[A,B,C,D]=abcd(P);
[A1,B1,C1,D1]=abcd(wp);
[A2,B2,C2,D2]=abcd(wt);

Aa=[A zeros(size(A,1),size(A1,2)) zeros(size(A,1),size(A2,2));
    -B1*C A1 zeros(size(A1,1),size(A2,2));
    B2*C zeros(size(A2,1),size(A1,2)) A2];
Bb = [zeros(size(B,1),size(B1,2)) B; 
        B1 zeros(size(B1,1),size(Bp,2));
        zeros(size(B2,1),size(B1,2)) zeros(size(B2,1),size(B,2))];
Cc = [-D1*C C1 zeros(size(C1,1),size(C2,2));
        zeros(size(C2,1),size(C,2)) zeros(size(C2,1),size(C1,2)) C2;
        -C zeros(size(C,1),size(C1,2)) zeros(size(C,1),size(C2,2))];
Dd = [D1 0.001; 0 D2;1 0];  

[Ak,Bk,Ck,Dk]=hinf(Aa,Bb,Cc,Dd,1,0,5);
Sk=syslin('c',Ak,Bk,Ck,Dk);

L = Pkc;
Y=1/(1+L);
T = 1-Y;
[Acl,Bcl,Ccl,Dcl]=abcd(T);
figure(2)
gainplot(Y);
figure(3)
gainplot(T);