%% Visualize Boundaries
%--------------------------------------------------------------------------
%  
% Visualize the decision boundaries.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function visualizeBoundaries(MdlLinear,featureVector,labels,featureA,featureB)

clf
category_names = categories(labels);
numGroups = length(category_names);
colors = jet(numGroups*10);
colors = colors(round(linspace(1,numGroups*10,numGroups)),:);
lim_info =  [min(featureVector(:,featureA)),max(featureVector(:,featureA)),...
    min(featureVector(:,featureB)),max(featureVector(:,featureB))  ];

h1 = gscatter(featureVector(:,featureA),featureVector(:,featureB),labels,'','+o*v^');
for i = 1:numGroups
    h1(i).LineWidth = 2;
    h1(i).MarkerEdgeColor = min(colors(i,:)*1.2,1);
end
hold on
x =  [min(featureVector(:,featureA)),max(featureVector(:,featureA))];
h2 = [];


for i = 1:numGroups
    if i+1 ~= numGroups
       j = mod(i+1,numGroups);
    else
       j=numGroups;
    end      
    w1   = MdlLinear(:,i);
    w2   =  MdlLinear(:,j);
    w1_0 = w1(1);
    w2_0 = w2(1);
    x2   = (-(w1_0-w2_0)-(w1(2)-w2(2))*x)/(w1(3)-w2(3));
    h2   = cat(1,h2,plot(x,x2,'LineWidth',2,'DisplayName',sprintf('Class Sep b/w %s,%s',category_names{i},category_names{j})));
       
end


axis(lim_info);
hold off
grid on;
set(gca,'FontWeight','bold','LineWidth',2)