
addpath(genpath(cd))
clear

orig_file = load('./Urban_F210.mat');
Z = reshape(orig_file.Y, 210, 307, 307);
Z = permute(Z, [1 3 2]);

orig_canal = squeeze(Z(100, :, :));
subplot(1,3,1)
image(orig_canal/max(orig_canal(:))* 255)
colormap(gray)

res_file = load('./results.mat');
Z = res_file.Xhat;

res_canal = squeeze(Z(100, :, :));
subplot(1,3,2)
image(res_canal/max(res_canal(:))* 255)

diff = res_canal - orig_canal;
subplot(1,3,3)
image(diff/max(diff(:))* 255)


