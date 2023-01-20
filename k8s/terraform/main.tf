resource "null_resource" "gpu_sriov_setup" {

  for_each = var.nodes

  connection {    
      type     = "ssh"
      user     = var.username
      password = var.pwd      
      host = each.value.ip       
  }

  provisioner "remote-exec" {
    inline = [
      "echo 0 | sudo tee /sys/class/drm/card0/device/sriov_numvfs",
      "export numvfs=$(cat /sys/class/drm/card0/device/sriov_totalvfs)",     
      "echo $numvfs | sudo tee /sys/class/drm/card0/device/sriov_numvfs",

    ]
  }

  provisioner "file" {  
    source      = "/data/synbench/k8s/terraform/scripts/gpu_sriov_setting.sh"
    destination = "/tmp/gpu_sriov_settings.sh"
  }

  provisioner "file" {      
    content     = "${jsonencode(var.gpu_sriov_config)}"
    destination = "/tmp/gpu_sriov_config.json"
  }


  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/gpu_sriov_settings.sh",
      "sudo /tmp/gpu_sriov_settings.sh",
      "sudo sysctl fs.inotify.max_user_watches=524288",
      "sudo sysctl fs.inotify.max_user_instances=512"
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

  set {
    name = "user"
    value = var.username
  }

  depends_on = [
    null_resource.gpu_sriov_setup
  ]
}


