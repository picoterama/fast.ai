#!/bin/bash

source CONFIG.env


SPOT_PRICES=""
echo "Checking prices for instance type ${INST_TYPE} in all regions"
for r in $(aws ec2 describe-regions | jq -r .Regions[].RegionName); do

  # echo "Checking prices in region ${r}"

  export AWS_DEFAULT_REGION=$r
  SPOT_PRICES_FOR_REGION=$(aws ec2 describe-spot-price-history \
    --instance-types ${INST_TYPE} \
    --start-time=$(date +%s) \
    --product-descriptions="Linux/UNIX")

  # echo "${SPOT_PRICES_FOR_REGION}"
  # echo
  LEAST_FOR_REGION=$(echo $SPOT_PRICES_FOR_REGION  | jq '[.SpotPriceHistory[]|{az:.AvailabilityZone,price:.SpotPrice|tonumber}]|sort_by(.price)[0]')
  echo " -least price in region ${r}: $( echo $LEAST_FOR_REGION| jq .price)"

  # this null test doen not work
  if [ "$SPOT_PRICES_FOR_REGION" == "null" ]; then
    echo "No spot price for ${INST_TYPE} in region $r"
  else
    if [ "$SPOT_PRICES" == "" ]; then    # prepend with '['
      SPOT_PRICES="[${SPOT_PRICES_FOR_REGION}"
    else                                 # prepend with ','
      SPOT_PRICES="${SPOT_PRICES},${SPOT_PRICES_FOR_REGION}"
    fi
    # echo ${SPOT_PRICES}
  fi

done

# append last ']'
SPOT_PRICES="${SPOT_PRICES}]"
# echo
# echo spot prices: $SPOT_PRICES

echo
LEAST=$(echo $SPOT_PRICES  | jq '[.[].SpotPriceHistory[]|{az:.AvailabilityZone,price:.SpotPrice|tonumber}]|sort_by(.price)[0]')
BID_PRICE=$(echo $LEAST | jq .price)
# AZ=$(echo $LEAST | jq -r .az)
REGION=$(echo $LEAST | jq -r .az[:-1])
ZONE=$(echo $LEAST | jq -r .az[-1:])

echo "We will bid for instance: ${INST_TYPE} @ ($REGION - $ZONE) for \$${BID_PRICE}"

