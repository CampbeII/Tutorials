# Virtualization

## Hypervisors
provides the ability to create an abstraction layer between hardware and software. 

Type 1 hypervisors
- bare metal
- abstraction layer between hardware and the virtual machine without a common OS.
- lightweight & designed for scale
- ESXi, Proxmox, VMware vSphere, Xen, KVM

Type 2 hypervisors
- hosted hypervisors
- abstraction layer from a software application built on the host OS.
- less scalable
- uses a gui or management interface
- VMware workstation, fusion, virtualbox, parallels, QEMU

## Containers
Hypervisors encounter issues when scaling lightweight applications. 
- Not completely abstracted from the host OS
- Independent file system.
- take a portion of resources from the host
- portable
- uses a container engine (like docker) 

## Kubernetes
Extends the features and capabilities of traditional virtualization models like hypervisors and containers.
1. Horizontal Scaling
Adding devices or machines to handle increased workload instead of CPU or RAM

2. Extensibility
Clusters can be modified dynamically without affecting containers outside the group

3. Self-Healing
User defined health checks can act as the trigger for K8s to reset, replace, reschedule and kill non-functioning containers.

4. Automated rollouts / rollbacks
It is very easy to deploy or revert changes to clusters.

## Example
Ensure all clusters are started
```sh
minikube start
```

### Finding Resources

Services:
```sh
kubectl get services
kubectl get services --sort-by=.metadata.name
```

Pods:
```sh
kubectl get pods
kubectl get pods -o wide
kubectl get pod my-pod -o yaml
kubectl get pods --all-namepsaces
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'
kubectl get pods --field-selector=status.phase=Running

# System Pods
kubectl get pods -A 
```

Events:
```sh
kubectl events --types=Warning
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl get deployment my-dep
```

Replica Sets:
```sh
kubectl get rs
```

Delete deployment:
```sh
kubectl delete deploy <deployment_name> -n <namespace>
```
