We are going to build custom deep networks. When there are less images, we increase the size of the dataset by augmenting the image dataset with different transformations of the the original pictures. 

Run augDataCreation.m for data augmentation. augDataCreation.m uses the utilities class to create augmented images. All the transformation functions are class members of utilities. 

For the default network, run main_matlab.m
For wide network, run wideNetwork.m
For skinny network, run skinnyNetwork.m

Run alexNet.m to train the pretrained alexnet.  
RUN visualization.m to visualize the features of the first layer and to perfrom t-SNE.