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

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*sTGm6OIOQ7QkRiZBqozOHg.gif">
</p>

For doing provisioning on terraform you have to set provisioner for aws. You have to create a profile. Here i have created terraformuser. you can create profile using below command. You have to set the access key and secret key of IAM user in AWS. I have given region is ap-south-1(mumbai[india]).
`Note: You have to create IAM user in AWS.`

```
C:\Users\Amit>aws configure  --profile terraforuser(user_name)
AWS Access Key ID : XXXXXXXXXXX
AWS Secret Access Key : XXXXXXXXXXX
Default region name : ap-south-1
Default output format : none
```
<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*6Utj3cxsUmiG8eoJILxDUg.png">
</p>
Now you can go for provisioning resources in aws. Below are the resources which i have provisioned in aws.
```
1. VPC
2. Subnets
3. Route table
4. Subnet association with route table
5. Internet Gateway
6. security group
7. 4 ec2 instances.
```

## VPC:
Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you’ve defined. This virtual network closely resembles a traditional network that you’d operate in your own data center, with the benefits of using the scalable infrastructure of AWS.
<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*wca_Orve5Gksa-Y6vcakRA.png">
</p>

the above code will create VPC. The above vpc block accept the cidr_block. you can enable dns support given to ec2 instances after launching. You can give the tag name to the above vpc. Here i have given “TerraformVpc”. We have to launch this resource in aws only so as we are doing hybrid multi cloud management therefore in every resource we have to specify workspace condition. If terraform.workspace == aws_prod then launch one vpc.


## Creating Subnets
Subnetwork or subnet is a logical subdivision of an IP network. The practice of dividing a network into two or more networks is called subnetting. AWS provides two types of subnetting one is Public which allow the internet to access the machine and another is private which is hidden from the internet. Here i am using element function which will help to take the count index (count of a resource) of the vpc and take the same index value which is inside var.az variable file. you can find all the codes in the github link below at the end.
<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*dyjcnV8JPIoxbbFD2kocsQ.png">
</p>

## Creating Security Group

A security group acts as a virtual firewall for your EC2 instances to control incoming and outgoing traffic. … If you don’t specify a security group, Amazon EC2 uses the default security group. You can add rules to each security group that allow traffic to or from its associated instances.

<p align="center">
  <img width="800" height="800" src="https://miro.medium.com/max/1094/1*wEiUYWWfAKmNduKUvhLwcA.png">
</p>

The above block of code will create a security group. It accepts the respective parameters name(name of the security group), vpc_id, ingress(inbound rule) here i have given “all traffic”. “-1” means all. from_port= 0 to_port=0 (0.0.0.0) that means we have disabled the firewall. you need to mention the range of IP’s you want have in inbound rule.


The egress rule is the outbound rule. I have taken (0.0.0.0/0) means all traffic i can able to access from this outbound rule. You can give the name of respective Security Group.


## Creating InternetGateway
An internet gateway serves two purposes: to provide a target in your VPC route tables for internet-routable traffic, and to perform network address translation (NAT) for instances that have been assigned public IPv4 addresses.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*xiOzNes2dVu5MaViYfe3Sw.png">
</p>

the above code will create you respective internet gateway. you need to specify on which vpc you want to create internet gateway. Also you can give name using tag block.

## Creating Route Table
A route table contains a set of rules, called routes, that are used to determine where network traffic from your subnet or gateway is directed.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*rUMT12O2TWaGKQpavHkMVw.png">
</p>

You need to create a route table for the internet gateway you have created above. Here, i am allowing all the IP rage. So my ec2 instances can connect to the internet world. we need to give the vpc_id so that we can easily allocate the routing table to respective vpc. You can specify the name of the routing table using tag block.

## Route Table Association To Subnets
We need to connect the route table created for internet gateways to the respective subnets inside the vpc.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*N260BaY3KDFTlN1tVb9LJA.png">
</p>

You need to specify which subnets you want to take to the public world. As if the subnets gets associated(connected) to the Internet Gateway it will be a public subnet. But if you don’t associate subnets to the Internet gateway routing table then it will known as private subnets. The instances which is launched in the private subnet is not able to connected from outside as it will not having public IP, also it will not be connected to the Internet Gateway.

You need to specify the routing table for the association of the subnets. If you don’t specify the routing table in the above association block then subnet will take the vpc’s route table. So if you want to take the ec2 instances to the public world then you need to specify the router in the above association block. Its upon you which IP range you want you ec2 instances to connect. Here i have give 0.0.0.0/0 means i can access any thing from the ec2 instances.

## Creating Ec2 Instances

An EC2 instance is nothing but a virtual server in Amazon Web services terminology. It stands for Elastic Compute Cloud. It is a web service where an AWS subscriber can request and provision a compute server in AWS cloud. … AWS provides multiple instance types for the respective business needs of the user.

## Ansible Controller Node:

<p align="center">
  <img width="1000" height="3300" src="https://miro.medium.com/max/1094/1*tA6P7Ndm3_7N6t3D6lPn5Q.png">
</p>

In the above code, it will create a new instance. It accepts the following parameters.

```
ami-> image name
instance_type-> type of instances
subnet_id-> In which subnet you want to launch instance
vpc_security_group_ids->  Security Group ID
key_name-> key name of instance
Name-> name of the instance
```

In the above terraform code i have launched one ec2 instance(Ansible_Controller_Node) and then using remote_exec module i transferred the files from local to ec2 instances inside /home/ec2-user and from there i moved to respective files and folders. For detailed configuration of ansible controller node visit here. The ansible playbook you will find in the github only.Launching Target Nodes:

For launching Slave nodes you have to just change the names of the os in the variable file. you have to pass these variables using index values like if you give var.osnames[0] → Ansible_controller_node, var.osnames[1] → K8S_Master, var.osnames[2] → K8S_Slave1, var.osnames[3] → K8S_Slave2.

<p align="center">
  <img width="1000" height="100" src="https://miro.medium.com/max/1094/1*yfwOUh4zOsH234i5ojzcrg.png">
</p>

## Master Node:

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*5gJz0q3WV_n3vm7gG2fGKg.png">
</p>

## Slave Node1:

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*ehAecd6Sh7aGfzyJDStZcg.png">
</p>

## Slave Node2:

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*ByhrSJUTTdJDVk7J5V1fOQ.png">
</p>

After launching all the ec2 instances and configuring ansible on Ansible_Controller_Node, ansible will automatically configure the kubernetes cluster inside the master and slave nodes. I have used here dynamic inventory so that ansible will fetch the public ip with their tag_names and helps to configure the kubernetes cluster dynamically.

<p align="center">
  <img width="1000" height="70" src="https://miro.medium.com/max/1094/1*jgkp0nJPPnsxOJjFxyicqw.jpeg">
</p>

## Switcthing Azure Workspace:
Now we have to launch one VM into azure cloud and and inside that we will configure jenkins. Before that you have to set the provisioner for azure cloud.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*05kBBOKKw50byqu1fXdzzQ.png">
</p>

you have to got to azure cli in azure portal from which you will get subcription_id, client_id, client_secret, tenant_id.
<p align="center">
  <img width="700" height="700" src="https://miro.medium.com/max/1094/1*Tzj2lAkuzoPT_lfi1oSCcg.png">
</p>

Now we have to create a code for launching virtual machine in azure. below is the code which will help you to create a vm in azure.

## What is a resource group
A resource group is a container that holds related resources for an Azure solution. The resource group can include all the resources for the solution, or only those resources that you want to manage as a group. You decide how you want to allocate resources to resource groups based on what makes the most sense for your organization. Generally, add resources that share the same lifecycle to the same resource group so you can easily deploy, update, and delete them as a group. we have to set the condition that if terraform.workspace == azure_prod then launch one resource group.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*xsvCAxVIx6rDiXOuXRCroA.png">
</p>

## What is Azure Virtual Network?

Azure Virtual Network (VNet) is the fundamental building block for your private network in Azure. VNet enables many types of Azure resources, such as Azure Virtual Machines (VM), to securely communicate with each other, the internet, and on-premises networks. VNet is similar to a traditional network that you’d operate in your own data center, but brings with it additional benefits of Azure’s infrastructure such as scale, availability, and isolation.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*RUK8-Ega6XSFUuMNBKwRzg.png">
</p>

## Subnets:
A subnet is a range of IP addresses in the VNet. You can divide a VNet into multiple subnets for organization and security. Each NIC in a VM is connected to one subnet in one VNet. NICs connected to subnets (same or different) within a VNet can communicate with each other without any extra configuration.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*2RBNcJdltpgZQ2qnGFD8Ig.png">
</p>

## Network security groups:
You can use an Azure network security group to filter network traffic to and from Azure resources in an Azure virtual network. A network security group contains security rules that allow or deny inbound network traffic to, or outbound network traffic from, several types of Azure resources. For each rule, you can specify source and destination, port, and protocol. In the below code i have give all traffic permission for inbound.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*bhKtQFA0bvXkzMrq5CwMKA.png">
</p>

## Network Security group Association
Associates a Network Security Group with a Subnet within a Virtual Network.

<p align="center">
  <img width="1000" height="230" src="https://miro.medium.com/max/1094/1*TA9b-Sr93vJIoCDKB88IXg.png">
</p>

## Nic Card:
A Network Interface (NIC) is an interconnection between a Virtual Machine and the underlying software network. An Azure Virtual Machine (VM) has one or more network interfaces (NIC) attached to it. Any NIC can have one or more static or dynamic public and private IP addresses assigned to it.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*l9hvmUKxr4WwAJ-Y2DjLdg.png">
</p>

## Public_IP: 

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*dCnt61Ley_ZqeV0Ype2t2A.png">
</p>

## Storage account:
An Azure storage account contains all of your Azure Storage data objects: blobs, file shares, queues, tables, and disks. The storage account provides a unique namespace for your Azure Storage data that’s accessible from anywhere in the world over HTTP or HTTPS. Data in your storage account is durable and highly available, secure, and massively scalable.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*TsUxRuJ5bezKmf4M8UJusQ.png">
</p>

## Launching Virtual Machines:
Azure Virtual Machines (VM) is one of several types of on-demand, scalable computing resources that Azure offers. Typically, you choose a VM when you need more control over the computing environment than the other choices offer. This article gives you information about what you should consider before you create a VM, how you create it, and how you manage it.
An Azure VM gives you the flexibility of virtualization without having to buy and maintain the physical hardware that runs it. However, you still need to maintain the VM by performing tasks, such as configuring, patching, and installing the software that runs on it.

<p align="center">
  <img width="1000" height="1500" src="https://miro.medium.com/max/1094/1*tNRNIViIy7sgHwQeFkPszA.png">
</p>

In the above code i have launched one vm and using remote_exec module i configured jenkins node into that respective vm.
```
Following configuration done in JenkinsNode
1. Installed Java
2. Installed Git
3. Installed Jnekins
4. Started Jenkins
5. Enabled Jenkins
```

<p align="center">
  <img width="1000" height="400" src="https://miro.medium.com/max/1094/1*LKJWW3sBueh4XJ_FOtt7Cg.jpeg">
</p>

Now after launching the node successfully take public_ip and on port 8080 your jenkins node will be running. It will look something like this below image.

<p align="center">
  <img width="1000" height="400" src="https://miro.medium.com/max/1094/0*v6nZ6vEAa7Nn7XaM.jpeg">
</p>

You have to copy the location and paste inside jenkins node like this `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`.

it will give a password text and you have to paste inside above Admini

<p align="center">
  <img width="1000" height="100" src="https://miro.medium.com/max/1094/0*tHlSN9JKuR2lOqqk.jpeg">
</p>

After that you need to create a password because this password is too long and hard to remember. So below are the steps shown in the video to create the password and to install the restive plugins. Ensure that you have to install below plugins.

## Installing Plugins In jenkins:
Plugins from below lists needed to be installed:
1. ssh: ssh plugins need to install for connecting the kubernetes servers.

<p align="center">
  <img width="1000" height="100" src="https://miro.medium.com/max/1094/1*7ZZ9wN4wfRqHzlo2xPWBSw.jpeg">
</p>

2. Gihub: Github plugins need to install to us SCM services.

<p align="center">
  <img width="1000" height="50" src="https://miro.medium.com/max/1094/1*EU-yO4CqG-eiuZmKDN1bcw.jpeg">
</p>
3. Pipeline: Pipline plugin will helps you to automate the jobs and make your setup easy.

## Now we have to create a Deep Learning Image in GCP:

In GCP, we have to launch one compute instances. As we only have to create a deep learning image so using Dockerfile

```
Steps to follow:
1. Launch one Compute instance
2. Install Docker in that Compute instance
3. Create a Dockerfile
4. Install python, required libraries
5. Install Flask
6. Install Apache web server
```

## Provisioner For GCP:
First we have to set the provisoner for gcp. you need to set the service account first in gcp → IAM user → service account. It will give you a file in the json format you have to download that file and keep in a directory.
You have to specify the project name here i have given multicloud-315014, you can give any name. Also you need to specify the region name, i have given asia-south1.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*Pi-uv6J7QixMq4i1S6mG9A.png">
</p>

## Launching a Compute instance:

Google Compute Engine is the Infrastructure as a Service component of Google Cloud Platform which is built on the global infrastructure that runs Google’s search engine, Gmail, YouTube and other services. Google Compute Engine enables users to launch virtual machines on demand.

<p align="center">
  <img width="1000" height="700" src="https://miro.medium.com/max/1094/1*phyBuwEK4DOA3_i1xq0Pmg.png">
</p>

To connect to compute instance and run commands using remote_exec then you have to set the metadata (ssh key).
<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*zCseChOzp9r5dgQqdxbwtg.png">
</p>

Now to transfer any files you have to use file module that will helps you to transfer the files from local to compute instance.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*nwSdZuUrL0ZWMFxBa5iPvA.png">
</p>

Here i am transfering only dockerfile. Below code will helps you to create a docker file.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*yFgEavGWNsCiio5oJnyMfg.png">
</p>

Now we have to run the commands in the compute instance which helps us to create the deep learning image and it will push to docker hub simultaneously.

<p align="center">
  <img width="1000" height="700" src="https://miro.medium.com/max/1094/1*3p_V4hGbISVKcVBWZLUdIQ.png">
</p>

<p align="center">
  <img width="1000" height="300" src="https://miro.medium.com/max/1094/1*0L_ClvugBvbvyewQxPkqPw.png">
</p>

After running above all the commands terraform will publish the image to dockerhub and it will looks something like this.

<p align="center">
  <img width="1000" height="150" src="https://miro.medium.com/max/1094/1*lyFm7O3pgcnmpCgfO1AgDA.jpeg">
</p>

As our image is ready so now you have to create a repository in github and add the pipeline code in that repo inside Jenkinsfile.

<p align="center">
  <img width="1000" height="700" src="https://miro.medium.com/max/1094/1*FnJKauF9koQA9fHBxNgyNg.png">
</p>

Now we need to copy the url of repository and you have to create a new job with multibranch pipeline and you need to to add source “git” and paste the url and save the job.

<p align="center">
  <img width="1000" height="500" src="https://miro.medium.com/max/1094/1*l_pfKXyclV75u12w5_xcyg.jpeg">
</p>

## Adding a Node:
Now you have to create a node by going into managed node and cloud, give node name, here i have given kubernetes_brain_tumor and click on permanent node.

<p align="center">
  <img width="1000" height="300" src="https://miro.medium.com/max/1094/1*cOaBPi-dz9QXtVwFiWuAkA.jpeg">
</p>

Then you have to enter the node home directory, so put /home/ec2-user as it came from from ec2 instance. Then add label to the node so that you can write in jenkinsfile i.e. on which node you wanted to run the job.

<p align="center">
  <img width="1000" height="700" src="https://miro.medium.com/max/1094/1*BZslzeA_pTAxtVb4susKoQ.jpeg">
</p>

After saving the job it will looks like below image

<p align="center">
  <img width="1000" height="150" src="https://miro.medium.com/max/1094/1*wmn1pXyDclxDsMza_pKw8A.jpeg">
</p>

Now you have to just click on build and your job will start building. Below is the console output of the job.

<p align="center">
  <img width="1000" height="600" src="https://miro.medium.com/max/1094/1*zn_4uFm9_ks3BakJQeAa_Q.jpeg">
</p>

<p align="center">
  <img width="1000" height="600" src="https://miro.medium.com/max/1094/1*zn_4uFm9_ks3BakJQeAa_Q.jpeg">
</p>

As you can see that job ran successfully, now we have to see the deployment in kubernetes cluster. So go to kubernetes master node and then type below commands.

<p align="center">
  <img width="1000" height="400" src="https://miro.medium.com/max/1094/1*96MkU5mzTtGuNr-7qKzpkw.png">
</p>

As you can see in the below image that one pod is running and exposed on the port 30801 a web ui will appear and it will ask you to enter the brain MRI image and after clicking on submit it will predict that a person with that brain mri image having brain tumor or not.

<p align="center">
  <img width="1000" height="500" src="https://github.com/amit17133129/Brain_Tumor_Detection_MLops_and_Hybrid_Multi_Cloud/blob/main/brain_tumor_final.gif">
</p>
