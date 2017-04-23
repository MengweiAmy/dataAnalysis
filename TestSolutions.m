x=[1:2:23]';
y=abs([121 41 20.6 12.5 8.1 5.8 4.4 3.5 3 2.7 2.3 2.1]);
bar(x,y)
for i1=1:numel(y)
    text(x(i1),y(i1),num2str(y(i1),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end