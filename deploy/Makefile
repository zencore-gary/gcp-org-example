ENVIRONMENT ?= dev
K8S_NS := blockapt
CHART_PATH := charts/blockapt
VALUES_PATH := blockapt/values

master:
	helm -n ${K8S_NS} upgrade master ${CHART_PATH} --values ${VALUES_PATH}/${ENVIRONMENT}/master.yaml --install

logger:
	helm -n ${K8S_NS} upgrade logger ${CHART_PATH} --values ${VALUES_PATH}/${ENVIRONMENT}/logger.yaml --install

search-logger:
	helm -n ${K8S_NS} upgrade search-logger ${CHART_PATH} --values ${VALUES_PATH}/${ENVIRONMENT}/search-logger.yaml --install

graphs:
	helm -n ${K8S_NS} upgrade graphs ${CHART_PATH} --values ${VALUES_PATH}/${ENVIRONMENT}/graphs.yaml --install

socket:
	helm -n ${K8S_NS} upgrade socket ${CHART_PATH} --values ${VALUES_PATH}/${ENVIRONMENT}/socket.yaml --install

pdf:
	helm -n ${K8S_NS} upgrade pdf ${CHART_PATH} --values ${VALUES_PATH}/${ENVIRONMENT}/pdf.yaml --install

mte:
	helm -n ${K8S_NS} upgrade mte ${CHART_PATH} --values ${VALUES_PATH}/${ENVIRONMENT}/mte.yaml --install
