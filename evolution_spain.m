%% April 4. Paper submission

clc; clear all; close all;
load('spain.mat')
fecha_final='Apr 04';
%fecha_final='Apr 28';
dfinal=find(ismember(dates,fecha_final));
fecha_inicial='Mar 22';
dinicial=find(ismember(dates,fecha_inicial));
Y=Yinfected(1:dfinal);
t1 = datetime(2020,02,15,'Format','MMM-d');
t2 = datetime(2020,05,30,'Format','MMM-d');
t=t1:5:t2;
X=1:numel(Y);

numdias=dfinal-dinicial+1; %Número de dias de evolution
fechas=dates(dinicial:dfinal);
colores=jet(numdias);


%% Fit: 'spain'.
[xData, yData] = prepareCurveData( X, Y );

% Set up fittype and options.
ft = fittype( 'K*P*exp(r*x)/(K+P*(exp(r*x)-1))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1 1 0];
opts.StartPoint = [100000 90 0.2];

% Fit model to data.
for i=dinicial:numel(Y);
[model_spain{i}, ~] = fit( xData(1:i), yData(1:i), ft, opts );
end
model_spain=model_spain(dinicial:end);



figure(1); 
hold on
axis([1 76 0 1.6e5])
plot(model_spain{end}(1:76),'.-r','LineWidth',2)
bar(X,Y);
xticks(1:5:76)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'Model','Data'},'Interpreter','latex','Location','NorthWest')
%title('Total Coronavirus cases in spain')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on

figure(2); 
hold on
axis([1 76 0 9e3])

plot(diff(model_spain{end}(1:76)),'.-r','LineWidth',2)
bar([1 X(2:end)],[0 diff(Y)]);
xticks(1:5:76)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'Model','Data'},'Interpreter','latex')
%title('Daily Coronavirus cases in spain')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on
hold off

figure(3); %evolution del model
axis([1 76 0 1.6e5])
hold on
for i=1:numdias
objeto=plot(model_spain{i});
  set(objeto,'color',colores(i,:),'LineWidth',1.5);
end

xticks(1:5:76)
xtickangle(90)
xticklabels(cellstr(t))
legend(cellstr(fechas),'Interpreter','latex','Location','NorthWest','NumColumns',2)
%title('Total Coronavirus cases in spain')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on

figure(4);  % Evolución del peak
%title('Daily Coronavirus cases in spain')
xlabel('Date')
ylabel('Confirmed cases')
axis([1 76 0 9e3])
hold on
for i=1:numdias
plot(diff(model_spain{i}(1:76)),'color',colores(i,:),'LineWidth',1.5);
end

xticks(1:5:76)
xtickangle(90)
xticklabels(cellstr(t))
legend(cellstr(fechas),'Interpreter','latex','Location','NorthWest','NumColumns',1)
grid off
box on

clear opts xData yData ft fechas colores numdias i objeto t t1 t2 X 

clear Y fecha_inicial fecha_final dinicial dfinal

save('spain.mat')

savefig(figure(1),'./fig/model_spain')
hgexport(figure(1),'./eps/model_spain')
saveas(figure(1),'./png/model_spain.png')

savefig(figure(2),'./fig/peak_spain')
hgexport(figure(2),'./eps/peak_spain')
saveas(figure(2),'./png/peak_spain.png')

savefig(figure(3),'./fig/model_spain_evolution')
hgexport(figure(3),'./eps/model_spain_evolution')
saveas(figure(3),'./png/model_spain_evolution.png')

savefig(figure(4),'./fig/peak_spain_evolution')
hgexport(figure(4),'./eps/peak_spain_evolution')
saveas(figure(4),'./png/peak_spain_evolution.png')
