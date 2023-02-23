function [] = project_gk();
for I=1:3
    tic
    % problem setup 
    Lx = 1;  %length of x grid 
    Ly = Lx; % length of y grid
    nx = 21; % number of nodes in x- direction
    ny = nx; %number of nodes in y- direction 
    dx = Lx/(nx-1); % step size for spatial x-cord
    dy = Ly/(ny-1); % step size for spatial y-cord
    tol = 0.1;  %error criteria 
    error = 9e9; %initialising error 
    k=0;  %initialising iteration
   % creating 1D and 2D grid 
   x = linspace(0,Lx,nx);   %1d x grid 
   y = linspace(0,Ly,ny);   %1d y grid
   [x y] = meshgrid(x,y);   %2d x-y grid
  % initialising temperature array and BC 
  T = zeros(nx,ny);   %initial condition array 
  % BC
 T(1:ny,ny)= 200+100*(sin(pi*y(:,1))) ;        
T(1:ny,1)= 200+100*y(:,1)   
T(nx,1:nx)= 200*x(1,:) ;        
T(1,1:nx)= 100*(1+x(1,:)) ;      
  %creating a copy of temperature array after BC
  Told = T; 
  while error > tol   %while loop runs untill error > tolerance value 
      for i = 2:nx-1  %for loop runs for x values from 2 to last node -1 
          for j = 2:ny-1 %for loop runs for y value form 2 to last node -1 
              %iterative solver 
              if I== 1 %jacobi 
                  figure(1)
                  T(i,j) = 0.25*(Told(i-1,j) + Told(i+1,j) + Told(i,j-1) + Told(i,j+1));
              end 
          end 
      end
      error_T = max(abs(Told - T));  %calculating error to decide wether while loop should stop or not 
  error = max(error_T);    %calculating maximum error between absolute value of old arry T and new arry of T 
  Told = T;   %updating temperature array for next iteration 
  k = k+1;    %incrementing iterations by 1 
  % contour map 
  [C, h] = contourf(x,y,T);           %contourf function used 
  clabel(C, h,'FontSize',8,'FontWeight','bold','color','k') 
  xlabel('spatial X -coordinate','FontSize',12)
  ylabel('spatial Y -coordinate','FontSize',12)
  title (sprintf('Temperature distribution on a %d x %d gridn using Jacobi method at iteration no %d', Lx, Ly, k),'FontSize',10)
  pause(0.003)
  end
end