%% Visualize Boundaries Fill
%--------------------------------------------------------------------------
%  
% Visualizing boundaries.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
function h = visualizeBoundariesFill(MdlLinear,featureVector,labels,featureA,featureB)
clf
nPoints = 200;

cats = categories(labels);
numGroups = length(cats);
lim_info =  [min(featureVector(:,featureA)),max(featureVector(:,featureA)),...
    min(featureVector(:,featureB)),max(featureVector(:,featureB))  ];

x = linspace(lim_info(1),lim_info(2),nPoints);
y = linspace(lim_info(3),lim_info(4),nPoints);
[X,Y] = meshgrid(x,y);
xx=X(:);
yy=Y(:);
P = -inf*ones(nPoints,nPoints);
G = ones(nPoints,nPoints);
colors = jet(numGroups*10);
colors = colors(round(linspace(1,numGroups*10,numGroups)),:);

featureVector_for_prediction = zeros(length(xx),size(featureVector,2));
featureVector_for_prediction(:,featureA) = xx;
featureVector_for_prediction(:,featureB) = yy;

pred = myPredict(MdlLinear,featureVector_for_prediction);
predictions = categorical(ones(size(pred)));
categoricalClasses = unique(labels);
for i = 1:size(pred, 1)
    predictions(i, 1) = categoricalClasses(pred(i));
end
G = reshape(predictions,nPoints,nPoints);


hold on;
for i = 1:numGroups
    cc = bwconncomp(G==cats(i));
    for rp = regionprops(cc,'ConvexHull')'
        xx = x(min(round(rp.ConvexHull(:,1)),nPoints));
        yy = y(min(round(rp.ConvexHull(:,2)),nPoints));
        patch(xx,yy,colors(i,:),'FaceAlpha',.2)
    end
    
end

h = gscatter(featureVector(:,featureA),featureVector(:,featureB),labels,'','+o*v^');
for i = 1:numGroups
    h(i).LineWidth = 2;
    h(i).MarkerEdgeColor = colors(i,:);
    h(i).MarkerFaceColor = colors(i,:);
end
axis(lim_info)
hold off
grid on;
set(gca,'FontWeight','bold','LineWidth',2)