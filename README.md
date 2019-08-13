# Practical Deep Learning For Coders

Taught by Jeremy Howard

This is a reboot for v3, see `./v1` for old notes.

## Reboot for v3

## Links and References

- [fast.ai Homepage](https://www.fast.ai/)
- [Course Home](https://course.fast.ai/)
- [Setup GCP](https://course.fast.ai/start_gcp.html)

## Setup

I will use GCP/imetrical. No local resources yet, maybe docker later.

I created as project named `fast-ai-20190812`

### Auth account

```bash
# gcloud settings
gcloud auth list
gcloud config set account `daniel.lauzon@imetrical.com`
```

### Project/Region/Zone

```bash
# tl;dr
gcloud config set project fast-ai-20190812
gcloud config set compute/region northamerica-northeast1
gcloud config set compute/zone northamerica-northeast1-b

# default config kept in  ~/.config/gcloud/configurations/config_default
# get configured values:
gcloud info
gcloud config list

gcloud config set project fast-ai-20190812

gcloud compute regions list
gcloud config set compute/region northamerica-northeast1

gcloud compute zones list
gcloud config set compute/zone northamerica-northeast1-b
```

### Create instance

Needed to adjust IAM Admin/Quotas/ComputeEngin GPUs (all regions): 0->1
which requires approval.

```bash
# recommended
export IMAGE_FAMILY="pytorch-latest-gpu"
export INSTANCE_NAME="fast-ai-gpu-01"
export INSTANCE_TYPE="n1-highmem-8"
export ACCELERATOR="type=nvidia-tesla-p4,count=1"

gcloud compute instances create ${INSTANCE_NAME} \
  --image-family="${IMAGE_FAMILY}" \
  --image-project=deeplearning-platform-release \
  --maintenance-policy=TERMINATE \
  --accelerator="${ACCELERATOR}" \
  --machine-type="${INSTANCE_TYPE}" \
  --boot-disk-size=200GB \
  --metadata="install-nvidia-driver=True" \
  --preemptible

# budget
export IMAGE_FAMILY="pytorch-latest-cpu"
export INSTANCE_NAME="fast-ai-cpu-01"
export INSTANCE_TYPE="n1-highmem-4"
# k80 not available in northamerica-northeast1-[a,b,c]
# gcloud compute accelerator-types list|grep northam
# export ACCELERATOR="type=nvidia-tesla-k80,count=1"

gcloud compute instances create ${INSTANCE_NAME} \
  --image-family="${IMAGE_FAMILY}" \
  --image-project=deeplearning-platform-release \
  --maintenance-policy=TERMINATE \
  --machine-type="${INSTANCE_TYPE}" \
  --boot-disk-size=200GB \
  --metadata="install-nvidia-driver=True" \
  --preemptible
```

### Accessing the instance

```bash
gcloud compute ssh jupyter@${INSTANCE_NAME} -- -L 8080:localhost:8080
open  http://localhost:8080/tree
```

#### Updating tutorial and environment (on instance)

```bash
cd tutorials/fastai/course-v3
git checkout .
git pull

sudo /opt/anaconda3/bin/conda install -c fastai fastai
```

### Stop/Restart instance

```bash
gcloud compute instances list
gcloud compute instances stop ${INSTANCE_NAME}
gcloud compute instances start ${INSTANCE_NAME}

gcloud compute instances delete ${INSTANCE_NAME}
```
