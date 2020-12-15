clear all
close all
clc

c=1;

p1 =@(k,e) (k^4)*(c^-3)*(e^-3);
p2 =@(k,e) (k^2)*(c^-3)*(e^-4);
p3 =@(k,e) max((k^4)*(c^-3)*(e^-3), (k^2)*(c^-3)*(e^-4));

% figure(1)
% hold on
% figure(2)
% hold on
figure(3)
hold on
for e=0.1:0.05:1
    disp(e)
    for k=1:5:30
%         figure(1)
%         plot(e,p1(k,e),'r.')
%         plot(e,p2(k,e),'b.')
%         figure(2)
%         plot(k,p1(k,e),'r.')
%         plot(k,p2(k,e),'b.')
        figure(3)
        scatter3(e,k,k/(c*e),'g.')
    end
end
% figure(1)
% xlabel('e')
% ylabel('p')
% set(gca, 'YScale', 'log')
% figure(2)
% xlabel('k')
% ylabel('p')
% set(gca, 'YScale', 'log')
figure(3)
xlabel('e')
ylabel('k')
% set(gca, 'ZScale', 'log')
view(40,35)
% legend(['p1','p2','p'])
% sh