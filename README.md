## Terraform

If you don't already have terraform installed, instructions can be found [here](https://learn.hashicorp.com/tutorials/terraform/install-cli#install-terraform).

You can use environment variables to configure terraform with your newly issued AWS keys that point to the Peregrine sandbox environment, located in us-east-2:

```
export AWS_ACCESS_KEY_ID="xxx"
export AWS_SECRET_ACCESS_KEY="zzz"
export AWS_DEFAULT_REGION="us-east-2"
```

## Web app

### Dependencies
Create a new python virtual environment and install the dependencies. For example, using venv:
```
python3 -m venv peregrine
source peregrine/bin/activate
pip install -r requirements.txt
```

### Running the web app

The python app is built on the flask framework. To run it locally ensure you've invoked a virtual environment then run the app using the flask command
```
source peregrine/bin/activate
flask run
```
The app can be accessed on port 5000. Example pages:

http://127.0.0.1:5000   
http://127.0.0.1:5000/version

# Laura's Notes

I wish I had been able to make more progress on this exercise in the given time! It's been a bit since I've worked in AWS so I was a little slower than I would have liked :( However, I'll leave some notes here to indicate what my thinking is on what I would tackle next, if provided more time:
1. Update the web app's Dockerfile to pull database credentials from secretmanager
2. Push the Flask web app Docker image to the Elastic Container Registry
3. Get the Web App running in Amazon Elastic Container Service using AWS Fargate (verify that it is able to connect to the database). Deploy this in the web-app VPC.
4. Refine the VPC security groups and NACL rules
5. Debug why I couldn't migrate local terraform state to the remote backend (something odd going on with regions I can access s3 in)

Thanks for the opportunity to do the exercise! 
