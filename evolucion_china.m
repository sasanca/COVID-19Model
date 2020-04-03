clc; clear all; close all;
load('china.mat')
t1 = datetime(2020,01,22,'Format','MMM-d');
t2 = datetime(2020,04,30,'Format','MMM-d');
t=t1:5:t2;
X=1:numel(Yinfected);

dinicial=10;
numdias=30; %Número de Days de evolución
fechas=dateshift(t1,'end','days',dinicial):dateshift(t1,'end','days',dinicial+numdias);
colores=jet(numdias);%'rgbcmyk';


%% Fit: 'china'.
[xData, yData] = prepareCurveData( X, Yinfected );

% Set up fittype and options.
ft = fittype( 'K*P*exp(r*x)/(K+P*(exp(r*x)-1))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1 1 0];
opts.StartPoint = [50000 90 0.2];

% Fit model to data.
for i=dinicial:numel(Yinfected);
[modelo_china{i}, ~] = fit( xData(1:i), yData(1:i), ft, opts );
end
modelo_china=modelo_china(dinicial:end);

%% Plot
figure(1); 
hold on
axis([0 75 0 1e5])

plot(modelo_china{end}(1:75),'.-r')
bar(X,Yinfected);
xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'Model','Data'},'Interpreter','latex')
%title('Total Coronavirus cases in China')
xlabel('Date')
ylabel('Confirmed cases')
grid on
box on

figure(2); 
hold on
axis([0 75 0 15e3])
plot(diff(modelo_china{end}(1:75)),'.-r')
bar([1 X(2:end)],[0 diff(Yinfected)]);
xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'Model','Data'},'Interpreter','latex')
%title('Daily cases in China')
xlabel('Date')
ylabel('Confirmed cases')
grid on
box on
hold off

figure(3); %evolucion del modelo
axis([0 75 0 1e5])
hold on
for i=1:numdias
objeto=plot(modelo_china{i});
  set(objeto,'color',colores(i,:));
end
xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
legend(cellstr(fechas(1:i)),'Interpreter','latex','Location','SouthEast','NumColumns',2)
%title('Total Coronavirus cases in China')
xlabel('Date')
ylabel('Confirmed cases')
grid on
box on

figure(4);  % Evolución del pico
%title('Daily cases in China')
xlabel('Date')
ylabel('Confirmed cases')
axis([0 75 0 5e3])
hold on
for i=1:numdias
plot(diff(modelo_china{i}(1:75)),'color',colores(i,:));
end

xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
legend(cellstr(fechas(1:i)),'Interpreter','latex','Location','NorthEast','NumColumns',2)
grid on
box on
clear opts xData yData ft fechas colores numdias i objeto t t1 t2 X dinicial

save('china.mat')

savefig(figure(1),'./fig/modelo_china')
hgexport(figure(1),'./eps/modelo_china')
saveas(figure(1),'./png/modelo_china.png')

savefig(figure(2),'./fig/pico_china')
hgexport(figure(2),'./eps/pico_china')
saveas(figure(2),'./png/pico_china.png')

savefig(figure(3),'./fig/modelo_china_evolucion')
hgexport(figure(3),'./eps/modelo_china_evolucion')
saveas(figure(3),'./png/modelo_china_evolucion.png')

savefig(figure(4),'./fig/pico_china_evolucion')
hgexport(figure(4),'./eps/pico_china_evolucion')
saveas(figure(4),'./png/pico_china_evolucion.png')