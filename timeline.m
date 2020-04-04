clc; clear all; close all;
load('china.mat')
load('italia.mat')
load('espanya.mat')
clear Ydead Yinfected
t1 = datetime(2020,01,22,'Format','d-MMM');
t2 = datetime(2020,04,04,'Format','d-MMM');
t=t1:4:t2;

figure1= figure(1); 
axis([0 68 0 9e4])
hold on
h=plot(modelo_china{end},'r');
set(h, 'LineWidth',2);
plot(24:98,modelo_italia{end}(1:75),'g','LineWidth',2)
plot(24:98,modelo_espanya{end}(1:75),'b','LineWidth',2)

msg{1}='Total lockdown of the area of Wuhan [10]';
plot(0,modelo_china{end}(0),'r*') 

%msg{2}='Spain diagnoses the first COVID-19 case [11,12]';
%plot(10,1,'b*')% 31 enero
msg{3}='The WHO declares the global pandemic [13].';
plot(20,1,'k*')% 11 Feb
%msg{4}='The Mobile World Congress is cancelled over coronavirus concerns [14].';
%plot(22,1,'b+')% 12 Feb
%msg{5}='The first coronavirus related death occurs in Spain [12].';
%plot(23,1,'b^')% 13 Feb
%msg{6}='Infected people in Spain rises to 3';
%plot(34,3,'bo')% 24 Feb
msg{7}='Sports and the 8M demonstrations gathered +1M people in Spain';
%plot(47,674,'bo')% 8 Mar
plot(46,1558,'b*')% 8 Mar 674
%msg{8}=' All primary and high schools and universities in Madrid are closed';
%plot(47,1949,'bx')% 9 Mar 1231
msg{9}='Partial lockdown is declared in Italy';
plot(48,modelo_italia{end}(48-23),'g*') 
%msg{10}='Closure of schools and universities is extended to the whole country of Spain';
%plot(50,3000,'b>')% 12 Mar 2871
%msg{11}='Announcement of the declaration of the state of alarm for the next day causes the exodus of people from Madrid to other towns throughout Spain';
%plot(51,5232,'b<')% 13 Mar  5,232 infected people and 133 deaths in Spain.
msg{12}='Partial lockdown is declared in Spain';
plot(52,modelo_espanya{end}(52-23),'b*') 
msg{13}='Total lockdown is declared in Italy';
plot(59,53578,'g*')% March 21:  With 53,578 infected 
msg{14}='China lifts quarantine over Wuhan';
plot(61,modelo_china{end}(61),'r*') % March 23: China lifts quarantine over Wuhan
msg{15}='Lockdown tightening';
plot(66,modelo_espanya{end}(66-23),'b*') 


% Create textarrow
annotation(figure1,'textarrow',[0.221052631578948 0.129824561403509],...
    [0.440476190476191 0.183333333333333],'String',{'Total lockdown'});

% Create textarrow
annotation(figure1,'textarrow',[0.721052631578947 0.880701754385965],...
    [0.757142857142857 0.776190476190476],'String','Lockdown tightening');

% Create textarrow
annotation(figure1,'textarrow',[0.673684210526316 0.824561403508772],...
    [0.897619047619048 0.85],'String',{'Lockdown lifted'});

% Create arrow
annotation(figure1,'arrow',[0.721052631578947 0.803508771929825],...
    [0.754761904761905 0.619047619047619]);

% Create textarrow
annotation(figure1,'textarrow',[0.580701754385965 0.654385964912281],...
    [0.3 0.185714285714286],'String',{'>1M gathered'});

% Create textarrow
annotation(figure1,'textarrow',[0.459649122807018 0.354385964912282],...
    [0.473809523809524 0.176190476190478],...
    'String',{'The WHO','declares pandemic'});

% Create textarrow
annotation(figure1,'textarrow',[0.643859649122808 0.72280701754386],...
    [0.435714285714287 0.228571428571429],'String',{'Partial lockdown'});

% Create arrow
annotation(figure1,'arrow',[0.645614035087719 0.67719298245614],...
    [0.428571428571429 0.271428571428571]);

%xticks(0:1:20)
xticks(0:4:90)
xtickangle(90)
xticklabels(cellstr(t))
%title('Total Coronavirus cases')
xlabel('Date')
ylabel('Confirmed cases')
%msg=[{ 'China','Italy','Spain'}, msg];
msg=[{ 'China','Italy','Spain'}];
%legend( msg,'Interpreter','latex','Location','bestoutside')
legend( msg,'Interpreter','latex','Location','NorthWest')
grid off
box on


clear t t1 t2

savefig(figure(1),'./fig/timeline')
hgexport(figure(1),'./eps/timeline')
saveas(figure(1),'./png/timeline.png')

