%% May 19

clc; clear all; close all;
load('france.mat')
fecha_final='May 19';
dfinal=find(ismember(dates,fecha_final));
fecha_inicial='Apr 02';
dinicial=find(ismember(dates,fecha_inicial));
Y=Yinfected(1:dfinal);
t1 = datetime(2020,02,15,'Format','MMM-d');
t2 = datetime(2020,06,30,'Format','MMM-d');
t=t1:5:t2;
X=1:numel(Y);

numdias=dfinal-dinicial+1; %Número de dias de evolution
fechas=dates(dinicial:dfinal);
colores=jet(numdias);
diastotales= 120;

%% Fit: 'france'.
[xData, yData] = prepareCurveData( X, Y );

% Set up fittype and options.
ft = fittype( 'K*P*exp(r*x)/(K+P*(exp(r*x)-1))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1 1 0];
%opts.StartPoint = [150000 100 0.05];
opts.StartPoint = [100000 100 0.1];

% Fit model to data.
for i=dinicial:numel(Y);
[model_france{i}, ~] = fit( xData(1:i), yData(1:i), ft, opts );
end
model_france=model_france(dinicial:end);



figure(1); 
hold on
axis([1 diastotales 0 2.5e5])
bar(X,Y);
plot(model_france{end}(1:diastotales),'.-r','LineWidth',2)
bounds = predint(model_france{end},(1:diastotales),0.95,'observation','on');
plot(1:diastotales,bounds,'m--')
xticks(1:5:diastotales)
xtickangle(90)
xticklabels(cellstr(t))
legend({'Data', 'Model','Bounds (95\% Conf.)'},'Interpreter','latex','Location','NorthWest')
%title('Total Coronavirus cases in france')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on

figure(2); 
hold on
axis([1 diastotales 0 17.5e3])

plot(diff(model_france{end}(-1:diastotales)),'.-r','LineWidth',2)
bar([1 X(2:end)],[0 diff(Y)]);
xticks(1:5:diastotales)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'Model','Data'},'Interpreter','latex')
%title('Daily Coronavirus cases in france')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on
hold off

figure(3); %evolution del model
axis([1 diastotales 0 3e5])
hold on
for i=1:numdias
objeto=plot(model_france{i});
  set(objeto,'color',colores(i,:),'LineWidth',1.5);
end

xticks(1:5:diastotales)
xtickangle(90)
xticklabels(cellstr(t))
legend(cellstr(fechas),'Interpreter','latex','Location','NorthEastOutside','NumColumns',2)
%title('Total Coronavirus cases in france')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on

figure(4);  % Evolución del peak
%title('Daily Coronavirus cases in france')
xlabel('Date')
ylabel('Confirmed cases')
axis([1 diastotales 0 11e3])
hold on
for i=1:numdias
plot(diff(model_france{i}(1:diastotales)),'color',colores(i,:),'LineWidth',1.5);
end

xticks(1:5:diastotales)
xtickangle(90)
xticklabels(cellstr(t))
legend(cellstr(fechas),'Interpreter','latex','Location','NorthEastOutside','NumColumns',2)
grid off
box on


clear opts xData yData ft fechas colores numdias i objeto t t1 t2 X 

clear Y fecha_inicial fecha_final dinicial dfinal diastotales

save('france.mat')

savefig(figure(1),'./fig/model_france')
hgexport(figure(1),'./eps/model_france')
saveas(figure(1),'./png/model_france.png')

savefig(figure(2),'./fig/peak_france')
hgexport(figure(2),'./eps/peak_france')
saveas(figure(2),'./png/peak_france.png')

savefig(figure(3),'./fig/model_france_evolution')
hgexport(figure(3),'./eps/model_france_evolution')
saveas(figure(3),'./png/model_france_evolution.png')

savefig(figure(4),'./fig/peak_france_evolution')
hgexport(figure(4),'./eps/peak_france_evolution')
saveas(figure(4),'./png/peak_france_evolution.png')

