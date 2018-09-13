e0=8.8542*10^(-12); %Permittivity of free space [F/m]
e1=9.5000; %Dielectric constant of material 1
e2=9.3750; %Dielectric constant of material 2
d1=2*10^(-9); %Thickness of material 1 [m]
d2=25*10^(-9); %Thickness of material 2 [m]

N=round((d1+d2)*10^10)+1;
dx=(d1+d2)/(N-1); 
A=zeros(N,N);
b=zeros(N,1);
E=zeros(N-1,1);

b(N,1)=1.0;
A(1,1)=1.0;
for n=2:N-1
    if n<=d1/dx
    A(n,n-1)=e1;              
    A(n,n+1)=e1;
    A(n,n)=-2*e1;
    elseif n>d1/dx
    A(n,n-1)=e2;              
    A(n,n+1)=e2;
    A(n,n)=-2*e2;
    end
end
    n=round(d1/dx+1);
    A(n,n-1)=e1;
    A(n,n)=-e1-e2;
    A(n,n+1)=e2;
    
A(N,N)=1.0;
x=A\b; 
for n=1:N-1
   E(n,1)=(x(n+1,1)-x(n,1))/dx; 
end

C1=2*e0*e1*E(1,1)*10^(-4); % numerical capacitance 1 [F/cm^2]
C2=2*e0*e2*E(N-1,1)*10^(-4); %numerical capacitance 2 [F/cm^2]
Cn=(C1*C2)/(C1+C2); % numerical total capacitance [F/cm^2]
Ca=(e0*e1/d1*e0*e2/d2)/(e0*e1/d1+e0*e2/d2)*10^(-4); % analytic total capacitance [F/cm^2]
