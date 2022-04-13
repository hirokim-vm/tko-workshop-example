# FROM quay.io/eduk8s/base-environment:master
FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:18882f916ff833872e658bdc00e7fe81b1b921fb3993ce761372805825b155e9

COPY --chown=1001:0 . /home/eduk8s/

RUN mv /home/eduk8s/workshop /opt/workshop

RUN fix-permissions /home/eduk8s
