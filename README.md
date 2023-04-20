# Azure-CDN-Static-Website-Terraform
In this project, I have leveraged various Azure services to create and deploy a static website. Using Blob storage container, I hosted the static website, and deployed it with the help of the Azure Content Delivery Network, ensuring fast and reliable delivery to users across the globe. To ensure security, I have integrated Snyk with my Github repository to scan for vulnerabilities and potential security loopholes. Additionally, I have automated the deployment process using Github Actions and Terraform. The authentication to Azure is being handled via a secure service principal, and the entire deployment process is executed automatically. To give my CDN a customized domain name, I have used Azure DNS Zone, retrieving DNS records from my Go Daddy DNS.

Link to Website: https://rjcdn.azure.vsystems.online/


## Website Breakdown

The website is broken down into the architecture below:

![storage-website](https://github.com/rjones18/Images/blob/main/Azure%20CDN%20Static%20Site.png)


