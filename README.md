# azureRM-resource-cleaner

Shell script which deletes no-use resouces.

## Usage

Use Azure Cloud Shell.

```
git clone https://github.com/kongou-ae/azureRM-resource-cleaner
cd azureRM-resource-cleaner
./azClean.shall
```

## Notice

- This script supports these resources
    - Network Interface
    - Public IP Address
    - Managed Disk
- "no-use" is that the resoure doesn't relate other resource. If you keep no releted resource, please lock the resource.
