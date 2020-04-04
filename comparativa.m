clc; clear all; close all;
load('china.mat')
load('italy.mat')
load('spain.mat')
clear Ydead Yinfected
t1 = datetime(2020,01,22,'Format','d-MMM');
t2 = datetime(2020,05,30,'Format','d-MMM');
t=t1:5:t2;

figure(1); 
axis([0 90 0 1.5e5])
hold on
h=plot(model_china{end},'r');
set(h, 'LineWidth',2);
plot(25:99,model_italy{end}(1:75),'g','LineWidth',2)
plot(25:99,model_spain{end}(1:75),'b','LineWidth',2)
%xticks(0:1:20)
xticks(0:5:90)
xtickangle(90)
xticklabels(cellstr(t))
%title('Total Coronavirus cases')
xlabel('Date')
ylabel('Confirmed cases')
legend({ 'China','Italy','Spain'},'Interpreter','latex')
grid off
box on

figure(2); 
%title('Daily cases')
xlabel('Date')
ylabel('Confirmed cases')
axis([0 90 0 10e3])
hold on
plot(diff(model_china{end}(1:75)),'r','LineWidth',2)
plot(25:98,diff(model_italy{end}(1:75)),'g','LineWidth',2)
plot(25:98,diff(model_spain{end}(1:75)),'b','LineWidth',2)
%xticks(0:1:20)
xticks(0:5:90)
xtickangle(90)
xticklabels(cellstr(t))
%legend({'model a los 14 dias','model a los 15 dias', 'model a los 16 dias'},'Interpreter','latex')
legend({ 'China','Italy','Spain'},'Interpreter','latex')
grid off
box on

figure(3); 
axis([0 65 0 1.5e5])
hold on
%plot(model14,'r')
%plot(model15,'b')
h=plot(model_china{end},'r');
set(h, 'LineWidth',2);
plot(-14:60,model_italy{end}(1:75),'g','LineWidth',2)
plot(-18:56,model_spain{end}(1:75),'b','LineWidth',2)
%xticks(0:1:20)
xticks(0:5:65)
%legend({'model a los 14 dias','model a los 15 dias', 'model a los 16 dias'},'Interpreter','latex')
title('Total Coronavirus cases')
xlabel('Date')
ylabel('Confirmed cases')
legend({ 'China','Italy','Spain'},'Interpreter','latex','Location','NorthWest')
grid off
box on

figure(4); 
%title('Daily cases')
xlabel('Date')
ylabel('Confirmed cases')
axis([0 68 0 9e3])
hold on
plot(diff(model_china{end}(-15:75)),'r','LineWidth',2)
plot(diff(model_italy{end}(5:75)),'g','LineWidth',2)
plot(diff(model_spain{end}(9:75)),'b','LineWidth',2)
plot(15,261,'r*')
plot(21,1935,'g*')
plot(19,953,'b*')

xticks(0:4:68)

legend({ 'China','Italy','Spain','China lockdown','Italy partial lockdown','Spain partial lockdown'},'Interpreter','latex','Location','NorthWest')
grid off
box on

figure(5);  % Aceleración
hold on
axis([0 75 0 8e2])

%plot(diff(diff(model_china{end}(-15:75))),'r')
%plot(diff(diff(model_italy{end}(5:75))),'g')
%plot(diff(diff(model_spain{end}(9:75))),'b')

%plot(diff(diff(model_china{end}(1:75))),'r')
%plot(27:99,diff(diff(model_italy{end}(1:75))),'g')
%plot(27:99,diff(diff(model_spain{end}(1:75))),'b')
plot(diff(diff(model_china{end}(3:75))),'r','LineWidth',2)
plot(diff(diff(model_italy{end}(-23:75))),'g','LineWidth',2)
plot(diff(diff(model_spain{end}(-23:75))),'b','LineWidth',2)

xticks(0:5:75)
xtickangle(90)
xticklabels(cellstr(t))
legend({ 'China','Italy','Spain'},'Interpreter','latex','Location','NorthWest')
%title('New cases speed')
xlabel('Date')
ylabel('New cases increment per day')
grid off
box on
hold off

figure(6);  % Aceleración
hold on
axis([0 35 0 8e2])

plot(diff(diff(model_china{end}(-15:75))),'r','LineWidth',2)
plot(diff(diff(model_italy{end}(4:75))),'g','LineWidth',2)
plot(diff(diff(model_spain{end}(10:75))),'b','LineWidth',2)
plot(14.5,55,'r*')
plot(22,297,'g*')
plot(18.5,240,'b*')
plot(13,81,'bo')

xticks(0:2:40)
%xtickangle(90)
%xticklabels(cellstr(t))
legend({ 'China','Italy','Spain','China lockdown','Italy partial lockdown','Spain partial lockdown','Spain March 8th'},'Interpreter','latex','Location','NorthWest')
%title('New cases speed')
xlabel('Date')
ylabel('New cases increment per day')
grid off
box on
hold off

clear t t1 t2

save('comparison.mat')

savefig(figure(3),'./fig/model_comparison')
hgexport(figure(3),'./eps/model_comparison')
saveas(figure(3),'./png/model_comparison.png')

savefig(figure(4),'./fig/pico_comparison')
hgexport(figure(4),'./eps/pico_comparison')
saveas(figure(4),'./png/pico_comparison.png')

savefig(figure(5),'./fig/rate_comparison')
hgexport(figure(5),'./eps/rate_comparison')
saveas(figure(5),'./png/rate_comparison.png')


savefig(figure(6),'./fig/rate_comparison_centered')
hgexport(figure(6),'./eps/rate_comparison_centered')
saveas(figure(6),'./png/rate_comparison_centered.png')
