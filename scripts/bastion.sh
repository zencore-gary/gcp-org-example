#!/bin/bash

## Bastion setup for smoother debug interacting with the Kubernetes API

dpkg_arch=$(dpkg --print-architecture) # amd64

dl_path="${HOME}/downloads"
install_path='/usr/local/bin'

mkdir -pv "${dl_path}"
pushd "${dl_path}" || exit 1

sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin jq kubectl nano vim wget

# https://github.com/helm/helm/releases
helm_version='3.15.3'
# https://github.com/kubecolor/kubecolor/releases
kubecolor_version='0.3.3'
# https://github.com/derailed/k9s/releases
k9s_version='0.32.5'
# https://github.com/derailed/popeye/releases
popeye_version='0.21.3'
# https://github.com/helmfile/helmfile/releases
helmfile_version='0.166.0'

# Helm
wget -N "https://get.helm.sh/helm-v${helm_version}-linux-${dpkg_arch}.tar.gz"
sudo tar -xvf "helm-v${helm_version}-linux-${dpkg_arch}.tar.gz" --strip-components=1 -C "${install_path}" --totals "linux-${dpkg_arch}/helm"

# Popeye
wget -N "https://github.com/derailed/popeye/releases/download/v${popeye_version}/popeye_linux_${dpkg_arch}.tar.gz"
sudo tar -xvf "popeye_linux_${dpkg_arch}.tar.gz"  -C "${install_path}" --totals popeye

# K9s
wget -N "https://github.com/derailed/k9s/releases/download/v${k9s_version}/k9s_Linux_${dpkg_arch}.tar.gz"
sudo sudo tar -xvf "k9s_Linux_${dpkg_arch}.tar.gz" -C "${install_path}" --totals k9s

# Kubecolor
wget -N "https://github.com/kubecolor/kubecolor/releases/download/v${kubecolor_version}/kubecolor_${kubecolor_version}_linux_${dpkg_arch}.tar.gz"
sudo tar -xvf "kubecolor_${kubecolor_version}_linux_${dpkg_arch}.tar.gz" -C "${install_path}" --totals kubecolor

# Helmfile
wget -Nq "https://github.com/helmfile/helmfile/releases/download/v${helmfile_version}/helmfile_${helmfile_version}_linux_${dpkg_arch}.tar.gz"
sudo tar -xvf "helmfile_${helmfile_version}_linux_${dpkg_arch}.tar.gz" -C /usr/local/bin --totals helmfile

# Enforce permissions on installed binaries
sudo chown root:root "${install_path}/"*
sudo chmod 755 "${install_path}/"*

# List install binaries
ls -alh "${install_path}"

cat <<EOF>> "${HOME}/.bashrc"
# Custom
alias ll='ls -alh'

# k as kubecolor with kubectl completion
source <(kubectl completion bash)
alias k=kubecolor
complete -o default -F __start_kubectl k

source <(helm completion bash)
source <(k9s completion bash)
source <(helmfile completion bash)
source <(popeye completion bash)

export EDITOR='nano'
EOF

popd || exit 1
