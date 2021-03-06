clear, clc;

% This is an example for running the function sgLeastR
%
%  Problem:
%
%  min  1/2 || A x - y||^2 + z_1 \|x\|_1 + z_2 * sum_j w_j ||x_{G_j}||
%
%  G_j's are the non-overlapping groups
%
%    we apply L1 for each element
%    and the L2 for the non-overlapping group 
%
%  The group information is contained in
%  opts.ind, which is a 3 x nodes matrix, where nodes denotes the number of
%  nodes of the tree.
%  opts.ind(1,:) contains the starting index
%  opts.ind(2,:) contains the ending index
%  opts.ind(3,:) contains the corresponding weight (w_j)
%
%% Related papers
%
% [1] Jun Liu and Jieping Ye, Moreau-Yosida Regularization for 
%     Grouped Tree Structure Learning, NIPS 2010

cd ..
cd ..

root=cd;
addpath(genpath([root '/SLEP']));
                     % add the functions in the folder SLEP to the path
                   
% change to the original folder
cd Examples/sgLasso;

m=50;  n=100;       % The data matrix is of size m x n

%randNum=10;           % a random number

% ---------------------- generate random data ----------------------
%randn('state',(randNum-1)*3+1);
A=randn(m,n);        % the data matrix

%randn('state',(randNum-1)*3+2);
xOrin=full(sprandn(n, 1,1));
xOrin(1:50,:)=0;

%randn('state',(randNum-1)*3+3);
noise=randn(m,1);
y=A*xOrin +...
    noise*0.01;      % the response

%----------------------- Set optional items -----------------------
opts=[];

% Starting point
opts.init=2;        % starting from a zero point

% Termination 
opts.tFlag=5;       % run .maxIter iterations
opts.maxIter=100;   % maximum number of iterations

% regularization
opts.rFlag=1;       % use ratio

% Normalization
opts.nFlag=0;       % without normalization

% Group Property
opts.ind=[ [1, 20, sqrt(20)]', [21, 40, sqrt(20)]',...
    [41, 50, sqrt(10)]', [51, 70, sqrt(20)]', [71,100, sqrt(30)]'];

%----------------------- Run the code -----------------------
z=[0.1,0.1];
tic;
[x1, funVal1, ValueL]= sgLeastR(A, y, z, opts);
toc;

a=xOrin~=0;
b=x1~=0;
c=a.*b;


