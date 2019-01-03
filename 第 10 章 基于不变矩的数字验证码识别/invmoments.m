function res = invmoments(x)

x = double(x);
[M,N,~] = size(x);
[X,Y] = meshgrid(1:M, 1:N);
X = X(:);
Y = Y(:);
x = x(:);
m.m00 = sum(x);
m.m10 = sum(X.*x);
m.m01 = sum(Y.*x);
m.m11 = sum(X.*Y.*x);
m.m20 = sum(X.^2.*x);
m.m02 = sum(Y.^2.*x);
m.m30 = sum(X.^3.*x);
m.m03 = sum(Y.^3.*x);
m.m12 = sum(X.*Y.^2.*x);
m.m21 = sum(X.^2.*Y.*x);
xbar = m.m10/m.m00;
ybar = m.m01/m.m00;
e.hp11 = (m.m11 - ybar*m.m10) / m.m00^2;
e.hp20 = (m.m20 - xbar*m.m10) / m.m00^2;
e.hp02 = (m.m02 - ybar*m.m01) / m.m00^2;
e.hp30 = (m.m30 - 3*xbar*m.m20 + 2*xbar^2*m.m10) / m.m00^2.5;
e.hp03 = (m.m03 - 3*ybar*m.m02 + 2*ybar^2*m.m01) / m.m00^2.5;
e.hp21 = (m.m21 - 2*xbar*m.m11 -ybar*m.m20 + 2*xbar^2*m.m01) / m.m00^2.5;
e.hp12 =  (m.m12 - 2*ybar*m.m11 -xbar*m.m02 + 2*ybar^2*m.m10) / m.m00^2.5;
res(1) = e.hp20 + e.hp02;
res(2) = (e.hp20 - e.hp02)^2 + 4*e.hp11^2;
res(3) = (e.hp30 - 3*e.hp12)^2 + (3*e.hp21 - e.hp03)^2;
res(4) = (e.hp30 + e.hp12)^2 + (e.hp21 + e.hp03)^2;
res(5) = (e.hp30 - 3*e.hp12)*(e.hp30 + e.hp12)*...
    ((e.hp30 + e.hp12)^2 - 3*(e.hp21 + e.hp03)^2)+...
    (3*e.hp21 - e.hp03)*(e.hp21 + e.hp03)*...
    (3*(e.hp30 + e.hp12)^2 - (e.hp21 + e.hp03)^2);
res(6) = (e.hp20 - e.hp02) * ((e.hp30 + e.hp12)^2-...
    (e.hp21 + e.hp03)^2)+...
    4*e.hp11*(e.hp30 + e.hp12)*(e.hp21 + e.hp03);
res(7) = (3*e.hp21 - e.hp03) * (e.hp30 + e.hp12) * ...
    ( (e.hp30 + e.hp12)^2 - 3*(e.hp21 + e.hp03)^2) +...
    (3*e.hp12 - e.hp30)*(e.hp21 + e.hp03)*...
    (3*(e.hp30 + e.hp12)^2 - (e.hp21 + e.hp03)^2);