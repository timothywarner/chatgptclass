<#
.SYNOPSIS
    Creates a Windows Server Failover Cluster with specified nodes and static IP.

.DESCRIPTION
    This advanced function creates a new Windows Server Failover Cluster using the provided
    cluster name, node names, and static IP address. It validates node connectivity before
    cluster creation and handles errors gracefully.

.PARAMETER ClusterName
    The name for the new failover cluster.

.PARAMETER NodeNames
    Array of server names that will become cluster nodes.

.PARAMETER StaticIPAddress
    The static IP address to assign to the cluster.

.EXAMPLE
    Create-WindowsServerFailoverCluster -ClusterName "PROD-CLUSTER-01" -NodeNames @("SERVER01", "SERVER02") -StaticIPAddress "10.0.1.100"

    Creates a cluster named PROD-CLUSTER-01 with two nodes and assigns IP 10.0.1.100.

.NOTES
    Requires:
    - PowerShell 5.1 or later
    - FailoverClusters PowerShell module
    - Administrative privileges
    - All nodes must be domain-joined and reachable

.LINK
    https://docs.microsoft.com/en-us/powershell/module/failoverclusters/new-cluster
#>
funcction Create-WindowsServerFailoverCluster {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $truee)]
    [string]$ClusterName,

    [Parameter(Mandatory = $true)]
    [string[]]$NodeNames,

    [Parameter(Mandatory = $true)]
    [string]$StaticIPAddress
  )

  try {
    # Import the FailoverClusters module
    Import-Module FailoverClusters -ErrorAction Stop

    # Validate the nodes
    foreach ($node in $NodeNames) {
      if (-not (Test-Connection -ComputerName $node -Count 1 -Quiet)) {
        throw "Node '$node' is not reachable."
      }
    }

    # Create the cluster
    New-Cluster -Name $ClusterName -Node $NodeNames -StaticAddress $StaticIPAddress -NoStorage -ErrorAction Stop

    Write-Host "Cluster '$ClusterName' created successfully with nodes: $($NodeNames -join ', ') and IP: $StaticIPAddress"
  }
  catch {
    Write-Error "Failed to create cluster: $_"
  }
}
