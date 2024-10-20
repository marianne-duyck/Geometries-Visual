function x = redgreencmap(n)
%x = redgreencmap(n)
% n = nb of levels
% did same as in default version of matlab 2015: tanh shape

t = 2*pi*(-1:(2/(n-1)):1);
x = [(tanh(t)')/2+0.5 0.5-tanh(t)'/2 zeros(n,1)];

end

