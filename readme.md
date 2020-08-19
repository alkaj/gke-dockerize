# Description
  This small package is intended to make any static website(ie: made of html, css, js and assets) to be served by nginx from a Docker container making it easy and fast to deploy.
    
    
# How to use ?

### 1. Install
You can use npm  
  
``` npm install static-dockerizer ```  
  
Doing so should create a `Dockerfile` and a `.dockerignore` at the root of your project, feel free to edit the ```.dockerignore``` to fit the Docker context you want to send, the NGINX server has some basic caching settings but you can also edit the ```Dockerfile``` to fine-tune them.
  
If you don't feel like using npm, just download the zip tarball from this page, unzip it and copy the ```Dockerfile``` and ```.dockerignore``` into the root of your project, then edit them at your convenience.  
  
### 2. Build the image
build the docker image  
  
``` docker build -t my-static-site-image . ```  
  
### 3. Run it locally  
Run the image locally to test your site  
  
``` docker run -p 8080:80 -d  my-static-site-image ```  
  
Then visit ``` localhost:8080 ``` from your browser to make sure it works.  

### 4. Push  
Push it to any registry for deployment  
  
### 5. Notes
  
* The container exposes port ``` 80 ```  
* The server expects a ``` 404.html ``` as 404 error page.
