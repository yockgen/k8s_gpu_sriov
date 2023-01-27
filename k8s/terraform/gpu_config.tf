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
