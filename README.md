# Brain Tumor Detection MLops And Hybrid Multi Cloud
<p align="center">
  <img width="1000" height="500" src="https://github.com/amit17133129/Brain_Tumor_Detection_MLops_and_Hybrid_Multi_Cloud/blob/main/brain%20image.gif?raw=true">
</p>


Hello guys, hope you all doing good in this pandemic time. Finally learning multiple tools and technologies i am able to integrate them and create something new. Here, i have created a webapp that will helps us to detect the brain tumor using Hybrid multi cloud and MLOps tools. In this project i have created first the model using Convolutional neural network. The model is saved and using flask created a webapp whereas the using dockerfile created image. So let’s start this project by knowing the deep learning codes and explaination on the same.

## Convolutional Network Architecture:
I have used CNN algorithm to get the prediction of brain tumor using brain MRI images. You can easily find the dataset of brain MRI on kaggle here. The dataset is basically classified into 4 classes which is mentioned below.

<p align="center">
<img width="400" height="400" src="https://miro.medium.com/max/781/1*uPiEutH7gRIs4zFUsW55Bg.png">
</p>

## 1. Glioma Tumor: 
Glioma is a type of tumor that occurs in the brain and spinal cord. Gliomas begin in the gluey supportive cells (glial cells) that surround nerve cells and help them function. Three types of glial cells can produce tumors.
The circled red part on the right side of the brain is the Glioma tumor.

<p align="center">
<img width="400" height="400" src="https://miro.medium.com/max/781/1*MdXesnMYSje_gX30mOreVg.png">
</p>
## 2. Meningioma Tumor: 
A meningioma is a tumor that arises from the meninges — the membranes that surround your brain and spinal cord. Although not technically a brain tumor, it is included in this category because it may compress or squeeze the adjacent brain, nerves and vessels.

<p align="center">
<img width="400" height="400" src="https://miro.medium.com/max/781/1*4hBM40WmaFd8ZITLMblZwA.png">
</p>

## 3. Pituitary Tumor: 
Pituitary tumors are abnormal growths that develop in your pituitary gland. Some pituitary tumors result in too much of the hormones that regulate important functions of your body. Some pituitary tumors can cause your pituitary gland to produce lower levels of hormones.

<p align="center">
<img width="400" height="400" src="https://miro.medium.com/max/642/1*CB-vNUQrGAlNySl0WZa0pg.png">
</p>

## 4. No Tumor: 
As you can see the image alongside of a brain. This specific brain has no tumor.
Anyone can easily tells that this brain image is a free tumor.
Now lets move towards the python code for creating neural network and training the CNN model on brain.

<p align="center">
<img width="1000" height="250" src="https://miro.medium.com/max/1094/1*Mg7L-Ac4Qia-b6QvQ036FQ.png">
</p>

As you can see in the above image that i have created a class named brain_tumor which have a function named image_data. This function will helps us to create a training set of brain MRI images. I have imported ImageDataGenerator from keras.preprocessing. ImageDataGenerator function will helps us to create a image set by following parameteres.
1. rescale → it will help to rescale the image by 1./255.
2. shear_range → this will helps us to shear the image by 20%.
3. zoom_range → this will help to zoom the mage by 20%.
4. horizontal_flip= True → Helps to flip the image horizontally.
After tha we have to import the images from the directory using flow_from_directory function. Here flow_from_directory have folllowing parameters which will helps us to create a set of training data.
1. targe_size= (64,64) → Target(final) image will be of 64 * 64 pixel.
2. batch_size= 32 → The default ‘batch_size’ is 32, which means that 32 randomly selected images from across the classes in the dataset will be returned in each batch when training.
3. class_mode = ‘binary/categorical’. Here binary means 2 classes whereas categorical means more than two classes. As we having 4 classes so i am taking classmode as categorical.
Now the same process we have to do it for testing dataset. The same process has done in the below image to create a testing dataset.

<p align="center">
<img width="1000" height="180" src="https://miro.medium.com/max/1094/1*u1806FqECHeAx5nb3l2xIA.png">
</p>

I created a new function in the same class of brain_tumor. The final images will be stored in test_set variable.

<p align="center">
<img width="1000" height="100" src="https://miro.medium.com/max/1094/1*rgZIU3jnH4bMBM5bCUB2Hg.png">
</p>

Now we can create model. Here i am importing Sequential() from tf.keras.model. `Sequential()` means that you have to create
`Input layer → Hidden layer → Output layer.`
For learning detailed concept of CNN look at this article.
Now lets move forward to create our Convolutional neural network. I have create a new function in the same class of brain_tumor as you can see below.

<p align="center">
<img width="1000" height="180" src="https://miro.medium.com/max/1094/1*D2C05amoHJ88wkcGEHg4yg.png">
</p>


<p align="center">
<img width="400" height="600" src="https://miro.medium.com/max/781/1*J3DoDuMAzM7dI6JxOxfqYQ.png">
</p>

As you can see in the image alongside, there are 9 layers i.e Conv2D, Max Pool 2D followed by Flatten layer at the last.
The first layer is of conv 2D whereas the second layer is Max pool 2D layer. This is the alternate sequence i followed till the end.
The output of conv2D is given to max pool 2 D layer which will give to forward conv2D and respectively.

<p align="center">
<img width="700" height="400" src="https://miro.medium.com/max/781/0*ySguiaxt0GrzEwJN">
</p>

The calculation between the image pixel and kernel values is known as convolve. New image extracted by convolution is always small because after some important feature extraction the pixels are reduced in the new image therefore the new image is always small compare to original image. But this image include more pixels of same information (color, objects) as there are more pixels in the convolved image then for training this image there’s requirement of high processing power as well as cost. To reduce this requirement we can reduce the pixel of the same information and merge them into one pixel. This can be achieved by Pooling. There are three types of pooling 1) Max Pooling 2) Average Pooling 3) Sum Pooling. We use Max pooling in many of the cases but it depends on requirements. Below is an example of Max pooling.

<p align="center">
<img width="700" height="400" src="https://miro.medium.com/max/781/0*4YwzYPd0NOInchYR">
</p>

There is a layer of activation function ‘relu’. This relu activation will give only positive value to next convolutional layer i.e if first convolutional layer transfers negative value to next convolutional layer then relu will send only positive value and will convert the negative value to zero. Because there cannot be negative prediction. This layers are in 2D and machine learning model not understand higher dimensional inputs there we have to flatten these layers value and convert this into 1D and then this flatten values will acts as a input to neural network i.e is to send flatten values to Fully connected layer.

The above which we have created is the CNN layer now lets crate Neural network layers so that we can train the model.

<p align="center">
<img width="1000" height="400" src="https://miro.medium.com/max/1094/1*hed1_A5BK5dzXidA_q15Uw.png">
</p>

In the above image i have created neural network. I have taken activation layer as relu. The another function will helps you to give the summary of the model.

## Why RELU ?

<p align="center">
<img width="700" height="400" src="https://miro.medium.com/max/781/0*dPlRHDeKFaaBA82G.png">
</p>
The rectified linear activation function or ReLU for short is a piecewise linear function that will output the input directly if it is positive, otherwise, it will output zero. … The rectified linear activation function overcomes the vanishing gradient problem, allowing models to learn faster and perform better.
After creating neural network we have to compile the model before training. I have created compile_image function which will helps model to compile before training. In the cnn.compile() function i have used below parameteres.

```
1. optimizer: This will helps you to reduce the loss and helps the model to gain more accuracy.
2. I have used here Adam optimizer which is comparatively useful than other optimizers.
3. learning_rate: This parameter inside Adam will helps the Adam to learn the weights and helps the model to gain more accuracy.
4. loss: As our output is multi classification therefore we have to use loss type as categorical cross entropy.
5. metrics=[Accuracy]: This parameter will helps us to tell the accuracy at every epoch.
```

<p align="center">
<img width="1000" height="100" src="https://miro.medium.com/max/1094/1*bpdAWG9M8gIcNxhWZnF3uQ.png">
</p>

Now we are ready to train our CNN brain tumor model . In the below image i have used .fit() function which will helps us to fit/train the model. It accepts

```
x --> training_set
validation_data --> testing_set
epochs = 50
```

<p align="center">
<img width="1000" height="100" src="https://miro.medium.com/max/1094/1*U-WLIGVRMG_o7swUbHwUUg.png">
</p>
Now if you wanted to predict the model you can use check below code syntax which helps to predict the output.

<p align="center">
<img width="1000" height="500" src="https://miro.medium.com/max/1094/1*rtEYOMyzlZKUmxM27z2d2Q.png">
</p>

<p align="center">
<img width="600" height="100" src="https://miro.medium.com/max/997/1*3zGsCY-HmRWY6LerIPmLCg.png">
</p>

After knowing the classes indices you will find that

```
index 0 represents → Galioma Tumor
index 1 represents → Meningioma Tumor
index 2 represents → No Tumor
index 3 represents → Pituitary Tumor
```

After model training we have to save the model in .h5 file. After saving we will put this model into a docker file where we will create a webapp using flask and html, css, javascript. Now the machine learning part is done lets move to DevOps part to do some operation using automation and provisioning tools.


## Creating workspace for Hybrid multi cloud management:
For multi cloud management we have to set the workspace. Here below i have created three workspace and the code of terraform will launch the resources in their workspace with respect to their cloud.

```
terraform workspace new workspace_name   --> creating new workspace
terraform workspace list     --> will show all the workspace
terraform workspace show     --> will show the current workspace
```

<p align="center">
<img width="1000" height="100" src="https://miro.medium.com/max/1094/1*-qUaaYoO4lmUqnQ12ShqjQ.png">
</p>

By default terraform create a default workspace and the * represents the current workspace. Here above i have create three workspace i.e.

```
1. aws_prod → For Kubernetes Cluster
2. azure_prod → Jenkins Configuration
3. gcp_dev → For Creating Docker image and push to docker_hub.
```

Now we have to launch instances with their architecture on different clouds e.g. AWS, Azure, GCP. Here i will use terraform for provisioning the instances on different cloud. The below architecture will helps you know what i am doing on aws.

