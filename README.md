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