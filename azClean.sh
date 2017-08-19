#!/bin/bash

# Get the list of locked resources
LOCK=`az lock list --query "[].id" -o tsv`

# Network Interface
az network nic list --query "[?virtualMachine==null|?networkSecurityGroup==null].id" -o tsv | while read nic
do
    # Check whether the resource is locked.
    echo "$LOCK" | grep $nic -q
    # Delete nic.
    if test $? -eq 1 ; then
        echo "Delete $nic"
        az network nic delete --ids $nic
    fi
done

# Public IP address
az network public-ip list --query "[?ipConfiguration==null].id" -o tsv | while read pip
do
    # Check whether the resource is locked.
    echo "$LOCK" | grep $pip -q
    # Delete pip.
    if test $? -eq 1 ; then
        echo "Delete $pip"
        az network public-ip delete --ids $pip
    fi
done

# Managed Disk
az disk list --query "[?managedBy==null].id" -o tsv | while read disk
do
    # Check whether the resource is locked.
    echo "$LOCK" | grep $disk -q
    # Delete disk.
    if test $? -eq 1 ; then
        echo "Delete $disk"
        az disk delete --ids $disk --yes --no-wait
    fi
done

# NSG

az network nsg list --query "[?subnets==null]|[?networkInterfaces==null].id" -o tsv | while read nsg
do
    # Check whether the resource is locked.
    echo "$LOCK" | grep $nsg -q
    # Delete nsg.
    if test $? -eq 1 ; then
        echo "Delete $nsg"
        az network nsg delete --ids $nsg
    fi
done