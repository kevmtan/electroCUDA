The img_sim() function computes feature vectors for images. It can
optionally compute a dissimilarity matrix, categorize images (via
clustering), create a dendrogram and heatmap representing the
similarity between images, and create a 2D multi-dimensional scaling
to visualize the similarity of images.

For usage instructions, type "help img_sim"

If you have any questions or problems, don't hesitate to contact me at
daseibertuh@gmail.com

v 1.0; February 4, 2012
v 1.1; December 30, 2012

=======================================
Methods:
=======================================

===================
Sum squared error (SSE):
===================
This method simply sums the squared difference of pixel values for each image. One image is linearly shifted in the x and y directions over the image being compared. The shift which results in the lowest SSE is kept. The program can also perform this method after it has converted the images to a binary silhouette.

==================
Scale Invariant Feature Transform (SIFT):
==================
This program uses VLfeat to generate SIFT keypoints and feature vectors. Each keypoint has an associated feature vector which is composed of 128 scalar values. It has been tested on OSX and Windows XP. VLfeat should theoretically work on Linux too. This program analyzes the generated keypoints and feature vectors in one of two ways: (1) pooling and clustering keypoints and analyzing the clusters or (2) matching keypoints for each image comparison. The former method is the default behavior.

-----------------------------------------
Pooling features:
For every image being analyzed, SIFT feature vectors are determined. These vectors are combined into a single matrix so that all the feature vectors for all the images are within it. This matrix is then used as input to Matlab's k-means function and arranged so that each feature vector is assigned a cluster ID. The number of clusters k-means finds is supplied by the user (default is 15). After each feature vector is assigned a cluster ID, a histogram for each image is created by using Matlab's hist() function. The input to hist() is a vector containing all the cluster IDs each feature vector within that image has been assigned to.

For example, image A has 4 feature vectors. Two of the feature vectors are assigned to cluster ID 99. Another feature vector is assigned to cluster ID 83. The remaining is assigned to cluster ID 12. The input to hist() would be [99 83 12].

After the histogram has been created, histograms for each image are compared using KL divergence. This constitutes the dissimilarity matrix.

----------------------------------------
Matching features:
For each image comparison, SIFT keypoints are matched (instead of globally pooled). The matching is done by vl_ubcmatch() which is based off the original description proposed by Lowe (1999). vl_ubcmatch() generates a vector containing which keypoints between two images are considered to be matching. For each matching keypoint, a Euclidean distance between the matches is also given. There are several methods to condense the matching keypoints into a scalar quantity so that it can be entered into the dissimilarity matrix. This program supports:

-Summing the Euclidean distances for all the matching keypoints.
-Using the average Euclidean distances for the matching keypoints; ie the sum of all the Euclidean distances divided by the number of matching keypoints.
-The number of matching keypoints.
-The number of matching keypoints divided by the sum of their Euclidean distances.
-The number of matching keypoints divided by the total number of keypoints for each image--put another way: the percent of keypoints that match. Since the percent of keypoints that match depends on which image is being considered (it's unlikely for two images to have the exact number of keypoints), the sum of the percent of matching keypoints for both images being compared is input into the dissimilarity matrix. For example for the comparison of images A & B, the entry would be: matching_keypoints / total_keypoints_for_A  + matching_keypoints / total_keypoints_for_B
-The percent of matching keypoints (as previously described) divided by the average Euclidean distance.

The second to last method produces the best results when attempting to replicate the dissimilarity matrix of neural responses of the inferior temporal cortex (IT) in both humans and monkeys (Kriegeskorte). The last method also produces results somewhat better than the others, in replicating IT dissimilarity matrix.

======================
Biologically inspired hierarchical model, Jarrett et al.
======================
This is an implementation of the model tested by Jarrett et al. It is what they describe as Fcsg-Rabs-N-Pa, it uses one stage of random filters with no learning. The number of filters, filter size and down sample can all be altered by the user.

Briefly (full details are in the paper), filters are generated from white noise. These filters are convolved with each image so that for each image, now has 64 (or however many filters that are used) new images. From the raw pixel values of each new image, histograms are created. This can then be analyzed in two ways:

-KL divergence can be used to compare each new filtered image of image A to each new filtered image of image B. These values are then summed and used as input in the dissimilarity matrix.
-The histograms can be globally pooled and clustered using k-means. The number of clusters is set by the user. After the clustering, a new histogram for each image is created based off the cluster IDs that were assigned to the newly filtered images. This is similar in concept to the pooling of SIFT features, described above.

=====================
Geometric Blur
=====================
Geometric blur was implemented by the original description by Berg. This implementation differs in two ways from the original description. The filter size is slightly smaller: 9px.This was done because the images that were originally tested with this program were of lower resolution than used by Berg. The sub-sampling diagram still follows what was proposed in the paper, as closely as possible. The program also differs in that it deals with the point correspondence problem (determining which points between images are considered matching) by simply using the nearest neighbor point, instead of what was proposed by Berg. Neither of these differences seem to prevent the results from being highly clustered, typically separating images into clear distinctive groups. Additionally, Berg does not list all the parameter values used. Values were guessed at, but are unlikely to be the most optimal.

====================
Scene Gist
====================
The implementation by Torralba was used (Oliva 2001). It is available at http://people.csail.mit.edu/torralba/code/spatialenvelope/. From the output of gistGabor(), this program normalizes the vector to sum to one. Then, for each image KL divergence is used to compute a distance between images.

====================
Shock Graph
====================
The shock graph encodes the shape of a purely black-and-white image (see example_images_binary for a set of examples).  It is an extension of the medial axis representation developed by Kimia et al.  Graphs are computed and compared using ShapeMatcher, written by Diego Macrini and available at http://www.cs.toronto.edu/~dmac/ShapeMatcher/ .

====================
Gabor Filterbank
====================
This method projects the image onto a Gabor wavelet pyramid as a model for primary visual cortex, simplified from Kay et al.  The filters span eight orientations (multiples of .125*pi), four sizes (with the central edge covering 100%, 33%, 11%, and 3.7% of the image), and X,Y positions across the image (such that filters tile the space for each filter size).  The resulting vector of filter responses are compared between images using the Euclidean distance.

=======================================
References
=======================================
Just, Cherkassky, Aryal, Mitchell. A Neurosemantic Theory of Concrete Noun Representation Based on the Underlying Brain Codes.  PLoSOne 2010.

Lowe. Object recognition from local scale-invariant features.  IJCV 2004.

Jarrett. et al. What is the Best Multi-Stage Architecture for Object Recognition?  ICCV 2009.

Berg, Malik. Geometric Blur for Template Matching.  CVPR 2001.

Berg. Shape Matching and Object Recognition.  2005.

Oliva, Torralba. Modeling the Shape of the Scene: a Holistic Representation of the Spatial Envelope. International Journal in Computer Vision 2001.

Kimia et al. Shapes, shocks, and deformations i: the components of two-dimensional shape and the reaction-diffusion space. International Journal of Computer Vision 1995.

Kay et al. Identifying natural images from human brain activity.  Nature 2008.
