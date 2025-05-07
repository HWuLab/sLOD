function p_value_chi = chitest(n_A,S_A,n_B,S_B)
% chi-squared test
% 
F_A = n_A - S_A; % Num of A failed
F_B = n_B - S_B; % Num of B failed

% prop of successed
p_A = S_A / n_A;
p_B = S_B / n_B;

p_hat = (S_A + S_B) / (n_A + n_B);

% calc SE
SE = sqrt(p_hat * (1 - p_hat) * (1/n_A + 1/n_B));

% calc Z
Z = (p_B - p_A) / SE;

obs = [S_A, F_A; S_B, F_B]; % 2x2
[~, p_value_chi, stats] = chi2gof(obs(:), 'Expected', mean(obs(:)) * ones(size(obs(:))), 'NParams', 1);

