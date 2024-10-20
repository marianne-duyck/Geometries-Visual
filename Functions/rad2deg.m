function angleInDegrees = rad2deg(angleInRadians)
% DEG2RAD Convert angles from degrees to radians
%
%   DEG2RAD has been replaced by DEGTORAD.
%
%   angleInRadians = DEG2RAD(angleInDegrees) converts angle units from
%   degrees to radians.

% Copyright 2007-2009 The MathWorks, Inc.
% $Revision: 1.9.4.5 $  $Date: 2009/04/15 23:16:12 $

angleInDegrees = (180/pi) * angleInRadians;
