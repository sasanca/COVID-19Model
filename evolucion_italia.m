clc; clear all; close all;
load('italia.mat')
t1 = datetime(2020,02,15,'Format','MMM-d');
t2 = datetime(2020,05,30,'Format','MMM-d');
t=t1:5:t2;
X=1:numel(Yinfected);
dinicial=23;%31
numdias=23; %Número de Days de evolución
fechas=dateshift(t1,'end','days',dinicial):dateshift(t1,'end','days',dinicial+numdias);
colores=jet(numdias);


%% Fit: 'Italia'.
[xData, yData] = prepareCurveData( X, Yinfected );

% Set up fittype and options.
ft = fittype( 'K*P*exp(r*x)/(K+P*(exp(r*x)-1))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1 1 0];
opts.StartPoint = [100000 90 0.2];

% Fit model to data.
for i=dinicial:numel(Yinfected);
[modelo_italia{i}, ~] = fit( xData(1:i), yData(1:i), ft, opts );
end
modelo_italia=modelo_italia(dinicial:end);


figure(1); 
hold on
axis([0 75 0 1.5e5])

plot(modelo_italia{end}(1:75),'.-r')
bar(X,Yinfected);
xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'Model','Data'},'Interpreter','latex','Location','NorthWest')
%title('Total Coronavirus cases in Italy')
xlabel('Date')
ylabel('Confirmed cases')
grid on
box on

figure(2); 
hold on
axis([0 75 0 7e3])
plot(diff(modelo_italia{end}(1:75)),'.-r')
bar([1 X(2:end)],[0 diff(Yinfected)]);
xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
%title('Daily Coronavirus cases in Italy')
xlabel('Date')
ylabel('Confirmed cases')
grid on
box on
hold off

figure(3); %evolucion del modelo
axis([0 75 0 1.5e5])
hold on
for i=1:numdias
objeto=plot(modelo_italia{i});
  set(objeto,'color',colores(i,:));
end

xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
%legend({'Modelo a los 14 dias','Modelo a los 15 dias', 'Modelo a los 16 dias'},'Interpreter','latex')
legend(cellstr(fechas(1:i)),'Interpreter','latex','Location','NorthWest','NumColumns',2)
%title('Total Coronavirus cases in Italy')
xlabel('Date')
ylabel('Confirmed cases')
grid on
box on

figure(4);  % Evolución del pico
%title('Daily Coronavirus cases in Italy')
xlabel('Date')
ylabel('Confirmed cases')
axis([0 75 0 6e3])
hold on
for i=1:numdias
plot(diff(modelo_italia{i}(1:75)),'color',colores(i,:));
%plot(diff(modelo_italia{i}(1:75)));
end

%xticks(0:1:20)
xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
%legend(cellstr(fechas(1:i)),'Interpreter','latex','Location','NorthWest','NumColumns',2)
legend(cellstr(fechas(1:i)),'Interpreter','latex','Location','bestoutside')
grid on
box on
clear opts xData yData ft fechas colores numdias i objeto t t1 t2 X dinicial

save('italia.mat')

savefig(figure(1),'./fig/modelo_italia')
hgexport(figure(1),'./eps/modelo_italia')
saveas(figure(1),'./png/modelo_italia.png')

savefig(figure(2),'./fig/pico_italia')
hgexport(figure(2),'./eps/pico_italia')
saveas(figure(2),'./png/pico_italia.png')

savefig(figure(3),'./fig/modelo_italia_evolucion')
hgexport(figure(3),'./eps/modelo_italia_evolucion')
saveas(figure(3),'./png/modelo_italia_evolucion.png')

savefig(figure(4),'./fig/pico_italia_evolucion')
hgexport(figure(4),'./eps/pico_italia_evolucion')
saveas(figure(4),'./png/pico_italia_evolucion.png')

