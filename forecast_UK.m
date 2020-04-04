%% April 4. Paper submission

clc; clear all; close all;
load('UK.mat')
fecha_final='Apr 04';
dfinal=find(ismember(dates,fecha_final));
fecha_inicial='Mar 22';
dinicial=find(ismember(dates,fecha_inicial));
Y=Yinfected(1:dfinal);
t1 = datetime(2020,02,15,'Format','MMM-d');
t2 = datetime(2020,06,30,'Format','MMM-d');
t=t1:5:t2;
X=1:numel(Y);

numdias=dfinal-dinicial+1; %Número de dias de evolucion
fechas=dates(dinicial:dfinal);
colores=jet(numdias);

K13=97985.44;
r13=0.14471;
P13=52.8331;
K19=140523.76;
r19=0.100904;
P19=402.551;

x=1:106;

figure(1); 
hold on
axis([1 106 0 1.6e5])

plot(K13*P13*exp(r13*(x))./(K13+P13*(exp(r13*(x))-1)),'.-r','LineWidth',2)
plot(K19*P19*exp(r19*(x))./(K19+P19*(exp(r19*(x))-1)),'.-b','LineWidth',2)
bar(X,Y);

xticks(1:5:106)
xtickangle(90)
xticklabels(cellstr(t))
legend({ '13 days','19 days','Data'},'Interpreter','latex','Location','NorthWest')
%title('Total Coronavirus cases in UK')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on

figure(2);  % Evolución del peak
hold on
axis([1 106 0 5e3])
plot(diff(K13*P13*exp(r13*(x-1))./(K13+P13*(exp(r13*(x-1))-1))),'.-r','LineWidth',2)
plot(diff(K19*P19*exp(r19*(x))./(K19+P19*(exp(r19*(x))-1))),'.-b','LineWidth',2)
bar([1 X(2:end)],[0 diff(Y)]);
xticks(1:5:106)
xtickangle(90)
xticklabels(cellstr(t))
legend({ '13 days','19 days','Data'},'Interpreter','latex','Location','NorthWest')
%title('Daily Coronavirus cases in france')
xlabel('Date')
ylabel('Confirmed cases')
grid off
box on
hold off

clear opts xData yData ft fechas colores numdias i objeto t t1 t2 X 

clear Y fecha_inicial fecha_final dinicial dfinal



savefig(figure(1),'./fig/forecast_model_UK')
hgexport(figure(1),'./eps/forecast_model_UK')
saveas(figure(1),'./png/forecast_model_UK.png')


savefig(figure(2),'./fig/forecast_peak_UK')
hgexport(figure(2),'./eps/forecast_peak_UK')
saveas(figure(2),'./png/forecast_peak_UK.png')
