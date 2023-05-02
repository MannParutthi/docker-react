# React App + Travis CI + Docker + AWS Beanstalk

## Docker Compose config Update

Make sure to follow the steps in the earlier lecture note to rename your development docker compose file and create a new production compose file:

https://www.udemy.com/course/docker-and-kubernetes-the-complete-guide/learn/lecture/27975358



## Create EC2 IAM Role

1. Go to AWS Management Console

2. Search for IAM and click the IAM Service.

3. Click Roles under Access Management in the left sidebar.

4. Click the Create role button.

5. Select AWS Service under Trusted entity type. Then select EC2 under common use cases.

6. Search for AWSElasticBeanstalk and select both the AWSElasticBeanstalkWorkerTier and AWSElasticBeanstalkMulticontainerDocker policies. Click the Next button.

7. Give the role the name of aws-elasticbeanstalk-ec2-role

8. Click the Create role button.



## Create EBS Environment

1. Go to AWS Management Console

2. Search for EBS and click the Elastic Beanstalk service.

3. If you've never used EBS before you will see a splash page. Click the Create Application button. If you have created EBS environments and applications before, you will be taken directly to the EBS dashboard. In this case, click the Create environment button. There is now a flow of 6 steps that you will be taken through.

5. You will need to provide an Application name, which will auto-populate an Environment Name.

6. Scroll down to find the Platform section. You will need to select the Platform of Docker. This will auto-populate the rest of the fields.

7. Scroll down to the Presets section and make sure that free tier eligible has been selected:

8. Click the Next button to move to Step #2.

9. You will be taken to a Service Access configuration form.

If you are presented with a blank form where the Existing Service Roles field is empty, then, you should select Create and use new service role. You will need to set the EC2 instance profile to the aws-elasticbeanstalk-ec2-role created earlier (this may be auto-populated for you).

If both Existing Service Roles and EC2 Instance Profiles are populated with default values, then, select Use an existing service role.

10. Click the Skip to Review button as Steps 3-6 are not applicable.

11. Click the Submit button and wait for your new EBS application and environment to be created and launch.

12. Click the link below the checkmark under Domain. This should open the application in your browser and display a Congratulations message.



## Update Object Ownership of S3 Bucket

1. Go to AWS Management Console

2. Search for S3 and click the S3 service.

3. Find and click the elasticbeanstalk bucket that was automatically created with your environment.

4. Click Permissions menu tab

5. Find Object Ownership and click Edit

6. Change from ACLs disabled to ACLs enabled. Change Bucket owner Preferred to Object Writer. Check the box acknowledging the warning.

7. Click Save changes.



## Add AWS configuration details to .travis.yml file's deploy script

1. Set the region. The region code can be found by clicking the region in the toolbar next to your username.

eg: 'us-east-1'

2. app should be set to the Application Name (Step #4 in the Initial Setup above)

eg: 'docker'

3. env should be set to the lower case of your Beanstalk Environment name.

eg: 'docker-env'

4. Set the bucket_name. This can be found by searching for the S3 Storage service. Click the link for the elasticbeanstalk bucket that matches your region code and copy the name.

eg: 'elasticbeanstalk-us-east-1-923445599289'

5. Set the bucket_path to 'docker'

6. Set access_key_id to $AWS_ACCESS_KEY

7. Set secret_access_key to $AWS_SECRET_KEY



## Create an IAM User

1. Search for the "IAM Security, Identity & Compliance Service"

2. Click "Create Individual IAM Users" and click "Manage Users"

3. Click "Add User"

4. Enter any name you’d like in the "User Name" field.

eg: docker-react-travis-ci

5. Click "Next"

6. Click "Attach Policies Directly"

7. Search for "beanstalk"

8. Tick the box next to "AdministratorAccess-AWSElasticBeanstalk"

9. Click "Next"

10. Click "Create user"

11. Select the IAM user that was just created from the list of users

12. Click "Security Credentials"

13. Scroll down to find "Access Keys"

14. Click "Create access key"

15. Select "Command Line Interface (CLI)"

16. Scroll down and tick the "I understand..." check box and click "Next"

Copy and/or download the Access Key ID and Secret Access Key to use in the Travis Variable Setup.



## Travis Variable Setup

1. Go to your Travis Dashboard and find the project repository for the application we are working on.

2. On the repository page, click "More Options" and then "Settings"

3. Create an AWS_ACCESS_KEY variable and paste your IAM access key from step #13 above.

4. Create an AWS_SECRET_KEY variable and paste your IAM secret key from step #13 above.



## Deploying App

1. Make a small change to your src/App.js file in the greeting text.

2. In the project root, in your terminal run:

git add.
git commit -m “testing deployment"
git push origin main
3. Go to your Travis Dashboard and check the status of your build.

4. The status should eventually return with a green checkmark and show "build passing"

5. Go to your AWS Elasticbeanstalk application

6. It should say "Elastic Beanstalk is updating your environment"

7. It should eventually show a green checkmark under "Health". You will now be able to access your application at the external URL provided under the environment name.



## Getting Started with Create React App

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.\
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can't go back!**

If you aren't satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you're on your own.

You don't have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn't feel obligated to use this feature. However we understand that this tool wouldn't be useful if you couldn't customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: [https://facebook.github.io/create-react-app/docs/code-splitting](https://facebook.github.io/create-react-app/docs/code-splitting)

### Analyzing the Bundle Size

This section has moved here: [https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size](https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size)

### Making a Progressive Web App

This section has moved here: [https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app](https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app)

### Advanced Configuration

This section has moved here: [https://facebook.github.io/create-react-app/docs/advanced-configuration](https://facebook.github.io/create-react-app/docs/advanced-configuration)

### Deployment

This section has moved here: [https://facebook.github.io/create-react-app/docs/deployment](https://facebook.github.io/create-react-app/docs/deployment)

### `npm run build` fails to minify

This section has moved here: [https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify](https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify)
