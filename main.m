%main
clc
clear all
close all

A = double(rand(9)>0.5);
r_A = rank(A);
fprintf('rank a: %d\n',r_A)
k = max(2,r_A-2);
fprintf('k: %d\n',k)

D = SamplingAlgorithm(A,k,0.05);
r_D = rank(D);
fprintf('rank D: %d\n',r_D)

AD = A-D;
disp(sum(AD.*AD,'all'))