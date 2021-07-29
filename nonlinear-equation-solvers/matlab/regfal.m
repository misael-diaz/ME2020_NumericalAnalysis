% Applied Numerical Analysis                                 July 26, 2021
% ME 2020 FA21
% Prof. M Diaz-Maldonado
%
%
% Synopsis:
% Possible implementation of the Regula Falsi method in MATLAB.
% 
%
% Copyright (c) 2021 Misael Diaz-Maldonado
% This file is released under the GNU General Public License as published
% by the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
%
% References:
% [0] A Gilat and V Subramanian, Numerical Methods for Engineers and
%    Scientists: An Introduction with Applications using MATLAB
% [1] A Gilat, MATLAB: An Introduction with Applications, 6th edition
%


function x = regfal(a, b, f, opt)
%    Synopsis:
%    Regula Falsi Method. Finds the root of the function f(x) enclosed by
%    the interval [a, b].
%
%    inputs:
%    a            lower bound
%    b            upper bound
%    f            nonlinear function, f(x)
%
%    output:
%    x            approximate value of the root if successful.


% sets default values for the tolerance and maximum number of iterations
TOL      = 1.0e-8;
MAX_ITER = 100;

if ( exist('opt', 'var') )
    % uses configuration struct if passed
    TOL      = opt.tol;
    MAX_ITER = opt.max_iter;
end

if (a > b)
    % bounds check
    up = a;
    a  = b;
    b  = up;
end


if ( f(a) * f(b) > 0 )
    % complains if there's no root in the given interval    
    errID  = 'NonlinearSolver:BracketingException';
    errMSG = 'No roots exists in the given interval [a, b]';
    except = MException(errID, errMSG);
    throw(except);
    return
end


n = 1;
x = ( a * f(b) - b * f(a) ) / ( f(b) - f(a) );
while ( n ~= MAX_ITER && abs( f(x) ) > TOL )

    % updates the bracketing interval
    if ( f(a) * f(x) < 0 )
        b = x;
    else
        a = x;
    end

    x = ( a * f(b) - b * f(a) ) / ( f(b) - f(a) );
    n = n + 1;
end


if ( n ~= MAX_ITER )
    fprintf('>> Solution found in %d iterations\n', n)
else
    fprintf('>> maximum number of iterations reached, ')
    fprintf('try again with a narrower interval\n')
end

return
