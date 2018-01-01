#!/bin/bash

source CONFIG.env

# REGION=$(aws configure get region)
# echo "Configured AWS region: ${REGION}"

SPOT_PRICES=$(aws ec2 describe-spot-price-history \
  --instance-types ${INST_TYPE} \
  --start-time=$(date +%s) \
  --product-descriptions="Linux/UNIX")

# echo spot prices: $SPOT_PRICES

LEAST=$(echo $SPOT_PRICES  | jq '[.SpotPriceHistory[]|{az:.AvailabilityZone,price:.SpotPrice|tonumber}]|sort_by(.price)[0]')
# echo ${LEAST}
BID_PRICE=$(echo $LEAST | jq .price)
# AZ=$(echo $LEAST | jq -r .az)
REGION=$(echo $LEAST | jq -r .az[:-1])
ZONE=$(echo $LEAST | jq -r .az[-1:])

echo "We will bid for instance: ${INST_TYPE} @ ($REGION - $ZONE) for \$${BID_PRICE}"

# --amazonec2-request-spot-instance
# --amazonec2-spot-price 0.25
# --amazonec2-open-port


# docker-machine create --driver amazonec2 \
#                       --amazonec2-region us-west-2 \
#                       --amazonec2-zone b \
#                       --amazonec2-ami ami-efd0428f \
#                       --amazonec2-instance-type p2.xlarge \
#                       --amazonec2-vpc-id vpc-*** \
#                       --amazonec2-access-key AKI*** \
#                       --amazonec2-secret-key *** \
#                       aws01
