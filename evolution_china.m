%% April 4. Paper submission

clc; clear all; close all;
load('china.mat')
fecha_final='Mar 02';
dfinal=find(ismember(dates,fecha_final));
fecha_inicial='Feb 02';
dinicial=find(ismember(dates,fecha_inicial));
Y=Yinfected(1:dfinal);
t1 = datetime(2020,01,22,'Format','MMM-d');
t2 = datetime(2020,05,30,'Format','MMM-d');
t=t1:5:t2;
X=1:numel(Y);

numdias=dfinal-dinicial+1; %Número de dias de evolution
fechas=dates(dinicial:dfinal);
colores=jet(numdias);


%% Fit: 'china'.
[xData, yData] = prepareCurveData( X, Y );

% Set up fittype and options.
ft = fittype( 'K*P*exp(r*x)/(K+P*(exp(r*x)-1))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1 1 0];
opts.StartPoint = [100000 90 0.2];

% Fit model to data.
for i=dinicial:numel(Y);
[model_china{i}, ~] = fit( xData(1:i), yData(1:i), ft, opts );
end
model_china=model_china(dinicial:end);



figure(1); 
hold on
axis([1 76 0 1e5])
plot(model_china{end}(1:76),'.-r','LineWidth',2)
bar(X,Y);
xticks(1:5:76)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'Model','Data'},'Interpreter','latex','Location','NorthWest')
%title('Total Coronavirus cases in china')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on

figure(2); 
hold on
axis([1 76 0 15e3])

plot(diff(model_china{end}(1:76)),'.-r','LineWidth',2)
bar([1 X(2:end)],[0 diff(Y)]);
xticks(1:5:76)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'Model','Data'},'Interpreter','latex')
%title('Daily Coronavirus cases in china')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on
hold off

figure(3); %evolution del model
axis([1 76 0 1e5])
hold on
for i=1:numdias
objeto=plot(model_china{i});
  set(objeto,'color',colores(i,:),'LineWidth',1.5);
end

xticks(1:5:76)
xtickangle(90)
xticklabels(cellstr(t))
legend(cellstr(fechas),'Interpreter','latex','Location','SouthEast','NumColumns',2)
%title('Total Coronavirus cases in china')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on

figure(4);  % Evolución del peak
%title('Daily Coronavirus cases in china')
xlabel('Date')
ylabel('Confirmed cases')
axis([1 76 0 5e3])
hold on
for i=1:numdias
plot(diff(model_china{i}(1:76)),'color',colores(i,:),'LineWidth',1.5);
end

xticks(1:5:76)
xtickangle(90)
xticklabels(cellstr(t))
legend(cellstr(fechas),'Interpreter','latex','Location','NorthEast','NumColumns',2)
grid off
box on

clear opts xData yData ft fechas colores numdias i objeto t t1 t2 X 

clear Y fecha_inicial fecha_final dinicial dfinal

save('china.mat')

savefig(figure(1),'./fig/model_china')
hgexport(figure(1),'./eps/model_china')
saveas(figure(1),'./png/model_china.png')

savefig(figure(2),'./fig/peak_china')
hgexport(figure(2),'./eps/peak_china')
saveas(figure(2),'./png/peak_china.png')

savefig(figure(3),'./fig/model_china_evolution')
hgexport(figure(3),'./eps/model_china_evolution')
saveas(figure(3),'./png/model_china_evolution.png')

savefig(figure(4),'./fig/peak_china_evolution')
hgexport(figure(4),'./eps/peak_china_evolution')
saveas(figure(4),'./png/peak_china_evolution.png')

