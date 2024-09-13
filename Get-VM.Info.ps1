# used to gather vCPU, Memory, and Disk space allocation information from all VMs on a Hyper-V Cluster

$Cluster = Read-Host "Enter the name of the cluster"

$VMData = @()

$Hosts = Get-ClusterNode -Cluster $Cluster

foreach ($node in $Hosts) {
    # Get the VMs running on the current node
    $vms = Get-VM -ComputerName $node.Name
    
    foreach ($vm in $vms) {
        # Get vCPU count
        $cpuCount = $vm.ProcessorCount
        
        # Get allocated memory (in MB)
        $memoryAllocated = $vm.MemoryAssigned
        
        # Get the virtual hard drives associated with the VM
        $virtualDisks = Get-VMHardDiskDrive -VM $vm
        
        # Initialize disk size variable
        $totalDiskSize = 0
        
        foreach ($disk in $virtualDisks) {
            $diskPath = $disk.Path
            
            # Use Get-Item to retrieve the file size directly from the filesystem
            $fileInfo = Get-Item -Path $diskPath
            
            # Get the file size (in GB)
            $diskSize = $fileInfo.Length / 1GB
            $totalDiskSize += $diskSize
        }
        
        # Create a custom object with the VM info
        $vmInfo = [PSCustomObject]@{
            VMName          = $vm.Name
            vCPUCount       = $cpuCount
            MemoryAllocated = $memoryAllocated / 1MB  # Convert to MB
            DiskSizeGB      = [math]::Round($totalDiskSize, 2)
        }
        
        # Add VM info to the array
        $vmData += $vmInfo
    }
}

Write-Output $VMData