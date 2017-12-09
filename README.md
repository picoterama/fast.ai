# Practical Deep Learning For Coders
Taught by Jeremy Howard

## Links and References
- [Getting Started Notes](http://course.fast.ai/start.html)
- [Files](http://files.fast.ai/)
- [Forums](http://forums.fast.ai/)
- [Course repo on GitHub](https://github.com/fastai/courses/tree/master/setup)
- http://course.fast.ai/index.html
- [Tensoflow article on Toptal Blog](https://www.toptal.com/machine-learning/tensorflow-machine-learning-tutorial)

## TODO
- docker: Does  not work yet!
- Repeatable anaconda2 setup on Mac: Not workingm see below
- convert pdf to png with [`sips`](https://ademcan.net/blog/2013/04/10/how-to-convert-pdf-to-png-from-the-command-line-on-a-mac/)
  - `sips -s format png your_pdf_file.pdf --out your_png_file.png`
- Run local conda in docker?

## Anaconda on Mac
Does not yet work: all kinds of version conflicts between theano, keras and vgg16
- Following: https://github.com/fastai/courses/blob/master/setup/install-gpu.sh#L27:1
- As per http://wiki.fast.ai/index.php/Local_install_(Windows_only:cpu)
```
conda create --name fastai
source activate fastai
conda install -y bcolz
conda upgrade -y --all
pip install keras==1.2.2 # --> implies theano
# edit ~/.keras/keras.json: "image_dim_ordering": "th", "backend": "theano"
pip install matplotlib
pip install pillow  # Same as PIL
pip install sklearn
conda install mkl-service # not sure if this is required, but getting warning from notebook
```

## Docker on Mac
See [Keras repo](https://github.com/fchollet/keras/tree/master/docker).

## Lesson 1 alternative datasets:
- [Distracted Driver](https://www.kaggle.com/c/state-farm-distracted-driver-detection/data)
- [Galaxy Zoo](https://www.kaggle.com/c/galaxy-zoo-the-galaxy-challenge/data)

## Operation
- setup aliases
```
export AWS_DEFAULT_OUTPUT=text
. aws-alias.sh 
aws-get-p2; aws-ip ; aws-state
```

- ssh into host
- password `dl_course`
```
cd nbs; jupyter notebook
```

## Setup 
### Bring up a GPU instance
The first time this is run it creates a keypair: `~/.ssh/aws-key-fast-ai.pem`.
```
cd setup
bash setup_p2.sh
. aws-alias.sh

# ssh into instance and ...
sudo chown ubuntu.ubuntu .bash_history
# --or --
sudo rm .bash_history

```

And to tear it down
```
cd setup
./fast-ai-remove.sh 
```

### Upstream repo ans scripts
Keep a handy link to the upstream repo in a local folder.
```
git clone https://github.com/fastai/courses.git upstream
```

### Local Python [Anaconda](https://www.anaconda.com/download/#macos)
- Installed version 5.0.1 on dirac
- Can't I just use docker?

Here is the links to uninstall: 
- [Stack Overflow](https://stackoverflow.com/questions/22585235/python-anaconda-how-to-safely-uninstall)
- [Anaconda Docs](https://docs.anaconda.com/anaconda/install/uninstall)

### [AWS](http://course.fast.ai/lessons/aws.html)
Generate `fastai` user in IAM (imetrical account)
```
brew install awscli
```
