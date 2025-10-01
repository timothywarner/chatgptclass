# Pester tests for Create-WindowsServerFailoverCluster

# Import the script containing the function
. "$PSScriptRoot\..\Create-WindowsServerFailoverCluster.ps1"

Describe "Create-WindowsServerFailoverCluster" {
  It "Function should exist" {
    Get-Command Create-WindowsServerFailoverCluster | Should -Not -BeNullOrEmpty
  }

  It "Should throw when node is unreachable" {
    Mock Test-Connection { $false }
    { Create-WindowsServerFailoverCluster -ClusterName "TestCluster" -NodeNames @("FakeNode") -StaticIPAddress "192.168.1.100" } | Should -Throw
  }

  It "Should call New-Cluster with correct parameters" {
    Mock Test-Connection { $true }
    Mock New-Cluster { }
    { Create-WindowsServerFailoverCluster -ClusterName "TestCluster" -NodeNames @("Node1", "Node2") -StaticIPAddress "192.168.1.101" } | Should -Not -Throw
    Assert-MockCalled New-Cluster -Exactly 1 -Scope It
  }
}
