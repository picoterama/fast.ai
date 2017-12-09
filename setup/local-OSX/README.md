# This is to develop locally on Mac OSX

## Anaconda

Download and install Anaconda 2.7 from the [Anaconda download site](https://www.anaconda.com/download/#macos).

To get the lesson1 notebook to work, we replicated the necessary versions of keras and theano (by discovering what was on the p2/t2 AMI's)

Also used these as hints:
- Following: https://github.com/fastai/courses/blob/master/setup/install-gpu.sh#L27:1
- As per http://wiki.fast.ai/index.php/Local_install_(Windows_only:cpu)

```
conda env create -f environment.yml
conda info --envs
source activate testai

source deactivate
conda env remove --name testai
```

By Hand,...
```
conda create --name testai
source activate testai
conda install -y bcolz

conda upgrade -y --all

pip install keras==1.1.0 # --> implies theano
# edit ~/.keras/keras.json: "image_dim_ordering": "th", "backend": "theano"
# downgrade theano
pip install theano==0.8.2
pip install h5py
pip install matplotlib
pip install pillow  # Same as PIL
pip install sklearn
conda install mkl-service # not sure if this is required, but getting warning from notebook
```
