resource "null_resource" "gpu_sriov_setup" {

  for_each = var.nodes

  provisioner "remote-exec" {

    connection {    
      type     = "ssh"
      user     = var.username
      password = var.pwd      
      host = each.value.ip       

    }

    inline = [
      "echo 0 | sudo tee /sys/class/drm/card0/device/sriov_numvfs",
      "export numvfs=$(cat /sys/class/drm/card0/device/sriov_totalvfs)",     
      "echo $numvfs | sudo tee /sys/class/drm/card0/device/sriov_numvfs",

    ]
  }

}


provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }

}

resource "helm_release" "yockgen_gpu" {

  for_each = { 
	"yockgen01" = { id = "test01", idPod = "synbench01" , gpu  = "/dev/dri/card1" } 
	"yockgen02" = { id = "test02", idPod = "synbench02" , gpu  = "/dev/dri/card2" } 
	"yockgen03" = { id = "test03", idPod = "synbench03" , gpu  = "/dev/dri/card3" } 
	"yockgen04" = { id = "test04", idPod = "synbench04" , gpu  = "/dev/dri/card4" } 
	"yockgen05" = { id = "test05", idPod = "synbench05" , gpu  = "/dev/dri/card5" } 
	"yockgen06" = { id = "test06", idPod = "synbench06" , gpu  = "/dev/dri/card6" } 

  }


  name = each.key
  chart = var.helm_chart
  namespace = "default"
  
  set {
    name  = "gpu"
    value = each.value.gpu
  }

  set {
    name  = "id"
    value = each.value.id

  }

  set {
    name  = "idPod"
    value = each.value.idPod

  }
}


