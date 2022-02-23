% Skript som plotter banen til en tenkt partikkel
% Input: 
% x0 - Startposisjon
% dt - Oppdelinga i td (bestemmer farten som simuleringa vises med)
% tMax - Hvor lenge simuleringa skal vare
% Na - antall punkter i x - for plottinga
% Landskap
f =@(x) x.^2;
fig = figure(1);
xlabel("X-axis",'fontsize',16,'color','b');
ylabel("Y-axis",'fontsize',16,'color','b');
title("Simulating of sliding",'fontsize',16,'color','r');

% X-posisjon som funksjon av tid
x0 = 4.8;             % Startposisjon
Vx0 =0;                %Start av farten
% Oppl�sninga i tid - steglengda - og varigheten av simuleringa
dt = 0.01;
tMax=10;
t=0;                % Start-tid
% mot venstre
X =x0;
h = 0.001;
g = 9.81; 
M =0.1;
presisjon = 1e-4;
Vx = 0.1;                  %Steglengde (blir endra inne i l�kka)
Vmin=0;
% Vektor med x-verdier
Na=300;              % antall punkter
xVektor = linspace(-5,5,Na);   % Vektor med x-verdier
% Lager plott
plot(xVektor,f(xVektor),'k-','linewidth',2) % Plotter landskap
hold on
xVerdi = x0;
yVerdi = f(xVerdi);
% Ploter posisjonen til objektet (r�d stjerne)
pl = plot(xVerdi,yVerdi,'rx','linewidth',10);    
hold off
 % For video
%v = VideoWriter ('test.avi');
%open (v); 
% L�kke som g�r over tidspunktene
%indeks=1;               % Innf�rer indeks som teller iterasjoner
while abs(Vx) > Vmin || D > M
 while abs(Vx)>presisjon || abs(R)<G   % Looper over alle tidspunktene

      N=Normalkraft(Vx,X,h,f,M,g);            %Normalkraft funksjon
      R=M*N;                           % Friksjon=Friksjonskoeffisient*Normalkraft
      D=(f(X+h)-f(X-h))/(2*h);
      B =-atan(D);
      G=g*sin(B);                      % Tyngdekraft
      ax=Akselerasjon(Vx,X,h,f,M,g);   %Akselerasjon
      VxHatt=Vx+ax*dt/2;
      XHatt=X+Vx*dt/2;
      ax=Akselerasjon(VxHatt,XHatt,h,f,M,g);
      Vx=Vx+ax*dt;
      X=X+Vx*dt;
      Y=f(X);
      F=(f(X+h)-2*f(X)+f(X-h))/(h^2);
   % Oppdaterer data til plotting
     set(pl,'xdata',X);
     set(pl,'ydata',Y);

  drawnow               % Oppdaterer selve plottet
    % Sparer p� hver 5. frame til video
  %if mod(indeks,5)==0 
    % Spare p� "frame" til filmen
    %frame=getframe(gcf);
    %writeVideo(v, frame);
  %end
  %indeks=indeks+1;      % Oppdaterer indeks  
 end
  D=(f(X+h)-f(X-h))/(2*h);
  M=M/2;
  R=M*N;  
end
% Lukker video-fila
%close(v)