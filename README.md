# Jupyter Notebook Image

This allows for users to run jupyter notebook on their ZCX instance

## Building the image
`docker build . --tag jupyter_notebook_s390x`


## Usage
By default the the notebook server will run on port 8888 so these ports must be exposed when issuing the docker run:

`docker run --rm -it -p 8888:8888 jupyter_notebook_s390x`

The server should now be accessible at the IP of your system on port 8888, but will require an authorization token to log in. By checking the logs you can find the access token to use.

#### Example Log
```
to access the notebook, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/nbserver-14-open.html
    Or copy and paste one of these URLs:
        http://172.17.0.4:8888/?token=4af405f0407002fe3d636e8727cd0939bef99ca4a2176dad
     or http://127.0.0.1:8888/?token=4af405f0407002fe3d636e8727cd0939bef99ca4a2176dad
```

In this case you would access your notebook server by this URL and replacing your system IP: 

http://YOUR_SYSTEM_IP:8888/?token=4af405f0407002fe3d636e8727cd0939bef99ca4a2176dad

### Using your own notebooks
If you wish to use pre-existing notebooks with the notebook server you should mount them in a volume to `/home/notebooks`

`docker run --rm -it -p 8888:8888 -v myvolume:/home/notebooks jupyter_notebook_s390x`

#### Specifying a non-default notebook dir
If you would like to use a different path aside from `/home/notebooks` you may do so by specifying the `NBDIR` environment variable.

`docker run --rm -it -p 8888:8888 -e NBDIR=/home/ANOTHERDIR jupyter_notebook_s390x`
