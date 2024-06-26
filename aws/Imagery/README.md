## Imagery 
Imagery is a fault-tolerant web app hosted on AWS. Users can upload an image and apply a sepia filter. To improve felxibility and scalability, the process is designed as asynchronous (SQS).

When a user wants to upload an image, the user creates a process first. This returns a unique ID. With that ID, the user can upload an image. If the image upload is finished, the worker begins to process the image in the background.


1. The process is stored in DynamoDB.
2. With the process ID, the user uploads an image to S3. The S3 key is persisted to DynamoDB together with the new process state “uploaded.” A SQS message is produced to trigger processing.
3. The SQS message is consumed by an EC2 instance. The raw message is downloaded from S3 and processed, and the sepia image is uploaded to S3. 
4. The process in DynamoDB is updated with the new state “processed” and the S3 key of the sepia image.
5. S3 contains the sepia image. DynamoDB knows the S3 key.


The image's state transitions are made idempotent: (Created) -> (Uploaded) -> (Processed).
The Imagery application is spit into two parts: the web servers and the workers. The web servers provide the REST API to the user, and the workers process images.


The web server is implemented with the Express framework. The REST API will support the following routes:
* POST /image — A new image process is created when executing this route.
* GET /image/:id — This route returns the state of the process specified with the path parameter.
* POST /image/:id/upload — This route offers a file upload for the process specified with the path parameter.

The worker runs through the following steps in an endless loop:
1. Poll the queue for new messages.
2. Fetch the process data from the database.
3. Download the image from S3.
4. Apply the sepia filter to the image.
5. Upload the modified image to S3.
6. Update the process state in the database.
7. Mark the message as done by deleting it from the queue.

A custom AMI is created with the help of Packer. 
CloudFormation is used to deploy the application.   

![MISSING IMAGE](Imagery.drawio.png)

![MISSING IMAGE](application-composer-template.yml.png)


