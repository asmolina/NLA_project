
addpath(genpath(cd))
clear

file = load('./Urban_F210.mat');
Z = reshape(file.Y, 210, 307, 307);
Z = permute(Z, [1 3 2]);

canal = squeeze(Z(4, :, :));
subplot(1,3,1)
image(canal/max(canal(:))* 255)
colormap(gray)

%X = reshape(file.Y, 307, 307, 210);
X = Z;
X = X/255;
maxP = max(abs(X(:)));
[n1,n2,n3] = size(X);
Xn = X;
rhos = 0;
ind = find(rand(n1*n2*n3,1)<rhos);
Xn(ind) = rand(length(ind), 1);

opts.mu = 1e-4;
opts.tol = 1e-5;
opts.rho = 1.1;
opts.max_iter = 200
opts.DEBUG = 1;

[n1,n2,n3] = size(Xn);
lambda = 1/sqrt(max(n1,n2)*n3);
[Xhat,E,err,iter] = trpca_tnn(Xn,lambda,opts);
 
Xhat = max(Xhat,0);
Xhat = min(Xhat,maxP);
psnr = PSNR(X,Xhat,maxP);

canal_Xn = squeeze(Xn(4, :, :));
subplot(1,3,2)
image(canal_Xn/max(canal_Xn(:))* 255)

canal_res = squeeze(Xhat(4, :, :));
subplot(1,3,3)
image(canal_res/max(canal_res(:))* 255)

save('results.mat', 'Xhat')




