# Azure-CDN-Static-Website-Terraform
In this project, I have utilized several Azure services to craft and deploy a static website. With the Blob storage container, the static website is hosted and then rolled out using the Azure Content Delivery Network, guaranteeing swift and dependable access to users worldwide.

To bolster security, I have incorporated both Snyk and Defender for DevOps in the GitHub Actions pipeline. While Snyk scans for vulnerabilities and possible security breaches, Defender for DevOps conducts a thorough security examination, the results of which are relayed to Azure Defender for Cloud. This integration ensures that security findings are constantly monitored and evaluated.

The deployment workflow is automated using GitHub Actions coupled with Terraform. Authentication to Azure is managed via a secure service principal, ensuring the deployment process is both automated and secure. And for a more branded experience, I've used Azure DNS Zone, pulling DNS records from my Go Daddy DNS, to give my CDN a customized domain name.

Link to Website: https://rjcdn.azure.vsystems.online/


## Website Breakdown

The website is broken down into the architecture below:

![storage-website](https://github.com/rjones18/Images/blob/main/Azure%20CDN%20Static%20Site%20(5).png)


