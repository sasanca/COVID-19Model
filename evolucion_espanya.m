clc; clear all; close all;
load('espanya.mat')
t1 = datetime(2020,02,15,'Format','MMM-d');
t2 = datetime(2020,05,30,'Format','MMM-d');
t=t1:5:t2;
X=1:numel(Yinfected);
dinicial=31; % Día inicial
numdias=17; %Número de dias de evolucion
fechas=dateshift(t1,'end','days',dinicial):dateshift(t1,'end','days',dinicial+numdias);
colores=jet(numdias);



%% Fit: 'espanya'.
[xData, yData] = prepareCurveData( X, Yinfected );

% Set up fittype and options.
ft = fittype( 'K*P*exp(r*x)/(K+P*(exp(r*x)-1))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1 1 0];
opts.StartPoint = [100000 90 0.2];

% Fit model to data.
for i=dinicial:numel(Yinfected);
[modelo_espanya{i}, ~] = fit( xData(1:i), yData(1:i), ft, opts );
end
modelo_espanya=modelo_espanya(dinicial:end);



figure(1); 
hold on
axis([0 75 0 1.5e5])
plot(modelo_espanya{end}(1:75),'.-r')
bar(X,Yinfected);
xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'Model','Data'},'Interpreter','latex','Location','NorthWest')
%title('Total Coronavirus cases in Spain')
xlabel('Date')
ylabel('Confirmed cases')
grid on
box on

figure(2); 
hold on
axis([0 75 0 10e3])

plot(diff(modelo_espanya{end}(1:75)),'.-r')
bar([1 X(2:end)],[0 diff(Yinfected)]);
xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'Model','Data'},'Interpreter','latex')
%title('Daily Coronavirus cases in Spain')
xlabel('Date')
ylabel('Confirmed cases')
grid on
box on
hold off

figure(3); %evolucion del modelo
axis([0 75 0 1.6e5])
hold on
for i=1:numdias
objeto=plot(modelo_espanya{i});
  set(objeto,'color',colores(i,:));
end

xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
legend(cellstr(fechas(1:i)),'Interpreter','latex','Location','NorthWest','NumColumns',2)
%title('Total Coronavirus cases in Spain')
xlabel('Date')
ylabel('Confirmed cases')
grid on
box on

figure(4);  % Evolución del pico
%title('Daily Coronavirus cases in Spain')
xlabel('Date')
ylabel('Confirmed cases')
axis([0 75 0 9e3])
hold on
for i=1:numdias
plot(diff(modelo_espanya{i}(1:75)),'color',colores(i,:));
%plot(diff(modelo_espanya{i}(1:75)));
end

xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
%legend({'Modelo a los 14 dias','Modelo a los 15 dias', 'Modelo a los 16 dias'},'Interpreter','latex')
legend(cellstr(fechas(1:i)),'Interpreter','latex','Location','NorthWest','NumColumns',1)
grid on
box on

% figure(5);  % Aceleración
% hold on
% axis([0 75 0 3.5e3])
% 
% bar([1 X(3:end)],[0 diff(diff(Yinfected))]);
% plot(diff(diff(modelo_espanya{i}(1:75))));
% 
% xticks(0:5:75)
% xtickangle(90)
% xticklabels(cellstr(t))
% legend({ 'Model','Data'},'Interpreter','latex')
% title('Daily Coronavirus cases in Spain')
% xlabel('Date')
% ylabel('Confirmed cases')
% grid on
% box on
% hold off


clear opts xData yData ft fechas colores numdias i objeto t t1 t2 X dinicial

save('espanya.mat')

savefig(figure(1),'./fig/modelo_espanya')
hgexport(figure(1),'./eps/modelo_espanya')
saveas(figure(1),'./png/modelo_espanya.png')

savefig(figure(2),'./fig/pico_espanya')
hgexport(figure(2),'./eps/pico_espanya')
saveas(figure(2),'./png/pico_espanya.png')

savefig(figure(3),'./fig/modelo_espanya_evolucion')
hgexport(figure(3),'./eps/modelo_espanya_evolucion')
saveas(figure(3),'./png/modelo_espanya_evolucion.png')

savefig(figure(4),'./fig/pico_espanya_evolucion')
hgexport(figure(4),'./eps/pico_espanya_evolucion')
saveas(figure(4),'./fig/pico_espanya_evolucion.png')

