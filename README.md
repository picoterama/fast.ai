# Practical Deep Learning For Coders
Taught by Jeremy Howard

## TODO
- Verify impact on scripts of output text

## Operation
- ssh into host
```
jupyter notebook
```

## Setup 
### Bring up a GPU instance
The first time this is run it creates a keypair: `~/.ssh/aws-key-fast-ai.pem`.

The scripts require `output = text` in `~/.aws/config`

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


## References
- [Course repo on GitHub](https://github.com/fastai/courses/tree/master/setup)
- http://course.fast.ai/index.html