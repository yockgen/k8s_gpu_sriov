provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }

}

resource "helm_release" "synbench_wl" {

  for_each = { 
	"synbench01" = { id = "test01", idPod = "synbench01" , gpu  = "/dev/dri/card1" } 
	"synbench02" = { id = "test02", idPod = "synbench02" , gpu  = "/dev/dri/card2" } 
	"synbench03" = { id = "test03", idPod = "synbench03" , gpu  = "/dev/dri/card3" } 
	"synbench04" = { id = "test04", idPod = "synbench04" , gpu  = "/dev/dri/card4" } 
	"synbench05" = { id = "test05", idPod = "synbench05" , gpu  = "/dev/dri/card5" } 
	"synbench06" = { id = "test06", idPod = "synbench06" , gpu  = "/dev/dri/card6" } 

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

  set {
    name = "user"
    value = var.username
  }

  depends_on = [
    null_resource.gpu_sriov_setup
  ]
}


