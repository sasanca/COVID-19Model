clc; clear all; close all;
load('china.mat')
load('italia.mat')
load('espanya.mat')
clear Ydead Yinfected
t1 = datetime(2020,01,22,'Format','d-MMM');
t2 = datetime(2020,05,30,'Format','d-MMM');
t=t1:5:t2;

figure(1); 
axis([0 90 0 1.5e5])
hold on
plot(modelo_china{end},'r')
plot(25:99,modelo_italia{end}(1:75),'g')
plot(25:99,modelo_espanya{end}(1:75),'b')
%xticks(0:1:20)
xticks(0:5:90)
xtickangle(90)
xticklabels(cellstr(t))
%title('Total Coronavirus cases')
xlabel('Date')
ylabel('Confirmed cases')
legend({ 'China','Italy','Spain'},'Interpreter','latex')
grid on
box on

figure(2); 
%title('Daily cases')
xlabel('Date')
ylabel('Confirmed cases')
axis([0 90 0 10e3])
hold on
plot(diff(modelo_china{end}(1:75)),'r')
plot(25:98,diff(modelo_italia{end}(1:75)),'g')
plot(25:98,diff(modelo_espanya{end}(1:75)),'b')
%xticks(0:1:20)
xticks(0:5:90)
xtickangle(90)
xticklabels(cellstr(t))
%legend({'Modelo a los 14 dias','Modelo a los 15 dias', 'Modelo a los 16 dias'},'Interpreter','latex')
legend({ 'China','Italy','Spain'},'Interpreter','latex')
grid on
box on

figure(3); 
axis([0 65 0 1.5e5])
hold on
%plot(modelo14,'r')
%plot(modelo15,'b')
plot(modelo_china{end},'r')
plot(-14:60,modelo_italia{end}(1:75),'g')
plot(-18:56,modelo_espanya{end}(1:75),'b')
%xticks(0:1:20)
xticks(0:5:65)
%legend({'Modelo a los 14 dias','Modelo a los 15 dias', 'Modelo a los 16 dias'},'Interpreter','latex')
title('Total Coronavirus cases')
xlabel('Date')
ylabel('Confirmed cases')
legend({ 'China','Italy','Spain'},'Interpreter','latex','Location','NorthWest')
grid on
box on

figure(4); 
%title('Daily cases')
xlabel('Date')
ylabel('Confirmed cases')
axis([0 68 0 8e3])
hold on
plot(diff(modelo_china{end}(-15:75)),'r')
plot(diff(modelo_italia{end}(5:75)),'g')
plot(diff(modelo_espanya{end}(9:75)),'b')
plot(15,261,'r*')
plot(21,1935,'g*')
plot(19,953,'b*')

xticks(0:4:68)

legend({ 'China','Italy','Spain','China lockdown','Italy partial lockdown','Spain partial lockdown'},'Interpreter','latex','Location','NorthWest')
grid on
box on

figure(5);  % Aceleración
hold on
axis([0 75 0 8e2])

%plot(diff(diff(modelo_china{end}(-15:75))),'r')
%plot(diff(diff(modelo_italia{end}(5:75))),'g')
%plot(diff(diff(modelo_espanya{end}(9:75))),'b')

%plot(diff(diff(modelo_china{end}(1:75))),'r')
%plot(27:99,diff(diff(modelo_italia{end}(1:75))),'g')
%plot(27:99,diff(diff(modelo_espanya{end}(1:75))),'b')
plot(diff(diff(modelo_china{end}(3:75))),'r')
plot(diff(diff(modelo_italia{end}(-23:75))),'g')
plot(diff(diff(modelo_espanya{end}(-23:75))),'b')

xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'China','Italy','Spain'},'Interpreter','latex','Location','NorthWest')
%title('New cases speed')
xlabel('Date')
ylabel('New cases increment per day')
grid on
box on
hold off

figure(6);  % Aceleración
hold on
axis([0 35 0 8e2])

%plot(diff(diff(modelo_china{end}(-15:75))),'r')
%plot(diff(diff(modelo_italia{end}(5:75))),'g')
%plot(diff(diff(modelo_espanya{end}(9:75))),'b')

plot(diff(diff(modelo_china{end}(-15:75))),'r')
plot(diff(diff(modelo_italia{end}(3:75))),'g')
plot(diff(diff(modelo_espanya{end}(9:75))),'b')
plot(14.5,55,'r*')
plot(22,275,'g*')
plot(18.5,205,'b*')
plot(13,63,'bo')

xticks(0:2:40)
%xtickangle(90)
%xticklabels(cellstr(t))
legend({ 'China','Italy','Spain','China lockdown','Italy partial lockdown','Spain partial lockdown','Spain March 8th'},'Interpreter','latex','Location','NorthWest')
%title('New cases speed')
xlabel('Date')
ylabel('New cases increment per day')
grid on
box on
hold off

clear t t1 t2

save('comparativa.mat')

savefig(figure(3),'./fig/modelo_comparativa')
hgexport(figure(3),'./eps/modelo_comparativa')
saveas(figure(3),'./png/modelo_comparativa.png')

savefig(figure(4),'./fig/pico_comparativa')
hgexport(figure(4),'./eps/pico_comparativa')
saveas(figure(4),'./png/pico_comparativa.png')

savefig(figure(5),'./fig/ritmo_comparativa')
hgexport(figure(5),'./eps/ritmo_comparativa')
saveas(figure(5),'./png/ritmo_comparativa.png')


savefig(figure(6),'./fig/ritmo_comparativa_centrado')
hgexport(figure(6),'./eps/ritmo_comparativa_centrado')
saveas(figure(6),'./png/ritmo_comparativa_centrado.png')
