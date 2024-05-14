% Yelyzaveta Ilman 341387; Zadanie 2

% funkcja gęstości rozkładu chi-kwadrat (bez stałej)
function y = chi_squared_pdf(x, k)
    y = x.^(k/2 - 1) .* exp(-x/2);
end

% obliczanie dystrybuanty(simpson) oraz dzielenie przez stałą
function distribution = chi_squared_cdf(x, k)
    distribution = zeros(size(x));
    for i = 1:length(x)
        distribution(i) = simpson(0, x(i), @(t) chi_squared_pdf(t, k), 100) / (gamma(k/2) * exp(k/2 * log(2)));
    end
end

% Implementacja metody Simpsona do całkowania
function y = simpson(a, b, f, n)
    if (n < 2) || mod(n,2)
        disp('Liczba przedziałów musi być parzysta oraz >= 2.')
        return
    end

    h = (b - a) / n;
    y = feval(f, a) + feval(f, b);

    for i = 1 : n-1
        if mod(i,2)
            y = y + 4 * feval(f, a + i*h);
        else
            y = y + 2 * feval(f, a + i*h);
        end
    end

     y = h * y / 3;
end


% Przykładowe użycie:
x = 0.5;
k = 3;
disp(chi_squared_cdf(x, k));
