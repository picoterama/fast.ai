# This is to develop locally on Mac OSX

## Anaconda

Download and install Anaconda 2.7 from the [Anaconda download site](https://www.anaconda.com/download/#macos).

To get the lesson1 notebook to work, we replicated the necessary versions of keras and theano (by discovering what was on the p2/t2 AMI's)

Also used these as hints:
- Following: https://github.com/fastai/courses/blob/master/setup/install-gpu.sh#L27:1
- As per http://wiki.fast.ai/index.php/Local_install_(Windows_only:cpu)

## Setup
These commands create the required environment for lesson1
```
conda env create -f environment.yml
source activate fastai
conda info --envs
```

Replace the contents of ` ~/.keras/keras.json ` with:
```
{
    "image_dim_ordering": "th", 
    "epsilon": 1e-07, 
    "floatx": "float32", 
    "backend": "theano"
}
```

## Test/Validate
Smoke test: open the test/test-notebook.ipynb
```
jupyter notebook
```

## Cleanup
This deletes our environment
```
source deactivate
conda env remove --name fastai
```

For fuller cleanup you may want to delete
- `~/.keras`
- `~/.theano`